//
//  WeatherCodable.swift
//  LeBaluchon
//
//  Created by ayite  on 12/10/2020.
//

import Foundation

struct Weather: Decodable {
    var coord : [String : Double]
    var weather : [D]
    var base : String
    var main : [String : Double]
    var visibility : Int
    var wind : [ String : Double]
    var clouds : [String : Int]
    var dt : Int
//    var sys : System
    var timezone : Int
    var id : Int
    var name : String
    var cod : Int
}

struct D: Decodable {
    var id :Int
    var main : String
    var description : String
    var icon : String
}

struct System: Decodable {
    var type : Int
    var id : Int
    var country : String
    var sunrise : Int
    var sunset : Int
}
