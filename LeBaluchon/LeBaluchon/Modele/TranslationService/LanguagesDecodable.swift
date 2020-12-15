//
//  LanguagesDecodable.swift
//  LeBaluchon
//
//  Created by ayite on 24/11/2020.
//

import Foundation

// allows you to convert json in object

struct Languages: Codable {
    let data: DataClass
}


struct DataClass: Codable {
    let languages: [Language]
}


struct Language: Codable {
    let language, name: String
}
