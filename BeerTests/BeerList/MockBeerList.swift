//
//  Untitled.swift
//  Beer
//
//  Created by Milena Alcântara on 20/11/25.
//

import Beer

final class MockBeerListWorker: BeerListWorkerProtocol {

    var result: Result<[BeerDTO], Error>?

    func fetchBeers(page: Int,
                    query: String?,
                    completion: @escaping (Result<[BeerDTO], Error>) -> Void) {
        completion(result!)
    }
}

final class MockBeerListPresenter: BeerListPresenterProtocol {
    var didReceiveSuccess = false
    var didReceiveError = false
    var didSelectBeer = false
    var selectedBeer: Beer?

    func presentBeers(response: BeerListModel.Response) {
        didReceiveSuccess = true
    }

    func presentError(error: Error) {
        didReceiveError = true
    }

    func presentSelectedBeer(beer: Beer) {
        didSelectBeer = true
        selectedBeer = beer
    }
    
    func presentLoadingState() {
        
    }
    
    func presentEmptyState() {
        
    }
}
