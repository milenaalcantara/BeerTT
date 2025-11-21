//
//  BeerDetailPresenter.swift
//  Beer
//
//  Created by Milena Alcântara on 20/11/25.
//

import UIKit

public protocol BeerDetailPresenterProtocol {
    func presentDetail(response: BeerDetailModel.Response)
    func presentError(_ error: Error)
    func presentFavoriteStatus(isFavorite: Bool)
}

final class BeerDetailPresenter: BeerDetailPresenterProtocol {
    weak var viewController: BeerDetailDisplayProtocol?

    func presentDetail(response: BeerDetailModel.Response) {

        let viewModel = BeerDetailModel.ViewModel(
            title: response.beer.title,
            subtitle: response.beer.type,
            imageName: response.beer.imageName,
            description: response.beer.description,
            isFavorite: response.isFavorite
        )

        viewController?.displayDetail(viewModel)
    }
    
    func presentFavoriteStatus(isFavorite: Bool) {
        viewController?.displayFavoriteStatus(isFavorite)
    }

    func presentError(_ error: Error) {
        viewController?.displayError(error.localizedDescription)
    }
}
