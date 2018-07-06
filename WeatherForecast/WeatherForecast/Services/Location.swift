//
//  Location.swift
//  rainyshinycloudy
//
//  Created by Shruti Sharma on 2/21/18.
//  Copyright © 2018 Shruti Sharma. All rights reserved.
//

import Foundation

class Location {
    
    static var sharedInstance = Location()
    private init() { }
    
    var lattitude: Double = 0.0
    var longitude: Double = 0.0
    
}
