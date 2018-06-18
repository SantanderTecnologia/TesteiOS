//
//  ContactWorkerTests.swift
//  TesteIOS
//
//  Created by Sidney Silva on 18/06/2018.
//  Copyright (c) 2018 Sakura Soft. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import TesteIOS
import XCTest

class ContactWorkerTests: XCTestCase {
    // MARK: Subject under test
  
    var sut: ContactWorker!
    var network: ApiManager!
  
    // MARK: Test lifecycle
  
    override func setUp() {
        super.setUp()
        network = ApiManager()
        setupContactWorker()
    }
  
    override func tearDown() {
        super.tearDown()
    }
  
    // MARK: Test setup
  
    func setupContactWorker() {
        sut = ContactWorker()
    }
    
    // MARK: Tests
  
    func test_request_success() {
        // Given
        let url = "https://floating-mountain-50292.herokuapp.com/cells.json"
        let promisse = expectation(description: "get cells")
        // When
        sut.fetchForm(url: url, success: { (response) in
            if response.cells != nil {
                promisse.fulfill()
            } else {
                XCTFail("get error")
            }
        }, failure: { (response) in
            XCTFail("get error")
        })
        
        // Then
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_request_error() {
        // Given
        let url = "https://urlwitherror.herokuapp.com/cell.json"
        let promisse = expectation(description: "get cells")
        var error: Error?
        // When
        sut.fetchForm(url: url, success: { (response) in
            XCTFail("get error")
        }, failure: { (response) in
            error = response.error!
            promisse.fulfill()
        })
        
        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(error)
    }
}
