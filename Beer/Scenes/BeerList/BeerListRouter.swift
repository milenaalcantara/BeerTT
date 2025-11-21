//
//  BeerListRouter.swift
//  Beer
//
//  Created by Milena Alcântara on 17/11/25.
//

import UIKit

public protocol BeerListRoutingProtocol: AnyObject {
    func routeToDetails(beer: Beer)
    func routeToFavoriteList()
}

final class BeerListRouter: BeerListRoutingProtocol {
    var coordinator: BeerCoordinator?

    func routeToDetails(beer: Beer) {
        if let coordinator = coordinator {
            coordinator.startBeerDetail(beer: beer)
            return
        }
    }
    
    func routeToFavoriteList() {
        if let coordinator = coordinator {
            coordinator.startFavoriteList()
            return
        }
    }
}
