//
//  FixerService.swift
//  LeBaluchon
//
//  Created by ayite on 11/11/2020.
//

import Foundation

final class FixerService {

    // MARK: - Properties

    private let httpClient: HTTPClient

    // MARK: - Initializer

    init(httpClient: HTTPClient = HTTPClient()) {
        self.httpClient = httpClient
    }

    // MARK: - Methods

    func getData(callback: @escaping (Result<Currency, NetworkError>) -> Void) {
        guard let url = URL(string: "http://data.fixer.io/api/latest?") else { return }
        let parameters = [("access_key", Keys.fixerKey),("base","EUR"),("symbols","USD")]
        httpClient.request(baseUrl: url, parameters: parameters, callback: callback)
    }
}
