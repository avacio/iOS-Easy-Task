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
    func didNotGetWeather(_ error: NSError)
}

class WeatherGetter {
    
    fileprivate var delegate: WeatherGetterDelegate
    private let weatherAPIKey = "8a07e6029692fdd1855cca2deed20a11"
    
    init(delegate: WeatherGetterDelegate) {
        self.delegate = delegate
    }
    
    
    func getWeather(_ city: String)  {
        
        let requestURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?APPID=\(weatherAPIKey)&q=\(city)")!
        
        let dataFetched = URLSession.shared.dataTask(with: requestURL, completionHandler: {
            (data: Data?, response: URLResponse?, error: NSError?) in
            if let networkError = error {
                 self.delegate.didNotGetWeather(networkError)
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
                     self.delegate.didNotGetWeather(jsonError)
                }
            }
            } as! (Data?, URLResponse?, Error?) -> Void)
        
        dataFetched.resume()
    }
}
