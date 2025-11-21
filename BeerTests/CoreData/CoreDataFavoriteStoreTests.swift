//
//  CoreDataFavoriteStoreTests.swift
//  Beer
//
//  Created by Milena Alcântara on 20/11/25.
//

import XCTest
import CoreData
@testable import Beer

//final class CoreDataFavoriteStoreTests: XCTestCase {
//
//    var stack: CoreDataStack!
//    var store: CoreDataFavoriteStore!
//
//    override func setUp() {
//        super.setUp()
//
//        // stack IN MEMORY para testes
//        stack = CoreDataStack(modelName: "BeerModel", inMemory: true)
//        store = CoreDataFavoriteStore(stack: stack)
//    }
//
//    override func tearDown() {
//        stack = nil
//        store = nil
//        super.tearDown()
//    }
//
//    // MARK: - Helpers
//
//    private func makeBeer(
//        id: String = "1",
//        name: String = "Beer Test",
//        type: String = "Test Type",
//        description: String = "Description",
//        imageName: String = "beer1"
//    ) -> Beer {
//        Beer(id: id, title: name, type: type, description: description, imageName: imageName)
//    }
//
//    // MARK: - TESTES
//
//    func test_addFavorite_savesBeerCorrectly() {
//        // Given
//        let beer = makeBeer()
//
//        // When
//        store.addFavorite(beer)
//
//        // Then
//        XCTAssertTrue(store.isFavorite(id: "1"))
//    }
//
//    func test_removeFavorite_deletesSuccessfully() {
//        // Given
//        let beer = makeBeer()
//        store.addFavorite(beer)
//        XCTAssertTrue(store.isFavorite(id: beer.id))
//
//        // When
//        store.removeFavorite(id: beer.id)
//
//        // Then
//        XCTAssertFalse(store.isFavorite(id: beer.id))
//    }
//
//    func test_fetchFavorites_returnsAllSavedItems() {
//        // Given
//        store.addFavorite(makeBeer(id: "1"))
//        store.addFavorite(makeBeer(id: "2"))
//
//        // When
//        let favorites = store.fetchFavorites()
//
//        // Then
//        XCTAssertEqual(favorites.count, 2)
//        XCTAssertTrue(favorites.contains(where: { $0.id == "1" }))
//        XCTAssertTrue(favorites.contains(where: { $0.id == "2" }))
//    }
//
//    func test_isFavorite_returnsFalseWhenNotStored() {
//        XCTAssertFalse(store.isFavorite(id: "999"))
//    }
//}
