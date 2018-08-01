//
//  FundsViewControllerTests.swift
//  TesteIOS
//
//  Created by Diego Ramos de Almeida on 29/07/18.
//  Copyright © 2018 Diego Ramos de Almeida. All rights reserved.
//

@testable import TesteIOS
import XCTest

class FundsViewControllerTests: XCTestCase {
  // MARK: Subject under test
  
    var sut: FundsViewController!
    var window: UIWindow!
  
    // MARK: Test lifecycle
  
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupFundsViewController()
    }
  
    override func tearDown() {
        window = nil
        super.tearDown()
    }
  
    // MARK: Test setup
  
    func setupFundsViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "FundsViewController") as! FundsViewController
    }
  
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
  
    // MARK: Test doubles
  
    class FundsBusinessLogicSpy: FundsBusinessLogic {
        var fetchCalled = false
        func fetch(request: FundsModel.Fetch.Request) {
            fetchCalled = true
        }
    }
  
    // MARK: Tests
  
    func test_view_is_loaded() {
        // Given
        let spy = FundsBusinessLogicSpy()
        sut.interactor = spy
    
        // When
        loadView()
    
        // Then
        XCTAssertTrue(spy.fetchCalled, "viewDidLoad() should ask the interactor to do something")
    }
}
