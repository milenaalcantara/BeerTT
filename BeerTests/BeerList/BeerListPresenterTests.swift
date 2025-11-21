//
//  BeerListPresenterTests.swift
//  Beer
//
//  Created by Milena Alcântara on 20/11/25.
//

import XCTest
@testable import Beer

final class BeerListPresenterTests: XCTestCase {

    var sut: BeerListPresenter!
    var mockView: MockBeerListView!

    override func setUp() {
        sut = BeerListPresenter()
        mockView = MockBeerListView()
        sut.viewController = mockView
    }

    override func tearDown() {
        sut = nil
        mockView = nil
    }

    func test_presentBeers_mapsDTOToViewModel() {
        // Given
        let dto = BeerDTO(
            id: 1,
            name: "Belgian Ale",
            tagline: "Crisp and fruity",
            imageUrl: "https://img.com/beer.png"
        )

        let response = BeerListModel.Response(beers: [dto])

        // When
        sut.presentBeers(response: response)

        // Then
        XCTAssertTrue(mockView.didReceiveBeers)
        XCTAssertEqual(mockView.receivedBeers?.count, 1)
        XCTAssertEqual(mockView.receivedBeers?.first?.title, "Belgian Ale")
        XCTAssertEqual(mockView.receivedBeers?.first?.subtitle, "Crisp and fruity")
    }

    func test_presentError_callsDisplayError() {
        let error = NSError(domain: "Test", code: 1)

        sut.presentError(error)

        XCTAssertTrue(mockView.didReceiveError)
        XCTAssertEqual(mockView.errorMessage, error.localizedDescription)
    }
}

// MARK: - Mock View

final class MockBeerListView: BeerListDisplayLogic {

    var didReceiveBeers = false
    var didReceiveError = false

    var receivedBeers: [BeerViewData]?
    var errorMessage: String?

    func displayBeers(viewModel: BeerListModel.ViewModel) {
        didReceiveBeers = true
        receivedBeers = viewModel.beers
    }

    func displayError(message: String) {
        didReceiveError = true
        errorMessage = message
    }
}
