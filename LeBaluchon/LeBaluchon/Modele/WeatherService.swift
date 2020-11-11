//
//  WeatherService.swift
//  LeBaluchon
//
//  Created by ayite on 11/11/2020.
//

import Foundation

final class WeatherService {

    // MARK: - Properties

    private let httpClient: HTTPClient

    // MARK: - Initializer

    init(httpClient: HTTPClient = HTTPClient()) {
        self.httpClient = httpClient
    }

    // MARK: - Methods

    func getDataCityOne(callback: @escaping (Result<Weather, NetworkError>) -> Void) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather") else { return }
        let parameters = [("q", "Paris"),("appid",Keys.weatherKey),("lang","fr")]
        httpClient.request(baseUrl: url, parameters: parameters, callback: callback)
    }
    
    func getDataCitytwo(callback: @escaping (Result<Weather, NetworkError>) -> Void) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather") else { return }
        let parameters = [("q", "Madrid"),("appid",Keys.weatherKey),("lang","fr")]
        httpClient.request(baseUrl: url, parameters: parameters, callback: callback)
    }
}
