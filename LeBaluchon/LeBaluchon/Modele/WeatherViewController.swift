//
//  WeatherViewController.swift
//  LeBaluchon
//
//  Created by ayite  on 12/10/2020.
//

import UIKit

class WeatherViewController: UIViewController {
    
    // MARK: - Properties
    
    var weatherInfo : Weather?
    var weatherCitiesListe : ListWeather?
    var listeWeatherCity : ListWeather?
    let weatherService = WeatherService()
  
    // MARK: - Outlet city
    
    @IBOutlet var citiesLabel: [UILabel]!
    @IBOutlet var countriesLabel: [UILabel]!
    @IBOutlet var tempLabels: [UILabel]!
    @IBOutlet var sunRiseLabels: [UILabel]!
    @IBOutlet var sunSetLabels: [UILabel]!
    @IBOutlet var mainLabels: [UILabel]!
    @IBOutlet var descriptionLabels: [UILabel]!
    
    // MARK: - Cycle life
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        displayWeather()
    }
}

extension WeatherViewController {
    
    // MARK: - Methodes
    
    func displayWeather(){
        weatherService.getDataTwoCities { [unowned self] result in
            switch result {
            case .success(let listeWeatherCity):
                DispatchQueue.main.async {
                    self.listeWeatherCity = listeWeatherCity
                    if let weatherCities = self.listeWeatherCity{
                        weatherCitiesListe = weatherCities
                        displayInfo()
                    }
                }
            case .failure(let error):
                self.showAlert(with: error.description)
            }
        }
    }
    
    func displayInfo(){
        guard let sunriseCityOne = weatherCitiesListe?.list[0].sys.sunrise, let sunsetCityOne = weatherCitiesListe?.list[0].sys.sunset else {return}
        guard  let sunriseCityTwo = weatherCitiesListe?.list[1].sys.sunrise, let sunsetCityTwo = weatherCitiesListe?.list[1].sys.sunset else {return}
        
        let format = DateFormatter()
        format.setLocalizedDateFormatFromTemplate("HH:mm")
        let riseCityOne = convertTime(date : sunriseCityOne, country: (weatherCitiesListe?.list[0].sys.country)!)
        
        let setCityOne = convertTime(date : sunsetCityOne, country: (weatherCitiesListe?.list[0].sys.country)!)
        let riseCityTwo = convertTime(date : sunriseCityTwo, country: (weatherCitiesListe?.list[1].sys.country)!)
        let setCityTwo = convertTime(date : sunsetCityTwo, country: (weatherCitiesListe?.list[1].sys.country)!)
        
        citiesLabel[1].text = weatherCitiesListe?.list[0].name
        countriesLabel[1].text = weatherCitiesListe?.list[0].sys.country
        sunRiseLabels[1].text = "sunrise \(riseCityOne)"
        sunSetLabels[1].text = "sunset \(setCityOne)"
        tempLabels[0].text = "\(weatherCitiesListe?.list[0].main["temp"] ?? 0.0) C°"
        mainLabels[0].text = weatherCitiesListe?.list[0].weather[0].main
        descriptionLabels[0].text = weatherCitiesListe?.list[1].weather[0].description
        
        citiesLabel[0].text = weatherCitiesListe?.list[1].name
        countriesLabel[0].text = weatherCitiesListe?.list[1].sys.country
        sunRiseLabels[0].text = "sunrise \(riseCityTwo)"
        sunSetLabels[0].text = "sunset \(setCityTwo)"
        tempLabels[1].text = "\(weatherCitiesListe?.list[1].main["temp"] ?? 0.0) C°"
        mainLabels[1].text = weatherCitiesListe?.list[1].weather[0].main
        descriptionLabels[1].text = weatherCitiesListe?.list[1].weather[0].main
    }
    
    private func convertTime(date : Int, country: String)-> String {
        let format = DateFormatter()
        format.setLocalizedDateFormatFromTemplate("HH:mm")
        if country == "US" {
            let riseCityOne = NSDate(timeIntervalSince1970: TimeInterval(date - 21600))
            return format.string(from: riseCityOne as Date)
        }
        let riseCityOne = NSDate(timeIntervalSince1970: TimeInterval(date))
        return format.string(from: riseCityOne as Date)
    }
}

