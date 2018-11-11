//
//  ApiService.swift
//  Fun App
//
//  Created by Victor Zhang on 11/11/18.
//  Copyright © 2018 Victor Zhang. All rights reserved.
//
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import RxSwift
import RxAlamofire

protocol ApiService {
    func getEvents() -> Observable<[Event]>
}

class ApiServiceImpl: ApiService {
    
    //api urls
    private let urlStr = "https://s3-ap-southeast-2.amazonaws.com/bridj-coding-challenge/events.json"
    
    func getEvents() -> Observable<[Event]> {
        return RxAlamofire.requestJSON(.get, urlStr).mapObject(type: EventsAPIResponse.self).map{ response in
            guard let events = response.events else {
                return []
            }
            return events
        }
    }
}
