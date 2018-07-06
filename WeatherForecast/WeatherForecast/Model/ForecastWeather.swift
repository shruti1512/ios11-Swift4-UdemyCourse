//
//  ForecastWeather.swift
//  rainyshinycloudy
//
//  Created by Shruti Sharma on 7/5/18.
//  Copyright © 2018 Shruti Sharma. All rights reserved.
//

import Foundation

//MARK: - Struct ForecastWeather

struct ForecastWeather: Decodable {
    let list: [ForecastWeatherList]
}

//MARK: - Struct List

struct ForecastWeatherList {
    let date: Double
    let day: String
    let temp: Temp
    let weather: [WeatherDetails]
    
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case temp
        case weather
        case day
    }
}

//MARK: - Manual Encoding Logic for Struct ForecastWeatherList

//extension ForecastWeatherList: Encodable {
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(date, forKey: .date)
//        try container.encode(day, forKey: .day)
//        try container.encode(temp, forKey: .temp)
//        try container.encode(weather, forKey: .weather)
//    }
//}

//MARK: - Manual Decoding Logic for Struct ForecastWeatherList

extension ForecastWeatherList: Decodable {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        date = try values.decode(Double.self, forKey: .date)
        let unixConvertedDate = Date(timeIntervalSince1970: date)
        day = unixConvertedDate.stringInFormat(format: "EEEE, MMM d, yyyy")
        temp = try values.decode(Temp.self, forKey: .temp)
        weather = try values.decode([WeatherDetails].self, forKey: .weather)
    }
}


//MARK: - Struct Temp

struct Temp {
    let tempMin: Double
    let tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case tempMin = "min"
        case tempMax = "max"
    }
}


//MARK: - Manual Encoding Logic for Struct Temp

//extension Temp: Encodable {
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(tempMin, forKey: .tempMin)
//        try container.encode(tempMax, forKey: .tempMax)
//    }
//}

//MARK: - Manual Decoding Logic for Struct Temp

extension Temp: Decodable {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let tempMinInKelvin = try values.decode(Double.self, forKey: .tempMin)
        tempMin = Utility.kelvinToFahrenheit(temp: tempMinInKelvin)
        let tempMaxInKelvin = try values.decode(Double.self, forKey: .tempMax)
        tempMax = Utility.kelvinToFahrenheit(temp: tempMaxInKelvin)
    }
}









