//
//  HTTPEngine.swift
//  LeBaluchon
//
//  Created by ayite on 07/11/2020.
//

import Foundation

// allows you to make a call to a API service 

typealias HTTPResponse = (Data?, HTTPURLResponse?, Error?) -> Void

final class HTTPEngine {

    // MARK: - Properties

    private let session: URLSession
    private var task: URLSessionDataTask?

    // MARK: - Initialization

    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }

    // MARK: - Methods
    
    // func request allows you to make raquest To a API service
    
    func request(baseUrl: URL, parameters: [(String, Any)]?, callback: @escaping HTTPResponse) {
        let url = encode(baseUrl: baseUrl, with: parameters)
        Logger(url: url).show()
        task?.cancel()
        task = session.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                callback(data, nil, error)
                return
            }
            callback(data, response, error)
        }
        task?.resume()
    }

    // func encode return an URL for your API's request
    
    private func encode(baseUrl: URL, with parameters: [(String, Any)]?) -> URL {
        guard var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false), let parameters = parameters, !parameters.isEmpty else { return baseUrl }
        
        urlComponents.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            urlComponents.queryItems?.append(queryItem)
        }
        guard let url = urlComponents.url else { return baseUrl }
        return url
    }
}
