//
//  Currency.swift
//  LeBaluchon
//
//  Created by ayite  on 11/10/2020.
//

import Foundation

// allows you to convert json in object

struct Currency: Decodable{
    let rates : [String : Double]
}
