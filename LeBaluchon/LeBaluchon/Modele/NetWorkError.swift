//
//  NetWorkError.swift
//  LeBaluchon
//
//  Created by ayite on 07/11/2020.
//

import Foundation

enum NetworkError: Error {

    case noData
    case noResponse
    case undecodableData
    
    var description : String {
        switch self {
        case .noData :
            return "There is no data !"
        case .noResponse :
            return "The response is not correct !"
        case .undecodableData :
           return "Data can't be decoded !"
        }
    }
}
