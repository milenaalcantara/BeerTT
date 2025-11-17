//
//  BeerStoreProtocol.swift
//  Beer
//
//  Created by Milena Alcântara on 16/11/25.
//

import Foundation

public protocol BeerStoreProtocol {
    func fetchBeers(page: Int, perPage: Int) async throws -> [Beer]
    func searchBeers(name: String) async throws -> [Beer]
}

