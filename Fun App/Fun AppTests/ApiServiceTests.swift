//
//  Fun_AppTests.swift
//  Fun AppTests
//
//  Created by Victor Zhang on 11/11/18.
//  Copyright © 2018 Victor Zhang. All rights reserved.
//

import XCTest
import Alamofire
@testable import Fun_App

class ApiServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testResponseObject() {
        //Testing Api Contract.
        let URL = "https://s3-ap-southeast-2.amazonaws.com/bridj-coding-challenge/events.json"
        let expectation = self.expectation(description: "\(URL)")
        
        _ = Alamofire.request(URL, method: .get).responseObject { (response: DataResponse<EventsAPIResponse>) in
            expectation.fulfill()
            
            let mappedObject = response.result.value
            
            XCTAssertNotNil(mappedObject, "Response should not be nil")
            XCTAssertNotNil(mappedObject?.events, "Response should not be nil")
            XCTAssertNotNil(mappedObject?.events?[0].name, "Response event name should not be nil")
            XCTAssertNotNil(mappedObject?.events?[0].date, "Response event date should not be nil")
            XCTAssertNotNil(mappedObject?.events?[0].availableSeats, "Response event date should not be nil")
            XCTAssertNotNil(mappedObject?.events?[0].priceString, "Response event date should not be nil")
            XCTAssertNotNil(mappedObject?.events?[0].venue, "Response event date should not be nil")
            XCTAssertNotNil(mappedObject?.events?[0].labels, "Response event date should not be nil")
        }
        
        waitForExpectations(timeout: 10) { error in
            XCTAssertNil(error, "\(String(describing: error))")
        }
    }
    
}
