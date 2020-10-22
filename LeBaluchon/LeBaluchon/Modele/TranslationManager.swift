//
//  TranslationManager.swift
//  LeBaluchon
//
//  Created by ayite  on 19/10/2020.
//

import Foundation


class TranslationManager: NSObject {
    
    static let shared = TranslationManager()
    private let apiKey = "AIzaSyDJQ5qphjDqDG8O6beSABoa22lGe5ii3xA"
    var sourceLanguageCode : String?
    var supportedLanguages = [TranslationLanguage]()
    
    override init() {
        super.init()
    }
    
    struct TranslationLanguage {
        var code : String?
        var name : String?
    }
    
    private func makeRequest(usingTranslationAPI api: TranslationApi, urlParams: [String: String], completion: @escaping (_ results: [String: Any]?) -> Void) {
        if var components = URLComponents(string: api.getURL()) {
            components.queryItems = [URLQueryItem]()
            for (key, value) in urlParams {
                print("la clé \(key)")
                print(value)
                components.queryItems?.append(URLQueryItem(name: key, value: value))
            }
            
            guard let url = components.url else {return}
            var request =  URLRequest(url: url)
            request.httpMethod = api.getHTTPMethod()
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request){ (data, response, error) in
                
                guard let data = data, error == nil else{
                    completion(nil)
                    return
                }
                print("RESPONSE  : \(response)")
                guard let response = response as? HTTPURLResponse,  response.statusCode == 200 || response.statusCode == 201 else {
                    completion(nil)
                    return }
                
                do {
                    if let resultDict = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableLeaves) as? [String: Any]{
                        completion(resultDict)
                    }
                }catch {
                    print(error.localizedDescription)
                }
            }
            task.resume()
            
        }
    }
    
    func detectLanguage(forText text: String, completion: @escaping (_ language: String?) -> Void) {
        print("||----------------------- FONCTION DETECTLANGUAGE ----------------------||")
        let urlParams = ["key": apiKey, "q": text]
        print("Le texte a convertir est : \(text)")
        makeRequest(usingTranslationAPI: .detectLanguage, urlParams: urlParams) { (results) in
            guard let results = results else { completion(nil); return }
            if let data = results["data"] as? [String: Any], let detections = data["detections"] as? [[[String: Any]]] {
                var detectedLanguages = [String]()
                print("J'affiche les data : \(data)")
                for detection in detections {
                    for currentDetection in detection {
                        if let language = currentDetection["language"] as? String {
                            detectedLanguages.append(language)
                        }
                    }
                }
                if detectedLanguages.count > 0 {
                    self.sourceLanguageCode = detectedLanguages[0]
                    completion(detectedLanguages[0])
                } else {
                    completion(nil)
                }
                
            } else {
                completion(nil)
            }
        }
    }
    
    func fetchSupportedLanguages(completion: @escaping (_ success: Bool) -> Void) {
        var urlParams = [String :String]()
        urlParams["key"] = apiKey
        urlParams["target"] = Locale.current.languageCode ?? "en"
        
        makeRequest(usingTranslationAPI: .supportedLanguages, urlParams: urlParams) { (results) in
            guard let results = results else { completion(false); return }
            
            guard let data = results["data"] as? [String: Any], let languages = data["languages"] as? [[String: Any]] else {return completion(false)}
            
            for lang in languages {
                var languageCode: String?
                var languageName: String?
                guard let code = lang["language"] as? String, let name = lang["name"] as? String  else {
                    return
                }
                languageCode = code
                languageName = name
                print("||  languageCode = \(languageCode) , languageName = \(languageName)  ||")

                self.supportedLanguages.append(TranslationLanguage(code: languageCode, name: languageName))
            }
            completion(true)
        }
    }
}
