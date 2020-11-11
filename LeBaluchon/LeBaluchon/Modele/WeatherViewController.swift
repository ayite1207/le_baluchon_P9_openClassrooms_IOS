//
//  WeatherViewController.swift
//  LeBaluchon
//
//  Created by ayite  on 12/10/2020.
//

import UIKit

class WeatherViewController: UIViewController {
    
    var weatherInfo : Weather?
    let weatherService = WeatherService()
    let key = Keys.weatherKey
    override func viewDidLoad() {
        super.viewDidLoad()
        displayWeather()
        // Do any additional setup after loading the view.
    }
    
}

extension WeatherViewController {
    
    func displayWeather(){
        weatherService.getDataCityOne { [unowned self] result in
            switch result {
            case .success(let weather):
                DispatchQueue.main.async {
                    self.weatherInfo = weather
                    if let weather = self.weatherInfo{
                        print(weather.name)
                        displayWeatherCityTwo()
                    }
                }
            case .failure(let error):
                self.showAlert(with: error.description)
            }
        }
    }
    
    func displayWeatherCityTwo() {
        weatherService.getDataCitytwo { [unowned self] result in
            switch result {
            case .success(let weather):
                DispatchQueue.main.async {
                    self.weatherInfo = weather
                    if let weather = self.weatherInfo{
                        print(weather.name)
                    }
                }
            case .failure(let error):
                self.showAlert(with: error.description)
            }
        }
    }
    
}



