//
//  BeerDetailModel.swift
//  Beer
//
//  Created by Milena Alcântara on 20/11/25.
//

import Foundation

public enum BeerDetailModel {

    public struct Request {
        let id: String
    }

    public struct Response {
        public let beer: Beer
        public let isFavorite: Bool
    }

    public struct ViewModel {
        let title: String
        let subtitle: String
        let imageName: String
        let description: String
        let isFavorite: Bool
    }
}
