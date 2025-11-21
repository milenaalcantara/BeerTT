//
//  BeerListModels.swift
//  Beer
//
//  Created by Milena Alcântara on 20/11/25.
//

import Foundation

public enum BeerListModel {

    public struct Request {
        let page: Int
        let query: String?
    }

    public struct Response {
        let beers: [BeerDTO]
    }

    public struct ViewModel {
        let beers: [BeerCellViewModel]
    }
}

struct BeerCellViewModel {
    let name: String
    let type: String
    let imageName: String
}
