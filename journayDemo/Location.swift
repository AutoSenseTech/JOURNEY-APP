//
//  Location.swift
//  journayDemo
//
//  Created by Wang Weihan on 4/21/16.
//  Copyright © 2016 Wang Weihan. All rights reserved.
//

import Foundation

class Location {
    var fileName: String = ""
    var title: String = ""
    var description: String = ""
    var latitude: Double
    var longitude: Double
    var date: Date
    
    init(fileName: String, title: String, description: String, latitude: Double, longitude: Double, dateString: String) {
        self.fileName = fileName
        self.title = title
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        if let date = dateFormatter.date(from: dateString) {
            self.date = date
        } else {
            self.date = Date(timeIntervalSinceNow: 0)
        }
    }
    
}
