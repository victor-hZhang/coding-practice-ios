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
    private var price: NSNumber?
    var venue: String?
    var labels: [String]?
    
    let dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        date <- (map["date"], DateFormatterTransform(dateFormatter: dateFormatter))
        availableSeats <- map["available_seats"]
        price <- map["price"]
        venue <- map["venue"]
        labels <- map["labels"]
    }
    
    var priceString: String {
        guard let priceAmount = price else {return ""}
        return convertToCurrencyFormate(price: priceAmount)
    }
    
    private func convertToCurrencyFormate(price: NSNumber) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        guard let currencyString = formatter.string(from: price) else {return ""}
        return currencyString
    }
}
