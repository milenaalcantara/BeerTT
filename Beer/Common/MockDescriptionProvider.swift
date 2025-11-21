//
//  MockDescriptionProvider.swift
//  Beer
//
//  Created by Milena Alcântara on 20/11/25.
//

import Foundation

struct MockDescriptionProvider {
    private static let descriptions: [String] = [
        "Cerveja leve, com notas frutadas e final seco.",
        "Corpo médio, amargor equilibrado e aroma de malte.",
        "Sabor encorpado, notas torradas e toque de caramelo.",
    ]

    static func description(for id: String, title: String, type: String?) -> String {
        // deterministic pick based on hash para estabilidade
        let index = abs(id.hashValue) % descriptions.count
        return descriptions[index]
    }
}

