//
//  ViewController.swift
//  WeatherTask
//
//  Created by lexigee on 2017-09-05.
//
//

import UIKit

class ViewController: UIViewController,  WeatherGetterDelegate {
    var weather: WeatherGetter!
    @IBOutlet weak var temperatureLabel: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var mainWeatherLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.darkGray
        weather = WeatherGetter(delegate: self)
        
        // INITIALIZING UI
        cityLabel.text = "Houston"
        cityLabel.font = cityLabel.font.withSize(30)
        
        temperatureLabel.text = ""
        
        mainWeatherLabel.text = ""
        mainWeatherLabel.font = mainWeatherLabel.font.withSize(50)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func button(_ sender: Any) {
       
    }
    
    // WeatherGetterDelegate methods
    func didGetWeather(_ weather: Weather) {
        DispatchQueue.main.async {
            self.cityLabel.text = weather.city
            self.temperatureLabel.text = "\(Int(round(weather.tempCelsius)))°"
            
            switch weather.mainWeather {
                case "Clouds":
                    self.mainWeatherLabel.text = "☁️"
                case "Mist", "Atmosphere":
                    self.mainWeatherLabel.text = "🌫"
                case "Rain", "Drizzle":
                    self.mainWeatherLabel.text = "☔️"
                case "Snow":
                    self.mainWeatherLabel.text = "❄️"
                case "Thunderstorm", "Extreme":
                    self.mainWeatherLabel.text = "⛈"
                case "Clear":
                    self.mainWeatherLabel.text = "🌞"
            default: break
            
            }
        }
    }

}

