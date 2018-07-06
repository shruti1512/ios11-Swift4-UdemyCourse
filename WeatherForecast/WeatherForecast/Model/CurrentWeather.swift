//
//  CurrentWeather.swift
//  rainyshinycloudy
//
//  Created by Shruti Sharma on 6/29/18.
//  Copyright © 2018 Shruti Sharma. All rights reserved.
//

import Foundation

//MARK: - CurrentWeather Struct

struct CurrentWeather {
    
    let city: String
    var weather: [WeatherDetails]
    var main: Main
    
    var date:String {
        get{
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            let currentDate = dateFormatter.string(from: Date())
            return "Today, \(currentDate)"
        }
    }

    //The CodingKeys enum, which conforms to CodingKey protocol, lets you rename specific properties in case the serialized format doesn’t match the requirements of the API.
//    1. CodingKeys is a nested enumeration in your type.
//    2. It has to conform to CodingKey.
//    3. You also need String as the raw type, since the keys are always strings.
//    4. You have to include all properties in the enumeration, even if you don’t plan to rename them.
//    5. By default, this enumeration is created by the compiler, but when you need to rename a key you need to implement it yourself.

    enum CodingKeys: String, CodingKey {
        case city = "name"
        case weather
        case main
        case date
    }

}

//MARK: - Manual Encoding Logic for Struct CurrentWeather

//Manual Encoding and Decoding
//First you get back the container of the encoder. This is a view into the storage of the encoder that you can access with keys. Note how you choose which properties to encode for which keys. Importantly, you flatten favoriteToy.name down to the .gift key.

//extension CurrentWeather: Encodable {
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(city, forKey: .city)
//        try container.encode(weather, forKey: .weather)
//        try container.encode(main, forKey: .main)
//        try container.encode(date, forKey: .date)
//    }
//}

//MARK: - Manual Decoding Logic for Struct CurrentWeather

extension CurrentWeather: Decodable {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        city = try values.decode(String.self, forKey: .city)
        weather = try values.decode([WeatherDetails].self, forKey: .weather)
        main = try values.decode(Main.self, forKey: .main)
    }
}


//MARK: - Main Struct

struct Main {
    var temp: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
    }
}

//MARK: - Manual Encoding Logic for Struct Main

//extension Main: Encodable {
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(temp, forKey: .temp)
//    }
//}

//MARK: - Manual Decoding Logic for Struct Main
//Here we need to convert tempInKelvin to temp (in Fahrenheit)
extension Main: Decodable {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let tempInKelvin = try values.decode(Double.self, forKey: .temp)
        temp = Utility.kelvinToFahrenheit(temp: tempInKelvin)
    }
}


//MARK: - WeatherDetails Struct

struct WeatherDetails: Codable {
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case type = "main"
    }
}
