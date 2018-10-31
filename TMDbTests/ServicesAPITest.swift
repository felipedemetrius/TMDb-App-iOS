//
//  ServicesAPITest.swift
//  TMDbTests
//
//  Created by Felipe Silva  on 30/10/18.
//  Copyright © 2018 Felipe Silva . All rights reserved.
//

import XCTest
@testable import TMDb

class ServicesAPITest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMovieServiceGetUpcoming() {
        let wait = expectation(description: "upcoming")
        
        var service = MovieService()
        XCTAssertNotNil(service)
        
        service.get { result in
            XCTAssertNotNil(result.value)
            wait.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testMovieServiceGetQuery() {
        let wait = expectation(description: "query")
        
        var service = MovieService()
        XCTAssertNotNil(service)

        service.get(nameStartsWith: "Spider") { result in
            XCTAssertNotNil(result.value)
            wait.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testMovieServiceGetOne() {
        let wait = expectation(description: "getone")
        
        var service = MovieService()
        XCTAssertNotNil(service)
        
        service.get(id: 9613) { result in
            XCTAssertNotNil(result.value)
            XCTAssertNotNil(result.value?.urlPosterImage)
            XCTAssertNotNil(result.value?.urlBackdropImage)
            XCTAssertNotNil(result.value?.genres?.names)

            wait.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }

}
