//
//  WeatherSevice.swift
//  LeBaluchon
//
//  Created by ayite  on 12/10/2020.
//

import Foundation


class WeatherService {
    
    let session : URLSession
    var task : URLSessionDataTask?
    
    init(session : URLSession = URLSession(configuration: .default)){
        self.session = session
    }
    
   func getWeather(callback: @escaping (Result<Weather, NetWorkError>)-> Void){
        guard let contactUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Paris&appid=b487640dbd3a727d3e8bba945445da97&lang=fr") else {return}
       task = session.dataTask(with: contactUrl) { (data, response, error) in
                
                guard let data = data, error == nil else {
                    callback(.failure(.noData))
                    print("error data1")
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(.failure(.noResponse))
                    print("error data2")
                    return
                }
                guard let weather = try? JSONDecoder().decode(Weather.self, from: data) else{
                    callback(.failure(.undecodableData))
                    print("error data3")
                    return
                }
                callback(.success(weather))
        }
        task?.resume()
    }
    
    
}
