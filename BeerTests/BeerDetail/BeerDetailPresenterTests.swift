//
//  BeerDetailPresenterTests.swift
//  Beer
//
//  Created by Milena Alcântara on 20/11/25.
//

import XCTest
@testable import Beer

final class BeerDetailPresenterTests: XCTestCase {

    var sut: BeerDetailPresenter!
    var mockView: MockBeerDetailViewController!

    override func setUp() {
        sut = BeerDetailPresenter()
        mockView = MockBeerDetailViewController()
        sut.viewController = mockView
    }

    func test_presentBeer_buildsViewModelCorrectly() {

        let beer = Beer(id: "1",
                        title: "Lager",
                        type: "macro",
                        description: "Smooth beer",
                        imageName: "lager")

        let response = BeerDetailModel.Response(beer: beer, isFavorite: false)

        sut.presentDetail(response: response)

        XCTAssertTrue(mockView.didDisplayBeer)
        XCTAssertEqual(mockView.receivedViewModel?.title, "Lager")
        XCTAssertEqual(mockView.receivedViewModel?.isFavorite, false)
    }

    func test_presentFavoriteStatus_updatesView() {

        sut.presentFavoriteStatus(isFavorite: true)

        XCTAssertTrue(mockView.didUpdateFavorite)
        XCTAssertEqual(mockView.receivedIsFavorite, true)
    }
}
