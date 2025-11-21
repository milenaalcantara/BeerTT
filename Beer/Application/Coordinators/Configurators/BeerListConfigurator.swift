//
//  BeerListConfigurator.swift
//  Beer
//
//  Created by Milena Alcântara on 20/11/25.
//

import UIKit

enum BeerListConfigurator {
    
    static func makeModule() -> BeerListViewController {
        let view = BeerListViewController()

        let worker = BeerListWorker(network: NetworkService())
        let presenter = BeerListPresenter()
        let interactor = BeerListInteractor(worker: worker)
        let router = BeerListRouter()

        view.interactor = interactor
        view.router = router

        interactor.presenter = presenter
        presenter.viewController = view
        router.viewController = view

        return view
    }
}
