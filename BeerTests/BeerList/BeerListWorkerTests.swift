//
//  BeerListWorkerTests.swift
//  Beer
//
//  Created by Milena Alcântara on 20/11/25.
//

import XCTest
@testable import Beer

final class BeerListWorkerTests: XCTestCase {

    var sut: BeerListWorker!
    var mockNetwork: MockNetworkService!

    override func setUp() {
        mockNetwork = MockNetworkService()
        sut = BeerListWorker(network: mockNetwork)
    }

    override func tearDown() {
        sut = nil
        mockNetwork = nil
    }

    func test_fetchBeers_success() {
        let expected = [
            BeerDTO(id: "10", name: "IPA", brewery_type: "Hoppy")
        ]
        mockNetwork.result = .success(expected)

        var received: [BeerDTO]?

        sut.fetchBeers(page: 1, query: nil) { result in
            if case .success(let beers) = result {
                received = beers
            }
        }

        XCTAssertEqual(received?.count, 1)
        XCTAssertEqual(received?.first?.id, "10")
    }

    func test_fetchBeers_failure() {
        mockNetwork.result = .failure(NSError(domain: "x", code: -1))

        var didFail = false

        sut.fetchBeers(page: 1, query: nil) { result in
            if case .failure = result {
                didFail = true
            }
        }

        XCTAssertTrue(didFail)
    }

    func test_fetchBeers_sendsCorrectParamsToNetwork() {
        mockNetwork.result = .success([])

        sut.fetchBeers(page: 2, query: "lager") { _ in }

        XCTAssertEqual(mockNetwork.lastPage, 2)
        XCTAssertEqual(mockNetwork.lastQuery, "lager")
    }
}

// MARK: - Mock Network

final class MockNetworkService: BeerNetworkProtocol {

    var result: Result<[BeerDTO], Error>?

    var lastPage: Int?
    var lastQuery: String?

    func fetchBeers(page: Int,
                    perPage: Int,
                    query: String?,
                    completion: @escaping (Result<[BeerDTO], Error>) -> Void) {

        lastPage = page
        lastQuery = query

        completion(result ?? .success([]))
    }
}
