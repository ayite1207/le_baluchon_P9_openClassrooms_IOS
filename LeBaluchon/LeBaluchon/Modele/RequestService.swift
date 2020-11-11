//
//  RequestService.swift
//  LeBaluchon
//
//  Created by ayite on 07/11/2020.
//

import Foundation

final class RequestService {

    // MARK: - Properties

    private let httpClient: HTTPClient

    // MARK: - Initializer

    init(httpClient: HTTPClient = HTTPClient()) {
        self.httpClient = httpClient
    }

    // MARK: - Methods

    func getData(callback: @escaping (Result<Weather, NetworkError>) -> Void) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather") else { return }
        let parameters = [("q", "Paris"),("appid",Keys.weatherKey),("lang","fr")]
        httpClient.request(baseUrl: url, parameters: parameters, callback: callback)
    }
}
