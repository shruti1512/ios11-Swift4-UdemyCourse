//
//  CurrentWeatherParser.swift
//  rainyshinycloudy
//
//  Created by Shruti Sharma on 2/3/18.
//  Copyright © 2018 Shruti Sharma. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CurrentWeatherParser {
    
    private var _date: String!
    private var _weatherType: String!
    private var _temperature: Double!
    private var _cityName: String!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        _date = "Today, \(currentDate)"
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var temperature: Double {
        if _temperature == nil {
            _temperature = 0.0
        }
        return _temperature
    }
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    /* //Traditional Old School Way of JSON Parsing Using Purely Swift
    func getCurrentWeatherData(completed: @escaping DownloadComplete) {
        
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON {response in
            
            if response.result.isSuccess {
                print(response)
            }
            
            //print("Request: \(String(describing: response.request))")   // original url request
            print("Result.Value: \(String(describing: response.result.value))")             // response serialization result
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
               
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
                }

                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let temp = main["temp"] as? Double {
                        //° F = (K - 273.15)* 1.8000
                     let kelvintofahrenheitPreRounded = ((temp - 273.15) * 1.8) + 32
                     let kelvintofahrenheit = Double(round(10*kelvintofahrenheitPreRounded)/10)

                        self._temperature = kelvintofahrenheit
                    }
                }
            }
            
            completed()
        }
    
    }
 */

    //New Way of JSON Parsing using SWIFTYJSON
    func getCurrentWeatherData(completed: @escaping DownloadComplete) {

        Alamofire.request(CURRENT_WEATHER_URL).responseJSON {
            response in
            if response.result.isSuccess {
                let weatherJSON = JSON(response.result.value!)
                print("getCurrentWeatherData json: \(weatherJSON)")

                if let kelvinTemp = weatherJSON["main"]["temp"].double  {

                    self._temperature = Utility.kelvinToFahrenheit(temp: kelvinTemp)

                    self._cityName = weatherJSON["name"].stringValue

                    self._weatherType = weatherJSON["weather"][0]["main"].stringValue
                }
                else {
                    print("Weather unavailable")
                }
            }
            else {
                print("Unable to download current weather data: \(String(describing: response.error?.localizedDescription))")
            }

            completed()
        }
    }
    
}







