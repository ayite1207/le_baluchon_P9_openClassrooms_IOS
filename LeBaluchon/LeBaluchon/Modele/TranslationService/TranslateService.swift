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
    var basicTarget = "en"
    var newTarget = "en"
    
    // MARK: - Initializer

    init(httpClient: HTTPClient = HTTPClient()) {
        self.httpClient = httpClient
    }

    // MARK: - Methods

    func getTranslationData(callback: @escaping (Result<TranslateString, NetworkError>) -> Void) {
        guard let url = URL(string: "https://translation.googleapis.com/language/translate/v2") else { return }
        let parameters = [("key", Keys.translate),("target",basicTarget),("q",stringToTranslate),("format","text")]
        httpClient.request(baseUrl: url, parameters: parameters, callback: callback)
    }
    
    func getLanguagesData(callback: @escaping (Result<Languages, NetworkError>) -> Void) {
        guard let url = URL(string: "https://translation.googleapis.com/language/translate/v2/languages") else { return }
        let parameters = [("key", Keys.translate),("target","en")]
        httpClient.request(baseUrl: url, parameters: parameters, callback: callback)
    }
}
