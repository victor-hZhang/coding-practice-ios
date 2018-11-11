//
//  EventViewModelTests.swift
//  Fun AppTests
//
//  Created by Victor Zhang on 11/11/18.
//  Copyright © 2018 Victor Zhang. All rights reserved.
//

import XCTest
import Foundation
import RxSwift
import RxTest
import RxBlocking
@testable import Fun_App

class EventViewModelTests: XCTestCase {
    var disposeBag = DisposeBag()
    var viewModel = EventViewModel(disposeBag: DisposeBag(), apiService: ApiStubService())
    
     private var observer: TestableObserver<[Fun_App.Event]>!
    
    override func setUp() {
        super.setUp()
        let scheduler = TestScheduler(initialClock: 0)
        observer = scheduler.createObserver(Array.self)
        scheduler.start()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testloadEvent() {
        viewModel.loadEvents()
        viewModel.events.asObservable().subscribe(onNext: { (events) in
            XCTAssertEqual(2, events.count)
            XCTAssertEqual("test2", events[0].name)
        }).disposed(by: disposeBag)
    }
    
    func testPlayButtonTapped() {
        viewModel.loadEvents()
        viewModel.playButtonTapped()
        viewModel.events.asObservable().subscribe(onNext: { (events) in
            XCTAssertEqual(0, events.count)
        }).disposed(by: disposeBag)
    }
    
    func testCurrencyFormat() {
        let event1: Fun_App.Event = Event()
        event1.price = 26
        
        XCTAssertEqual("$26.00", event1.priceString)
    }
}

fileprivate class ApiStubService: ApiService {
    func getEvents() -> Observable<[Fun_App.Event]> {
        var events: [Fun_App.Event] = []
        
        let event1: Fun_App.Event = Event()
        event1.name = "test1"
        event1.date = Date(timeIntervalSinceReferenceDate: -123456789.0)
        event1.availableSeats = 12
        event1.venue = "test venue"
        event1.price = 26
        events.append(event1)
        
        let event2: Fun_App.Event = Event()
        event2.name = "test2"
        event2.date = Date(timeIntervalSinceReferenceDate: -234567890.0)
        event2.availableSeats = 123
        event2.venue = "test venue 2"
        event2.price = 30
        events.append(event2)
        
        let event3: Fun_App.Event = Event()
        event3.availableSeats = 0
        events.append(event3)
        
        return Observable.just(events)
    }
}
