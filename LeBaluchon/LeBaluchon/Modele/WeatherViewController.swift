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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayWeather()
        // Do any additional setup after loading the view.
    }
    
}

extension WeatherViewController {

    func displayWeather(){
        weatherService.getWeather { [unowned self] result in
            switch result {
            case .failure(let error) :
                DispatchQueue.main.sync {
                    print(error.localizedDescription)
                }
                
            case .success(let weather) :
                DispatchQueue.main.sync {
                        self.weatherInfo = weather
                        if let weather = self.weatherInfo{
                            print(weather.name)
                        }
                }
            }
        }
    }
    
}
