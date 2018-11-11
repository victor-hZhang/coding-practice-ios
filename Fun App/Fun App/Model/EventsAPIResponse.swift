//
//  EventsAPIResponse.swift
//  Fun App
//
//  Created by Victor Zhang on 11/11/18.
//  Copyright © 2018 Victor Zhang. All rights reserved.
//

import ObjectMapper

class EventsAPIResponse:Mappable{
    
    var events:[Event]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        events <- map["events"]
    }
    
}
