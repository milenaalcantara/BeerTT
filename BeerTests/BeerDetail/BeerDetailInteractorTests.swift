//
//  BeerDetailInteractorTests.swift
//  Beer
//
//  Created by Milena Alcântara on 20/11/25.
//
//
//  BeerDetailInteractorTests.swift
//  BeerTests
//

//
//  BeerDetailInteractorTests.swift
//  BeerTests
//

import XCTest
@testable import Beer

final class BeerDetailInteractorTests: XCTestCase {

    var sut: BeerDetailInteractor!
    var mockWorker: MockBeerDetailWorker!
    var mockPresenter: MockBeerDetailPresenter!

    override func setUp() {
        mockWorker = MockBeerDetailWorker()
        mockPresenter = MockBeerDetailPresenter()
        let beer = Beer(id: "1", title: "IPA", type: "micro", description: "A beer", imageName: "beer1")

        sut = BeerDetailInteractor(beer: beer, worker: mockWorker)
        sut.presenter = mockPresenter
    }

    func test_loadBeer_success() {

        mockWorker.isFavoriteResult = true

        sut.loadDetail()

        XCTAssertTrue(mockPresenter.didPresentBeer)
        XCTAssertEqual(mockPresenter.receivedBeer?.title, "IPA")
        XCTAssertEqual(mockPresenter.receivedIsFavorite, true)
    }

    func test_toggleFavorite_whenNotFavorite_addsFavorite() {

        mockWorker.isFavoriteResult = false

        sut.toggleFavorite()

        XCTAssertTrue(mockWorker.didAddFavorite)
        XCTAssertEqual(mockPresenter.receivedIsFavorite, true)
    }

    func test_toggleFavorite_whenFavorite_removesFavorite() {

        mockWorker.isFavoriteResult = true

        sut.toggleFavorite()

        XCTAssertTrue(mockWorker.didRemoveFavorite)
        XCTAssertEqual(mockPresenter.receivedIsFavorite, false)
    }
}
