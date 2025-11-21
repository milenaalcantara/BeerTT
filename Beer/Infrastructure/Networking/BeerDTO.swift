//
//  BeerDTO.swift
//  Beer
//
//  Created by Milena Alcântara on 20/11/25.
//

import Foundation


public struct BeerDTO: Codable {
    public let id: String?
    public let name: String?
    public let brewery_type: String?


    public init(id: String?, name: String?, brewery_type: String?) {
        self.id = id
        self.name = name
        self.brewery_type = brewery_type
    }
}
