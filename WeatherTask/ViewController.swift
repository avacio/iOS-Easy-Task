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
        self.view.backgroundColor = UIColor.darkGray
        weather = WeatherGetter(delegate: self)
        
        // INITIALIZING UI
        cityLabel.text = city + ", TX"
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
            // This method is called asynchronously, which means it won't execute in the main queue.
            // All UI code needs to execute in the main queue, which is why we're wrapping the call
            // to showSimpleAlert(title:message:) in a dispatch_async() call.
            DispatchQueue.main.async {
//                self.showSimpleAlert(title: "Can't get the weather",
//                                     message: "The weather service isn't responding.")
            }
            print("didNotGetWeather error: \(error)")
        }

}

