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
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        let dataFetched = session.dataTask(with: requestURL, completionHandler: {
            (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if let networkError = error {
                 self.delegate.didNotGetWeather(networkError as NSError)
            }
            else {
                do {
                    let weatherData = try JSONSerialization.jsonObject(
                        with: data!,
                        options: .mutableContainers) as! [String: AnyObject]
                    
                    let weather = Weather(weatherData: weatherData)
                    
                    self.delegate.didGetWeather(weather)
                }
                catch let jsonError as NSError {
                     self.delegate.didNotGetWeather(jsonError)
                }
            }
        })
        dataFetched.resume()
    }
}
