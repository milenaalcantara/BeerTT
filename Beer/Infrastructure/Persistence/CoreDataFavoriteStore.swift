//
//  CoreDataFavoriteStore.swift
//  Beer
//
//  Created by Milena Alcântara on 20/11/25.
//

import CoreData
import UIKit

protocol CoreDataFavoriteStoreProtocol {
    func isFavorite(id: String) -> Bool
    func addFavorite(_ beer: Beer)
    func removeFavorite(id: String)
    func fetchFavorites() -> [Beer]
}

final class CoreDataFavoriteStore: CoreDataFavoriteStoreProtocol {

    private let stack: CoreDataStack

    init(stack: CoreDataStack = .shared) {
        self.stack = stack
    }

    func isFavorite(id: String) -> Bool {
        let req = FavoriteBeer.fetchRequest()
        req.predicate = NSPredicate(format: "id == %@", id)
        return stack.fetch(req).isEmpty == false
    }

    func addFavorite(_ beer: Beer) {
        let fav = stack.create(FavoriteBeer.self)
        fav.id = beer.id
        fav.title = beer.title
        fav.type = beer.type
        fav.desc = beer.description ?? "default Description"
        fav.imageName = beer.imageName ?? "beer_default"
        stack.saveContext()
    }

    func removeFavorite(id: String) {
        let req = FavoriteBeer.fetchRequest()
        req.predicate = NSPredicate(format: "id == %@", id)
        stack.deleteAll(req)
        stack.saveContext()
    }

    func fetchFavorites() -> [Beer] {
        let items = stack.fetch(FavoriteBeer.fetchRequest())
        return items.map {
            Beer(id: $0.id,
                 title: $0.title,
                 type: $0.type,
                 description: $0.desc,
                 imageName: $0.imageName)
        }
    }
}
