//
//  ViewController.swift
//  WeatherTask
//
//  Created by lexigee on 2017-09-05.
//
//

import UIKit

class ViewController: UIViewController, WeatherGetterDelegate {
    var weather: WeatherGetter!
    @IBOutlet weak var temperatureLabel: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var mainWeatherLabel: UILabel!
    let city = "Houston"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weather = WeatherGetter(delegate: self)
        
        // INITIALIZING UI
        self.view.backgroundColor = UIColor(red: 252/255, green: 246/255, blue: 228/255, alpha: 1.0)
        
        
        cityLabel.text = city + ", TX"
        cityLabel.font = cityLabel.font.withSize(30)
        
        temperatureLabel.text = ""
        temperatureLabel.font = temperatureLabel.font?.withSize(75)
        
        mainWeatherLabel.text = ""
        mainWeatherLabel.font = mainWeatherLabel.font.withSize(160)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func button(_ sender: Any) {
       weather.getWeather(city)
    }
    
    // WeatherGetterDelegate methods
    func didGetWeather(_ weather: Weather) {
        DispatchQueue.main.async {
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
    
        func didNotGetWeather(_ error: NSError) {
            print("didNotGetWeather error: \(error)")
        }

}

