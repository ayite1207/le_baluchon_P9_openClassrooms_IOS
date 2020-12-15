//
//  ListeWeather.swift
//  LeBaluchon
//
//  Created by ayite on 18/11/2020.
//

import Foundation

// allows you to convert json in object

struct ListWeather : Decodable {
    var list : [WeatherList]
}

struct WeatherList: Decodable {
    var coord : [String : Double]
    var weather : [Main]
    var main : [String : Double]
    var visibility : Int
    var wind : [ String : Double]
    var clouds : [String : Int]
    var dt : Int
    var sys : SystemList
    var id : Int
    var name : String
}

struct Main: Decodable {
    var id :Int
    var main : String
    var description : String
    var icon : String
}

struct SystemList: Decodable {
    var country : String
    var timezone : Int
    var sunrise : Int
    var sunset : Int
}
