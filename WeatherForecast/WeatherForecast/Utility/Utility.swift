//
//  Utility.swift
//  rainyshinycloudy
//
//  Created by Shruti Sharma on 6/27/18.
//  Copyright © 2018 Shruti Sharma. All rights reserved.
//

import Foundation

class Utility {
    
    static func kelvinToFahrenheit(temp: Double) -> Double {
        print("temp in kelvin: \(temp)")
        
        let kelvintofahrenheitPreRounded = ((temp * 1.8) - 459.67)
        print("temp in fahrenheit: \(kelvintofahrenheitPreRounded)")

        let convertedTemp = Double(round(100*kelvintofahrenheitPreRounded)/100)
        print("temp in fahrenheit rounded: \(convertedTemp)")

        return convertedTemp
    }
}
