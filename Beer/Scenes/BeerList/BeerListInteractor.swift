//
//  BeerListInteractor.swift
//  Beer
//
//  Created by Milena Alcântara on 17/11/25.
//

import Foundation

public protocol BeerListInteractorProtocol: AnyObject {
    func fetchBeers(request: BeerListModel.Request)
    func didSelectBeer(at index: Int)
}

final class BeerListInteractor: BeerListInteractorProtocol {

    var presenter: BeerListPresenterProtocol?
    private let worker: BeerListWorkerProtocol
    
    private var allBeers: [Beer] = []
    private var currentPage = 1
    private var isFetching = false
    private var currentQuery: String?
    private var isEndOfList = false
    
    init(worker: BeerListWorkerProtocol) {
        self.worker = worker
    }

    func fetchBeers(request: BeerListModel.Request) {
        if isFetching { return }
        
        var pageToFetch = currentPage
        var queryToFetch = currentQuery
        var shouldReplace = false
        
        switch request.type {
        case .initialLoad:
            currentPage = 1
            pageToFetch = 1
            queryToFetch = nil
            currentQuery = nil
            shouldReplace = true
            isEndOfList = false
            
        case .pagination:
            if isEndOfList { return }
            pageToFetch = currentPage
            
        case .search(let newQuery):
            let normalizedQuery = newQuery.trimmingCharacters(in: .whitespacesAndNewlines)
            if normalizedQuery == (currentQuery ?? "") { return }

            currentPage = 1
            pageToFetch = 1
            queryToFetch = normalizedQuery.isEmpty ? nil : normalizedQuery
            currentQuery = queryToFetch
            shouldReplace = true
            isEndOfList = false
        }
        
        isFetching = true
        presenter?.presentLoadingState()
        
        worker.fetchBeers(page: pageToFetch, query: queryToFetch) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isFetching = false
                
                switch result {
                case .success(let dtos):
                    if shouldReplace {
                        self.allBeers = []
                    }

                    if dtos.isEmpty {
                        self.presenter?.presentEmptyState()
                        return
                    }
                    
                    let enrichedBeers = dtos.map { dto -> Beer in
                        let id = dto.id ?? UUID().uuidString
                        
                        return Beer(
                            id: id,
                            title: dto.name ?? "Name",
                            type: dto.brewery_type ?? "Type",
                            description: MockDescriptionProvider.description(),
                            imageName: ImageProvider.imageName(),
                            isFavorite: false
                        )
                    }

                    if shouldReplace {
                        self.allBeers = enrichedBeers
                    } else {
                        self.allBeers.append(contentsOf: enrichedBeers)
                    }
                    
                    let perPage = 20
                    if dtos.count < perPage {
                        self.isEndOfList = true
                    } else {
                        self.currentPage += 1
                    }
                    
                    let response = BeerListModel.Response(
                        beers: self.allBeers,
                        isNewDataSet: shouldReplace,
                        isEndOfList: self.isEndOfList
                    )
                    
                    self.presenter?.presentBeers(response: response)
                    
                case .failure(let error):
                    self.presenter?.presentError(error: error)
                }
            }
        }
    }

    func didSelectBeer(at index: Int) {
        guard let selectedBeer = allBeers[safe: index] else { return }
        presenter?.presentSelectedBeer(beer: selectedBeer)
    }
}
