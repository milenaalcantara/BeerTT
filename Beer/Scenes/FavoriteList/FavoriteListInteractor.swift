//
//  FavoriteListInteractor.swift
//  Beer
//
//  Created by Milena Alcântara on 21/11/25.
//

import Foundation

protocol FavoriteListInteractorProtocol {
    func fetchFavorites()
    func didSelectFavorite(at index: Int)
}

final class FavoriteListInteractor: FavoriteListInteractorProtocol {
    
    var presenter: FavoriteListPresenterProtocol?
    private let store: CoreDataFavoriteStoreProtocol
    
    private var favorites: [Beer] = []
    
    init(store: CoreDataFavoriteStoreProtocol = CoreDataFavoriteStore()) {
        self.store = store
    }
    
    func fetchFavorites() {
        let beers = store.fetchFavorites()
        self.favorites = beers
        
        if beers.isEmpty {
            presenter?.presentEmptyState()
        } else {
            presenter?.presentFavorites(beers: beers)
        }
    }
    
    func didSelectFavorite(at index: Int) {
        guard favorites.indices.contains(index) else { return }
        let selectedBeer = favorites[index]
        presenter?.presentSelectedFavorite(beer: selectedBeer)
    }
}
