//
//  FavoriteListPresenter.swift
//  Beer
//
//  Created by Milena Alcântara on 21/11/25.
//

import Foundation

protocol FavoriteListPresenterProtocol {
    func presentFavorites(beers: [Beer])
    func presentEmptyState()
    func presentSelectedFavorite(beer: Beer)
}

final class FavoritesListPresenter: FavoriteListPresenterProtocol {
    weak var viewController: FavoritesListDisplayProtocol?
    var router: FavoriteListRouterProtocol?
    
    func presentFavorites(beers: [Beer]) {
        let viewModels = beers.map { beer in
            BeerCellViewModel(
                name: beer.title,
                type: beer.type,
                imageName: beer.imageName
            )
        }
        viewController?.displayFavorites(viewModel: viewModels)
    }
    
    func presentEmptyState() {
        viewController?.displayEmptyState()
    }
    
    func presentSelectedFavorite(beer: Beer) {
        router?.routeToDetails(beer: beer)
    }
}
