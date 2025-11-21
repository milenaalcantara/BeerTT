//
//  BeerListInteractor.swift
//  Beer
//
//  Created by Milena Alcântara on 17/11/25.
//

import Foundation

protocol BeerListInteractorProtocol {
    func fetchBeers(request: BeerListModel.Request)
    func didSelectBeer(at index: Int)
}

final class BeerListInteractor: BeerListInteractorProtocol {

    var presenter: BeerListPresenterProtocol?
    private let worker: BeerListWorkerProtocol
    private var beers: [BeerDTO] = []

    init(worker: BeerListWorkerProtocol) {
        self.worker = worker
    }

    func fetchBeers(request: BeerListModel.Request) {
        worker.fetchBeers(page: request.page, query: request.query) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let dtos):
                self.beers = dtos
                let response = BeerListModel.Response(beers: dtos)
                self.presenter?.presentBeers(response: response)
            case .failure(let error):
                self.presenter?.presentError(error: error)
            }
        }
    }

    func didSelectBeer(at index: Int) {
        guard let dto = beers[safe: index] else { return }
        let beer = Beer(
            id: dto.id ?? UUID().uuidString,
            title: dto.name ?? "Unknown",
            type: dto.brewery_type ?? "Unknown",
            description: "default",
            imageName: ImageProvider.imageName(for: dto.brewery_type ?? "")
        )
        print("Beer: ", beer)
        presenter?.presentSelectedBeer(beer: beer)
    }
}

