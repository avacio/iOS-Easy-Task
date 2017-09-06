//
//  Weather.swift
//  WeatherTask
//
//  Created by lexigee on 2017-09-05.
//
//

import Foundation

class Weather {
    let mainWeather: String
    let city: String
    
    
    
    // OpenWeatherMap reports temperature in Kelvin,
    // which is why we need to convert to Celsius
    fileprivate let temp: Double
    var tempCelsius: Double {
        get {
            return temp - 273.15
        }
    }
    
    init(weatherData: [String: AnyObject]) {
        city = weatherData["name"] as! String
        
        let mainDict = weatherData["main"] as! [String: AnyObject]
        temp = mainDict["temp"] as! Double
    
        let weatherDict = weatherData["weather"]![0] as! [String: AnyObject]
        mainWeather = weatherDict["main"] as! String
    }
}
