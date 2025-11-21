
//
//  Beer.swift
//  Beer
//
//  Created by Milena Alcântara on 16/11/25.
//

import Foundation

public struct Beer {
    public let id: String
    public let title: String
    public let type: String
    public let description: String?
    public let imageName: String?

    public init(id: String, title: String, type: String, description: String? = nil, imageName: String? = nil) {
        self.id = id
        self.title = title
        self.type = type
        self.description = description
        self.imageName = imageName
    }
}
