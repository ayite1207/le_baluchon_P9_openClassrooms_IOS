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
    
    func getDataCity(callback: @escaping (Result<Weather, NetworkError>) -> Void) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather") else { return }
        let parameters = [("q", "Paris"),("appid",Keys.weatherKey),("lang","en"),("units","metric")]
        httpClient.request(baseUrl: url, parameters: parameters, callback: callback)
    }
    
    func getDataTwoCities(callback: @escaping (Result<ListWeather, NetworkError>) -> Void) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/group") else { return }
        let parameters = [("id", "2988507,5128581"),("appid",Keys.weatherKey),("lang","en"),("units","metric")]
        httpClient.request(baseUrl: url, parameters: parameters, callback: callback)
    }
}
