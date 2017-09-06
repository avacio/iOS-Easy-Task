//
//  WeatherGetter.swift
//  WeatherTask
//
//  Created by lexigee on 2017-09-05.
//
//

import Foundation

protocol WeatherGetterDelegate {
    func didGetWeather(_ weather: Weather)
}

class WeatherGetter {
    
    fileprivate var delegate: WeatherGetterDelegate
    private let weatherAPIKey = "6027c5e0369d7640507be10e2bb14557"
    
    init(delegate: WeatherGetterDelegate) {
        self.delegate = delegate
    }
    
    
    func getWeather(city: String)  {
    
        let requestURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&APPID=\(weatherAPIKey)")!
        
        let dataFetched = URLSession.shared.dataTask(with: requestURL, completionHandler: {
            (data: Data?, response: URLResponse?, error: NSError?) in
            if let error = error {
                print("Error:\n\(error)")
            }
            else {
                do {
                    // Try to convert that data into a Swift dictionary
                    let weatherData = try JSONSerialization.jsonObject(
                        with: data!,
                        options: .mutableContainers) as! [String: AnyObject]
                    
                    let weather = Weather(weatherData: weatherData)
                    
                    // Now that we have the Weather struct, let's notify the view controller,
                    // which will use it to display the weather to the user.
                    self.delegate.didGetWeather(weather)
                }
                catch let jsonError as NSError {
                    print("Error:\n\(jsonError)")
                }
            }
            } as! (Data?, URLResponse?, Error?) -> Void)
        
        dataFetched.resume()
    }
}
