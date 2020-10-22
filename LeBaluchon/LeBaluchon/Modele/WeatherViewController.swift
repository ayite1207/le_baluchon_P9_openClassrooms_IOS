//
//  WeatherViewController.swift
//  LeBaluchon
//
//  Created by ayite  on 12/10/2020.
//

import UIKit

class WeatherViewController: UIViewController {
    
    var weatherInfo : Weather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayWeather()
        // Do any additional setup after loading the view.
    }
    
    func displayWeather(){
        WeatherService.getWeather { (success, Weather) in
            if success, let weather = Weather {
                self.weatherInfo = weather
                if let weather = self.weatherInfo{
                    print(weather.name)
                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
