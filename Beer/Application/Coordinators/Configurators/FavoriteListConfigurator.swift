//
//  FavoriteListConfigurator.swift
//  Beer
//
//  Created by Milena Alcântara on 21/11/25.
//

import UIKit

enum FavoritesListConfigurator {
    static func makeModule() -> UIViewController {
        let view = FavoritesListViewController()
        let interactor = FavoriteListInteractor()
        let presenter = FavoritesListPresenter()
        let router = FavoriteListRouter()
        
        view.interactor = interactor
        view.router = router
        interactor.presenter = presenter
        presenter.viewController = view
        presenter.router = router
        router.viewController = view
        
        return view
    }
}
