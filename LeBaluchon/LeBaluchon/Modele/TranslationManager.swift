//
//  TranslationManager.swift
//  LeBaluchon
//
//  Created by ayite  on 19/10/2020.
//

import Foundation


class TranslationManager: NSObject {
    
    // MARK: - PROPERTYS
    
    private let apiKey = ""
    var sourceLanguageCode : String?
    var supportedLanguages = [TranslationLanguage]()
    
    var textToTranslate: String?
    var targetLanguageCode =  "en"
    var urlParams = [String: String]()
    override init() {
        super.init()
    }
    
    struct TranslationLanguage {
        var code : String?
        var name : String?
    }
    // MARK: - METHODS
    
    private func makeRequest(usingTranslationAPI api: TranslationApi, urlParams: [String: String], completion: @escaping (_ results: [String: Any]?) -> Void) {
        if var components = URLComponents(string: api.getURL()) {
            components.queryItems = [URLQueryItem]()
            for (key, value) in urlParams {
                components.queryItems?.append(URLQueryItem(name: key, value: value))
            }
            
            guard let url = components.url else {return}
            var request =  URLRequest(url: url)
            request.httpMethod = api.getHTTPMethod()
            print("REQUEST |||||    \(request)")
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request){ (data, response, error) in
                
                guard let data = data, error == nil else{
                    completion(nil)
                    return
                }
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
    
    func translate(completion: @escaping (_ translations: String?) -> Void) {
        guard let textToTranslate = textToTranslate  else { completion(nil); return }
        let targetLanguage = targetLanguageCode
        
        
        urlParams["key"] = apiKey
        urlParams["q"] = textToTranslate
        urlParams["target"] = targetLanguage
        urlParams["format"] = "text"
        
        if let sourceLanguage = sourceLanguageCode {
            urlParams["source"] = sourceLanguage
        }
        
        makeRequest(usingTranslationAPI: .translate, urlParams: urlParams) { (results) in
            guard let results = results else { completion(nil); return }
            
            guard let data = results["data"] as? [String: Any], let translations = data["translations"] as? [[String: Any]] else {return completion(nil)}
            
            var allTranslations = [String]()
            
            for translation in translations {
                if let translatedText = translation["translatedText"] as? String {
                    allTranslations.append(translatedText)
                }
            }
            
            if allTranslations.count > 0 {
                completion(allTranslations[0])
            } else {
                completion(nil)
            }
        }
    }
    
    enum NetWorkError: Error {

        case noData
        case noResponse
        case undecodableData
        
    }



    class TranslateService {
        struct Traduction : Decodable{
            
        }
        let session : URLSession
        var task : URLSessionDataTask?
        
        init(session: URLSession = URLSession(configuration: .default)) {
            self.session = session
        }
        
            
        func getTraduction(callback: @escaping (Result<Traduction, NetWorkError>)-> Void){
            guard let contactUrl = URL(string: "http://data.fixer.io/api/latest?access_key=495341d65e1445272353e8f1fb7d8703&base=EUR&symbols=USD") else {return}
            task?.cancel()
             task = session.dataTask(with: contactUrl) { (data, response, error) in
                    
                    guard let data = data, error == nil else {
                        callback(.failure(.noData))
                        print("error data1")
                        return
                    }
                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        callback(.failure(.noResponse))
                        print("error response")
                        return
                    }
                    guard let currency = try? JSONDecoder().decode(Traduction.self, from: data) else{
                        callback(.failure(.undecodableData))
                        print("error data3")
                        return
                    }
                    callback(.success(currency))
            }
            task?.resume()
        }
    }
}
