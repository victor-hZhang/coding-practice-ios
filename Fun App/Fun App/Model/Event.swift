//
//  Event.swift
//  Fun App
//
//  Created by Victor Zhang on 11/11/18.
//  Copyright © 2018 Victor Zhang. All rights reserved.
//

import ObjectMapper

class Event: Mappable {
    var name: String?
    var date: Date?
    var availableSeats: Int?
    var price: Double?
    var venue: String?
    var labels: [String]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        date <- (map["date"], DateTransform())
        availableSeats <- map["available_seats"]
        price <- map["price"]
        venue <- map["venue"]
        labels <- map["labels"]
    }
}
