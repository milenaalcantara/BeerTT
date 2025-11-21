//
//  BeerListPresenter.swift
//  Beer
//
//  Created by Milena Alcântara on 17/11/25.
//

import Foundation

public protocol BeerListPresenterProtocol: AnyObject {
    func presentBeers(response: BeerListModel.Response)
    func presentSelectedBeer(beer: Beer)
    func presentError(error: Error)
    func presentLoadingState()
    func presentEmptyState()
}

final class BeerListPresenter: BeerListPresenterProtocol {

    weak var viewController: BeerListDisplayProtocol?
    var router: BeerListRoutingProtocol?

    func presentBeers(response: BeerListModel.Response) {
        let viewModels = response.beers.map { beer in
            BeerCellViewModel(
                name: beer.title,
                type: beer.type,
                imageName: beer.imageName
            )
        }
        
        viewController?.displayLoadingState(isLoading: false)
        viewController?.displayBeers(viewModel: BeerListModel.ViewModel(beers: viewModels))
    }

    func presentSelectedBeer(beer: Beer) {
        router?.routeToDetails(beer: beer)
    }

    func presentError(error: Error) {
        viewController?.displayLoadingState(isLoading: false)
        viewController?.displayError()
    }

    func presentLoadingState() {
        viewController?.displayLoadingState(isLoading: true)
    }

    func presentEmptyState() {
        viewController?.displayLoadingState(isLoading: false)
        viewController?.displayEmptyState()
    }
}
