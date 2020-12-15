//
//  WeatherCodable.swift
//  LeBaluchon
//
//  Created by ayite  on 12/10/2020.
//

import Foundation

// allows you to convert json in object

struct Weather: Decodable {
    var coord : [String : Double]
    var weather : [WeatherDessc]
    var base : String
    var main : [String : Double]
    var visibility : Int
    var wind : [ String : Double]
    var clouds : [String : Int]
    var dt : Int
    var timezone : Int
    var id : Int
    var name : String
    var cod : Int
}

struct WeatherDessc: Decodable {
    var id :Int
    var main : String
    var description : String
    var icon : String
}

