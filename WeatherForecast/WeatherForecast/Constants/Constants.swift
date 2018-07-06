//
//  Constants.swift
//  rainyshinycloudy
//
//  Created by Shruti Sharma on 2/3/18.
//  Copyright © 2018 Shruti Sharma. All rights reserved.
//

import Foundation

let BASE_URL                  = "http://api.openweathermap.org/data/2.5/"
let CURRENT_WEATHER_CONSTANT  = "weather?"
let LATITUDE                  = "lat="
let LONGITUDE                 = "&lon="
let API_KEY                   = "&appid="
let APPID                     = "42a1771a0b787bf12e734ada0cfc80cb"

let FORECAST_WEATHER_CONSTANT     = "forecast/daily?"
let FORECAST_WEATHER_DAY_COUNTKEY = "&cnt="

let CURRENT_WEATHER_URL  = "\(BASE_URL)\(CURRENT_WEATHER_CONSTANT)\(LATITUDE)\(Location.sharedInstance.lattitude)\(LONGITUDE)\(Location.sharedInstance.longitude)\(API_KEY)\(APPID)"
let FORECAST_WEATHER_URL = "\(BASE_URL)\(FORECAST_WEATHER_CONSTANT)\(LATITUDE)\(Location.sharedInstance.lattitude)\(LONGITUDE)\(Location.sharedInstance.longitude)\(FORECAST_WEATHER_DAY_COUNTKEY)10\(API_KEY)\(APPID)"

typealias DownloadComplete = ()->()
