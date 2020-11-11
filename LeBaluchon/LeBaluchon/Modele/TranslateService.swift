//
//  TranslateService.swift
//  LeBaluchon
//
//  Created by ayite on 11/11/2020.
//

import Foundation

final class TranslateService {

    // MARK: - Properties

    private let httpClient: HTTPClient
    var stringToTranslate = ""
    // MARK: - Initializer

    init(httpClient: HTTPClient = HTTPClient()) {
        self.httpClient = httpClient
    }

    // MARK: - Methods

    func getData(callback: @escaping (Result<TranslateString, NetworkError>) -> Void) {
        guard let url = URL(string: "https://translation.googleapis.com/language/translate/v2") else { return }
        let parameters = [("key", Keys.translate),("target","en"),("q",stringToTranslate),("format","text")]
        httpClient.request(baseUrl: url, parameters: parameters, callback: callback)
    }
}
