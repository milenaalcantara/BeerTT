//
//  BeerDetailWorkerTests.swift
//  Beer
//
//  Created by Milena Alcântara on 20/11/25.
//

//
//  BeerDetailWorkerTests.swift
//  BeerTests
//

import XCTest
import CoreData
@testable import Beer

final class BeerDetailWorkerTests: XCTestCase {

    var sut: BeerDetailWorker!
    var mockStore: MockFavoriteStore!

    override func setUp() {
        mockStore = MockFavoriteStore()
        sut = BeerDetailWorker(store: mockStore)
    }

    func test_isFavorite_callsStore() {
        _ = sut.isFavorite(id: "1")
        XCTAssertTrue(mockStore.didCallIsFavorite)
    }

    func test_addFavorite_callsStore() {
        let beer = Beer(id: "1", title: "A", type: "T", description: "default", imageName: "default")
        sut.addFavorite(beer)
        XCTAssertTrue(mockStore.didCallAdd)
    }

    func test_removeFavorite_callsStore() {
        let beer = Beer(id: "1", title: "A", type: "T", description: "default", imageName: "default")
        sut.removeFavorite(id: beer.id)
        XCTAssertTrue(mockStore.didCallRemove)
    }
}

final class MockFavoriteStore: CoreDataFavoriteStoreProtocol {

    var didCallIsFavorite = false
    var didCallAdd = false
    var didCallRemove = false

    func isFavorite(id: String) -> Bool {
        didCallIsFavorite = true
        return false
    }

    func addFavorite(_ beer: Beer) {
        didCallAdd = true
    }

    func removeFavorite(id: String) {
        didCallRemove = true
    }

    func fetchFavorites() -> [Beer] { return [] }
}
