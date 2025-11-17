//
//  APIMockService.swift
//  Beer
//
//  Created by Milena Alcântara on 16/11/25.
//

import Foundation

class APIMockService: BeerStoreProtocol {
    private let mockData: [Beer] = [
        .init(id: "1", name: "Cerveja Mock 1", breweryType: "regional"),
        .init(id: "2", name: "Cerveja Mock 2", breweryType: "regional"),
        .init(id: "3", name: "Cerveja Mock 3", breweryType: "regional"),
        .init(id: "4", name: "Cerveja Mock 4", breweryType: "regional"),
        .init(id: "5", name: "Cerveja Mock 5", breweryType: "regional"),
        .init(id: "6", name: "Cerveja Mock 6", breweryType: "regional"),
        .init(id: "7", name: "Cerveja Mock 7", breweryType: "regional"),
    ]
    
    func fetchBeers(page: Int, perPage: Int) async throws -> [Beer] {
        try await Task.sleep(for: .seconds(1))
        return mockData
    }
    
    func searchBeers(name: String) async throws -> [Beer] {
        try await Task.sleep(for: .milliseconds(500))
        
        if name.isEmpty {
            return mockData
        }
        
        let filteredData = mockData.filter { $0.name.lowercased().contains(name.lowercased()) }
        
        if filteredData.isEmpty {
            return []
        }
        
        return filteredData
    }
}
