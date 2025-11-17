
//
//  Beer.swift
//  Beer
//
//  Created by Milena Alcântara on 16/11/25.
//

import Foundation

public struct Beer: Codable, Identifiable, Hashable {
    public let id: String
    public let name: String
    public let breweryType: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case breweryType = "brewery_type"
    }
}

