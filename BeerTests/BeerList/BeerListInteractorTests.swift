////
////  BeerListInteractorTests.swift
////  Beer
////
////  Created by Milena Alcântara on 20/11/25.
////
//
//import XCTest
//@testable import Beer
//
//final class BeerListInteractorTests: XCTestCase {
//
//    var sut: BeerListInteractor!
//    var mockWorker: MockBeerListWorker!
//    var mockPresenter: MockBeerListPresenter!
//
//    override func setUp() {
//        mockWorker = MockBeerListWorker()
//        sut = BeerListInteractor(worker: mockWorker)
//        mockPresenter = MockBeerListPresenter()
//        sut.presenter = mockPresenter
//    }
//
//    func test_fetchBeers_success() {
//        mockWorker.result = .success([BeerDTO(id: "1", name: "IPA", brewery_type: "micro")])
//
//        sut.fetchBeers(request: .init(query: nil, type: .initialLoad))
//
//        XCTAssertTrue(mockPresenter.didReceiveSuccess)
//    }
//
//    func test_fetchBeers_failure() {
//        mockWorker.result = .failure(NSError(domain: "", code: -1))
//
//        sut.fetchBeers(request: .init(query: nil, type: .initialLoad))
//
//        XCTAssertTrue(mockPresenter.didReceiveError)
//    }
//}
