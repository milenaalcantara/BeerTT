//
//  BeerListPresenter.swift
//  Beer
//
//  Created by Milena Alcântara on 17/11/25.
//

import Foundation

public protocol BeerListPresenterProtocol {
    func presentBeers(response: BeerListModel.Response)
    func presentSelectedBeer(beer: Beer)
    func presentError(error: Error)
}

protocol BeerListDisplayProtocol: AnyObject {
    func displayBeers(viewModel: BeerListModel.ViewModel)
    func displayError(message: String)
}

final class BeerListPresenter: BeerListPresenterProtocol {
    weak var viewController: BeerListDisplayProtocol?
    var router: BeerListRoutingProtocol?

    func presentBeers(response: BeerListModel.Response) {
        let viewModels = response.beers.map {
            BeerCellViewModel(
                name: $0.name ?? "Unknown",
                type: $0.brewery_type ?? "Unknown",
                imageName: ImageProvider.imageName(for: $0.brewery_type)
            )
        }

        viewController?.displayBeers(
            viewModel: BeerListModel.ViewModel(beers: viewModels)
        )
    }

    func presentSelectedBeer(beer: Beer) {
        router?.routeToDetails(beer: beer)
    }

    func presentError(error: Error) {
        viewController?.displayError(message: error.localizedDescription)
    }
}
