//
//  FixerService.swift
//  LeBaluchon
//
//  Created by ayite  on 11/10/2020.
//

import Foundation

enum NetWorkError: Error {

    case noData
    case noResponse
    case undecodableData
    
}

class FixerService {
    
    let session : URLSession
    var task : URLSessionDataTask?
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
        
    func getCurrency(callback: @escaping (Result<Currency, NetWorkError>)-> Void){
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
                guard let currency = try? JSONDecoder().decode(Currency.self, from: data) else{
                    callback(.failure(.undecodableData))
                    print("error data3")
                    return
                }
                
                callback(.success(currency))
        }
        task?.resume()
    }
    
    
}
