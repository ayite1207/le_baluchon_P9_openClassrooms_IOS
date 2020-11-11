//
//  TranslateCodable.swift
//  LeBaluchon
//
//  Created by ayite  on 28/10/2020.
//

import Foundation

struct TranslateString : Decodable {
    var data : Dat
    
}

struct Dat : Decodable {
    var translations : [Text]
}

struct Text : Decodable{
    var translatedText : String
    var detectedSourceLanguage : String
}
