//
//  BeerListRouter.swift
//  Beer
//
//  Created by Milena Alcântara on 17/11/25.
//

import UIKit

protocol BeerListRoutingProtocol {
    func routeToDetails(beer: Beer)
}

final class BeerListRouter: BeerListRoutingProtocol {
    weak var viewController: UIViewController?
    var coordinator: BeerCoordinator?

    func routeToDetails(beer: Beer) {
        // prefer coordinator if available
        if let coordinator = coordinator {
            coordinator.startBeerDetail(beer: beer)
            return
        }

        // fallback: build and push detail directly using BeerDetailConfigurator if coordinator not set
        let detailVC = BeerDetailConfigurator.makeModule(beer: beer)
        viewController?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
