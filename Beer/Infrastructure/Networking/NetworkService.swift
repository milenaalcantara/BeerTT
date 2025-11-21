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
        
        var queryItems: [URLQueryItem] = [
                    URLQueryItem(name: "per_page", value: "\(perPage)")
                ]
        
        if let q = query, !q.isEmpty {
            queryItems = [URLQueryItem(name: "by_name", value: q)]
        } else {
            queryItems.append(URLQueryItem(name: "page", value: "\(page)"))
        }
        
        components.queryItems = queryItems

        guard let url = components.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        let task = session.dataTask(with: url) { data, response, error in
                    // 1. Tratamento de Erro de Transporte (Timeout, Sem Conexão)
            if let err = error {
                completion(.failure(NetworkError.transportError(err)))
                return
            }
            
            // 2. Tratamento de Erro de Status HTTP (4xx, 5xx)
            if let httpResponse = response as? HTTPURLResponse,
               !(200...299).contains(httpResponse.statusCode) {
                completion(.failure(NetworkError.serverError(statusCode: httpResponse.statusCode)))
                return
            }

            // 3. Tratamento de Ausência de Dados
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            // 4. Tratamento de Erro de Decodificação
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

//        let task = session.dataTask(with: url) { data, resp, err in
//            if let err = err { completion(.failure(err)); return }
//            guard let data = data else { completion(.failure(NetworkError.noData)); return }
//            do {
//                let decoder = JSONDecoder()
//                let dtos = try decoder.decode([BeerDTO].self, from: data)
//                completion(.success(dtos))
//            } catch {
//                completion(.failure(error))
//            }
//        }
