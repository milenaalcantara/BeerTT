//
//  BeerDetailInteractor.swift
//  Beer
//
//  Created by Milena Alcântara on 20/11/25.
//

import Foundation

protocol BeerDetailBusinessProtocol {
    func loadDetail()
    func toggleFavorite()
}

final class BeerDetailInteractor: BeerDetailBusinessProtocol {

    var presenter: BeerDetailPresenterProtocol?
    var worker: BeerDetailWorkerProtocol

    private let beer: Beer

    init(beer: Beer, worker: BeerDetailWorkerProtocol = BeerDetailWorker()) {
        self.beer = beer
        self.worker = worker
    }

    func loadDetail() {
        let isFav = worker.isFavorite(id: beer.id)
        presenter?.presentDetail(response: .init(beer: beer, isFavorite: isFav))
    }

    func toggleFavorite() {
        let isFav = worker.isFavorite(id: beer.id)

        if isFav {
            worker.removeFavorite(id: beer.id)
        } else {
            worker.addFavorite(beer)
        }

        presenter?.presentDetail(response: .init(beer: beer, isFavorite: !isFav))
    }
}
