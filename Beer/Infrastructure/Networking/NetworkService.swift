//
//  NetworkService.swift
//  Beer
//
//  Created by Milena Alcântara on 20/11/25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError(Error)
    case transportError(Error)
    case serverError(statusCode: Int)
}

protocol BeerNetworkProtocol {
    func fetchBeers(page: Int,
                    perPage: Int,
                    query: String?,
                    completion: @escaping (Result<[BeerDTO], Error>) -> Void)
}

final class NetworkService {
    private let baseURL = URL(string: "https://api.openbrewerydb.org/v1")!
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchBeers(page: Int, perPage: Int = 20, query: String? = nil, completion: @escaping (Result<[BeerDTO], Error>) -> Void) {
        var components = URLComponents(url: baseURL.appendingPathComponent("/breweries"), resolvingAgainstBaseURL: false)!
        
        components.queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "per_page", value: "\(perPage)")
        ]

        if let q = query, !q.isEmpty {
            components.queryItems?.append(URLQueryItem(name: "by_name", value: q))
        }

        guard let url = components.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        let task = session.dataTask(with: url) { data, response, error in
            if let err = error {
                completion(.failure(NetworkError.transportError(err)))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse,
               !(200...299).contains(httpResponse.statusCode) {
                completion(.failure(NetworkError.serverError(statusCode: httpResponse.statusCode)))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let dtos = try decoder.decode([BeerDTO].self, from: data)
                completion(.success(dtos))
            } catch {
                completion(.failure(NetworkError.decodingError(error)))
            }
        }
        task.resume()
    }
}

extension NetworkService: BeerNetworkProtocol {}
