//
//  ImageProvider.swift
//  Beer
//
//  Created by Milena Alcântara on 20/11/25.
//

import Foundation

struct ImageProvider {
    static func imageName() -> String {
        let availableImageNames: [String] = [
            "beer_micro", "beer_nano", "beer_regional",
            "beer_brewpub", "beer_large", "beer_bar", "beer_default"
        ]
        
        return availableImageNames.randomElement() ?? "beer_default"
    }
    
    static func imageName(for type: String?) -> String {
        guard let type = type?.lowercased() else { return "beer_default" }
        
        switch type {
            case "micro": return "beer_micro"
            case "nano": return "beer_nano"
            case "regional": return "beer_regional"
            case "brewpub": return "beer_brewpub"
            case "large": return "beer_large"
            case "bar": return "beer_bar"
            default: return "beer_default"
        }
    }
}

