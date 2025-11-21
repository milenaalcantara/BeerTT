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
    func presentLoading(_ isLoading: Bool)
    func presentFavoriteStatus(isFavorite: Bool)
}

final class BeerDetailPresenter: BeerDetailPresenterProtocol {
    weak var viewController: BeerDetailDisplayProtocol?

    func presentDetail(response: BeerDetailModel.Response) {

        let vm = BeerDetailModel.ViewModel(
            title: response.beer.title,
            subtitle: response.beer.type,
            imageName: response.beer.imageName ?? "beer_default",
            description: response.beer.description ?? "beer_default",
            isFavorite: response.isFavorite
        )

        viewController?.displayDetail(vm)
    }
    
    func presentFavoriteStatus(isFavorite: Bool) {
        viewController?.displayFavoriteStatus(isFavorite)
    }

    func presentError(_ error: Error) {
        viewController?.displayError(error.localizedDescription)
    }

    func presentLoading(_ isLoading: Bool) {
        viewController?.displayLoading(isLoading)
    }
}
