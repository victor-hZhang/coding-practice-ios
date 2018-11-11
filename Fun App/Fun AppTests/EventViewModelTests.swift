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
    //Should use a mock or stub service here, IOS unit test can acturally make API calls so been a big lazy.
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
            XCTAssertEqual(1, events.count)
        })
    }
    
    func testPlayButtonTapped() {
        viewModel.loadEvents()
        viewModel.playButtonTapped()
        viewModel.events.asObservable().subscribe(onNext: { (events) in
            XCTAssertEqual(0, events.count)
        })
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
        event1.date = nil
        event1.availableSeats = 12
        event1.venue = "test venue"
        event1.price = 26
        events.append(event1)
        return Observable.just(events)
    }
}
