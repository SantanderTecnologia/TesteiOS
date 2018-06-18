//
//  ContactPresenterTests.swift
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

class ContactPresenterTests: XCTestCase {
    // MARK: Subject under test
  
    var sut: ContactPresenter!
    var cells: [Cell]!
  
    // MARK: Test lifecycle
  
    override func setUp() {
        super.setUp()
        setupContactPresenter()
        
    }
  
    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup
    
    func setupCells() {
        let cell1 = Cell()
        let cell2 = Cell()
        cells = [cell1, cell2]
    }

    func setupContactPresenter() {
        sut = ContactPresenter()
    }
  
    // MARK: Test doubles
  
    class ContactDisplayLogicSpy: ContactDisplayLogic {
        var displayCalled = false
        func display(viewModel: Contact.Fetch.ViewModel) {
            displayCalled = true
        }
    }
  
    // MARK: Tests
  
    func test_presenter() {
        // Given
        let spy = ContactDisplayLogicSpy()
        sut.viewController = spy
        
        let response = Contact.Fetch.Response(cells: cells, error: nil, message: "")
    
        // When
        sut.display(response: response)
    
        // Then
        XCTAssertTrue(spy.displayCalled, "display(response:) should ask the view controller to display the result")
    }
}
