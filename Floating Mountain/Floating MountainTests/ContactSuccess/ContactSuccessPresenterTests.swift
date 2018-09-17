//
//  ContactSuccessPresenterTests.swift
//  Floating Mountain
//
//  Created by Leonardo Oliveira on 9/17/18.
//  Copyright (c) 2018 Leonardo Oliveira. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import Floating_Mountain
import XCTest

class ContactSuccessPresenterTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: ContactSuccessPresenter!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupContactSuccessPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupContactSuccessPresenter() {
        sut = ContactSuccessPresenter()
    }
    
    // MARK: Test doubles
    
    class ContactSuccessDisplayLogicSpy: ContactSuccessDisplayLogic {
        var displaySendAnotherMessageCalled = false
        
        func displaySendAnotherMessage(viewModel: ContactSuccess.SendAnotherMessage.ViewModel) {
            displaySendAnotherMessageCalled = true
        }
        
    }
    
    // MARK: Tests
    
    func testPresentSendAnotherMessage() {
        // Given
        let spy = ContactSuccessDisplayLogicSpy()
        sut.viewController = spy
        let response = ContactSuccess.SendAnotherMessage.Response()
        
        // When
        sut.presentSendAnotherMessage(response: response)
        
        // Then
        XCTAssertTrue(spy.displaySendAnotherMessageCalled, "presentSomething(response:) should ask the view controller to display the result")
    }
}
