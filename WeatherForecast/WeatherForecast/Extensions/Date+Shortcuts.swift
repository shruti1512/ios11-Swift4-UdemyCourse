//
//  Date+Shortcuts.swift
//  rainyshinycloudy
//
//  Created by Shruti Sharma on 2/5/18.
//  Copyright © 2018 Shruti Sharma. All rights reserved.
//

import Foundation

extension Date {
    
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
    
    func stringInFormat(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}
