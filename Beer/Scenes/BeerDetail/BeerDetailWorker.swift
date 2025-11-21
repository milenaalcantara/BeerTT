//
//  BeerDetailWorker.swift
//  Beer
//
//  Created by Milena Alcântara on 20/11/25.
//

import Foundation

import Foundation

public protocol BeerDetailWorkerProtocol {
    func isFavorite(id: String) -> Bool
    func addFavorite(_ beer: Beer)
    func removeFavorite(id: String)
}

final class BeerDetailWorker: BeerDetailWorkerProtocol {

    private let store: CoreDataFavoriteStoreProtocol

    init(store: CoreDataFavoriteStoreProtocol = CoreDataFavoriteStore()) {
        self.store = store
    }

    func isFavorite(id: String) -> Bool {
        store.isFavorite(id: id)
    }

    func addFavorite(_ beer: Beer) {
        store.addFavorite(beer)
    }

    func removeFavorite(id: String) {
        store.removeFavorite(id: id)
    }
}
