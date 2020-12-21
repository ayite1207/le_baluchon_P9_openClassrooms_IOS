//
//  FakeResponseData.swift
//  LeBaluchonTests
//
//  Created by ayite on 18/11/2020.
//

import Foundation
/**
    FakeResponseData class alows you to choose tha parameters you want to put in a getData() method in TranslateService, WeatherService, FixerService
 */
class FakeResponseData {
    
    // MARK: - Propriéties
    
    static let responseOk = HTTPURLResponse(url: URL(string: "https://openclassroom.com")!,
                                     statusCode: 200,
                                     httpVersion: nil,
                                     headerFields: nil)
    static let responseKO = HTTPURLResponse(url: URL(string: "https://openclassroom.com")!,
                                     statusCode: 500,
                                     httpVersion: nil,
                                     headerFields: nil)
    
    class Error : Error{}
    static let error = Error()
    
    static var weatherCorrectData : Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var weatherTwoCitiesCorrectData : Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "WeatherTwoCities", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var translateCorrectData : Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Translate", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var fixerCorrectData : Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Fixer", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var languagesCorrectData : Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Languages", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let incorrectData = "erreur".data(using: .utf8)!
    
}
