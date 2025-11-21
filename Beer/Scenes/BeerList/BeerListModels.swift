//
//  BeerListModels.swift
//  Beer
//
//  Created by Milena Alcântara on 20/11/25.
//

import Foundation

public enum BeerListModel {

    public struct Request {
        let query: String?
        let type: RequestType
    }

    public enum RequestType {
        case initialLoad
        case pagination
        case search(String)
    }
    
    public struct Response {
        let beers: [Beer]
        let isNewDataSet: Bool
        let isEndOfList: Bool 
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
