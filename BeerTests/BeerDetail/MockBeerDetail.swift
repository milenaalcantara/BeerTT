//
//  MockBeerDetailWorker.swift
//  Beer
//
//  Created by Milena Alcântara on 20/11/25.
//

import Beer

final class MockBeerDetailWorker: BeerDetailWorkerProtocol {
    
    var isFavoriteResult = false
    var didAddFavorite = false
    var didRemoveFavorite = false

    var lastAddedBeer: Beer?
    var lastRemovedId: String?

    func isFavorite(id: String) -> Bool {
        return isFavoriteResult
    }

    func addFavorite(_ beer: Beer) {
        didAddFavorite = true
        lastAddedBeer = beer
    }

    func removeFavorite(id: String) {
        didRemoveFavorite = true
        lastRemovedId = id
    }
}


final class MockBeerDetailPresenter: BeerDetailPresenterProtocol {

    var didPresentBeer = false
    var receivedBeer: Beer?
    var receivedIsFavorite: Bool?

    var didPresentFavoriteStatus = false
    var didPresentLoading = false
    var didPresentError = false
    var receivedLoadingState: Bool?
    var receivedError: Error?

    func presentDetail(response: BeerDetailModel.Response) {
        didPresentBeer = true
        receivedBeer = response.beer
        receivedIsFavorite = response.isFavorite
    }

    func presentFavoriteStatus(isFavorite: Bool) {
        didPresentFavoriteStatus = true
        receivedIsFavorite = isFavorite
    }

    func presentLoading(_ isLoading: Bool) {
        didPresentLoading = true
        receivedLoadingState = isLoading
    }

    func presentError(_ error: Error) {
        didPresentError = true
        receivedError = error
    }
}

final class MockBeerDetailViewController: BeerDetailDisplayProtocol {
    
    var didDisplayBeer = false
    var didUpdateFavorite = false
    var didDisplayLoading = false
    var didDisplayError = false

    var receivedViewModel: BeerDetailModel.ViewModel?
    var receivedIsFavorite: Bool?
    var receivedLoadingState: Bool?
    var receivedErrorMessage: String?

    func displayDetail(_ viewModel: BeerDetailModel.ViewModel) {
        didDisplayBeer = true
        receivedViewModel = viewModel
    }

    func displayFavoriteStatus(_ isFavorite: Bool) {
        didUpdateFavorite = true
        receivedIsFavorite = isFavorite
    }

    func displayLoading(_ isLoading: Bool) {
        didDisplayLoading = true
        receivedLoadingState = isLoading
    }

    func displayError(_ message: String) {
        didDisplayError = true
        receivedErrorMessage = message
    }
}

