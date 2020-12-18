//
//  HTTPClient.swift
//  LeBaluchon
//
//  Created by ayite on 07/11/2020.
//

import Foundation

// allows you to recover the result of my API call and verify there are no errors

final class HTTPClient {

    // MARK: - Properties

    private let httpEngine: HTTPEngine

    // MARK: - Initializer
    // i initialaze this class with HTTPEngine
    init(httpEngine: HTTPEngine = HTTPEngine()) {
        self.httpEngine = httpEngine
    }

    // MARK: - Methode
    
    // The func request uses a generic of type Decodable, it allows to use this function with all my structures of type Decodable
    func request<T: Decodable>(baseUrl: URL, parameters: [(String, Any)]?, callback: @escaping (Result<T, NetworkError>) -> Void) {
        httpEngine.request(baseUrl: baseUrl, parameters: parameters) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(.failure(.noData))
                    return
                }
                guard let response = response, response.statusCode == 200 else {
                    callback(.failure(.noResponse))
                    return
                }
                guard let dataDecoded = try? JSONDecoder().decode(T.self, from: data) else {
                    callback(.failure(.undecodableData))
                    return
                }
                callback(.success(dataDecoded))
            }
        }
    }
}
