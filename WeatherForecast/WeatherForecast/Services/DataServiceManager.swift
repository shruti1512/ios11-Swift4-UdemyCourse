//
//  DataService.swift
//  rainyshinycloudy
//
//  Created by Shruti Sharma on 6/29/18.
//  Copyright © 2018 Shruti Sharma. All rights reserved.
//

import Foundation
import Alamofire

class DataServiceManager
{
    func getCurrentWeatherData(completion: @escaping (CurrentWeather?, Error?) -> Void) {
       
        getJSONFromURL(url: CURRENT_WEATHER_URL) { [weak self] (data, error) in
            
            guard let data = data, error == nil else {
                print("Failed to get current weather data from: \(CURRENT_WEATHER_URL) error: \(String(describing: error?.localizedDescription))")
                return
            }
            
            self?.createCurrentWeatherObjectWithJSON(json: data, completion: { (weather, error) in
                guard let weather = weather, error == nil else {
                    print("Failed to parse current weather data error: \(String(describing: error?.localizedDescription))")
                    completion(nil, error)
                    return
                }
                print("createCurrentWeatherObjectWithJSON Current Weather: \(String(describing: weather))")
                completion(weather, nil)
            })
        }
    }
    
    func getForecastWeatherData(completion: @escaping (ForecastWeather?, Error?) -> Void) {
        
        self.getJSONFromURL(url: FORECAST_WEATHER_URL) { [weak self] (data, error) in
            guard let data = data, error == nil else {
                print("Failed to get forecast weather data from: \(FORECAST_WEATHER_URL) error: \(String(describing: error?.localizedDescription))")
                return
            }
            
            self?.createForecastWeatherObjectWithJSON(json: data, completion: { (weather, error) in
                guard let weather = weather, error == nil else {
                    print("Failed to parse forecast weather data error: \(String(describing: error?.localizedDescription))")
                    completion(nil, error)
                    return
                }
                print("createForecastWeatherObjectWithJSON Forecast Weather: \(String(describing: weather))")
                completion(weather, nil)
            })

        }
    }
 
}

//MARK: - DataServiceManager Private Methods

extension DataServiceManager {
   
    private func getJSONFromURL(url: String, completion: @escaping (Data?, Error?) -> Void) {
        
        Alamofire.request(url).responseJSON {response in
            if response.result.isSuccess {
                print("getJSONFromURLString request url: \(String(describing: url)))")
                print("getJSONFromURLString response: \(String(describing: String(bytes:response.data! , encoding: .utf8)))")
                completion(response.data, nil)
            }
            else {
                completion(nil, response.error)
            }
        }
    }
    
    private func createForecastWeatherObjectWithJSON(json: Data, completion: (ForecastWeather?, Error?) -> Void) {
        do {
            let weather = try JSONDecoder().decode(ForecastWeather.self, from: json)
            completion(weather, nil)
        }
        catch let error {
            completion(nil, error)
        }
    }

    private func createCurrentWeatherObjectWithJSON(json: Data, completion: (CurrentWeather?, Error?) -> Void) {
        do {
            let weather = try JSONDecoder().decode(CurrentWeather.self, from: json)
            completion(weather, nil)
        }
        catch let error {
            completion(nil, error)
        }
    }

}


