//
//  NetWorkError.swift
//  LeBaluchon
//
//  Created by ayite on 07/11/2020.
//

import Foundation

// allows you to specify the type of error and display the good message

enum NetworkError: Error {

    // MARK: - Cases
    
    case noData
    case noResponse
    case undecodableData
    
    // MARK: - Properties
    
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
