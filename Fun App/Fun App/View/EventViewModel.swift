//
//  EventViewModel.swift
//  Fun App
//
//  Created by Victor Zhang on 11/11/18.
//  Copyright © 2018 Victor Zhang. All rights reserved.
//

import RxSwift

class EventViewModel {
    private var disposeBag: DisposeBag
    private var eventsList: [Event] = []
    private var apiService: ApiService
    
    init(disposeBag: DisposeBag, apiService: ApiService) {
        self.disposeBag = disposeBag
        self.apiService = apiService
    }
    
    // MARK: Public
    var title: String = "Fun App"
    
    var events: Observable<[Event]> {
        return self.eventsSubject.asObservable()
    }
    
    public func loadEvents() {
        getEventsObservable()
            .map{
                (events) -> [Event] in
                return events.filter({ (event) -> Bool in
                    guard let seats = event.availableSeats else {return false}; return seats > 0
                })
                .sorted(by: { (event1, event2) -> Bool in
                    return event1.date! < event2.date!
                })
            }
            .subscribe(onNext: { [weak self]  events in
            self?.eventsSubject.value = events
            self?.eventsList = events
        }).disposed(by: disposeBag)
    }
    
    public func playButtonTapped() {
        self.eventsSubject.value = eventsList.filter({ (event) -> Bool in
            guard let eventlabel = event.labels else {return false}
            return eventlabel.contains("play")
        })
    }
    
    // MARK: Private
    private let eventsSubject = Variable<[Event]>([])
    private func getEventsObservable() -> Observable<[Event]> {
        return apiService.getEvents()
    }
    
}
