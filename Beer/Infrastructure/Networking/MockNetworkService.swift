//
//  APIMockService.swift
//  Beer
//
//  Created by Milena Alcântara on 16/11/25.
//

import Foundation


final class MockNetworkService: BeerNetworkProtocol {

    var result: Result<[BeerDTO], Error>?

    func fetchBeers(page: Int,
                    perPage: Int,
                    query: String?,
                    completion: @escaping (Result<[BeerDTO], Error>) -> Void) {

        guard let result = result else {
            completion(.failure(MockError.noResultProvided))
            return
        }

        completion(result)
    }

    enum MockError: Error {
        case noResultProvided
    }
}
