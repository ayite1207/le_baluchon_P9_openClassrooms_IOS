//
//  WeatherSevice.swift
//  LeBaluchon
//
//  Created by ayite  on 12/10/2020.
//

import Foundation

class WeatherService {
    static var shared = WeatherService()
    private init() {}
    
    private static let contactUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Paris&appid=b487640dbd3a727d3e8bba945445da97&lang=fr")!
    
    static func getWeather(callback: @escaping (Bool, Weather?)-> Void){
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: contactUrl) { (data, response, error) in
            DispatchQueue.main.async {
                
                guard let data = data, error == nil else {
                    callback(false, nil)
                    print("error data1")
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    print("error data2")
                    return
                }
                guard let weather = try? JSONDecoder().decode(Weather.self, from: data) else{
                    callback(false, nil)
                    print("error data3")
                    return
                }
                callback(true, weather)
                
            }
        }
        task.resume()
    }
    
    
}
