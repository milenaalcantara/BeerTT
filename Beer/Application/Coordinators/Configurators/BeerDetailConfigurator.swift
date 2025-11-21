//
//  BeerDetailConfigurator.swift
//  Beer
//
//  Created by Milena Alcântara on 20/11/25.
//

import UIKit

enum BeerDetailConfigurator {
    static func makeModule(beer: Beer) -> UIViewController {
        let vc = BeerDetailViewController()
        let interactor = BeerDetailInteractor(beer: beer)
        let presenter = BeerDetailPresenter()

        vc.interactor = interactor
        presenter.viewController = vc
        interactor.presenter = presenter

        return vc
    }
}
