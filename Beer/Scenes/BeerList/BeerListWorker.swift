//
//  BeerListWorker.swift
//  Beer
//
//  Created by Milena Alcântara on 20/11/25.
//

import Foundation

public protocol BeerListWorkerProtocol {
    func fetchBeers(page: Int,
                    query: String?,
                    completion: @escaping (Result<[BeerDTO], Error>) -> Void)
}

final class BeerListWorker: BeerListWorkerProtocol {

    private let network: BeerNetworkProtocol

    init(network: BeerNetworkProtocol) {
        self.network = network
    }

    func fetchBeers(page: Int,
                    query: String?,
                    completion: @escaping (Result<[BeerDTO], Error>) -> Void) {

        network.fetchBeers(page: page,
                           perPage: 20,
                           query: query,
                           completion: completion)
    }
}
