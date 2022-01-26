//
//  MainTests.swift
//  MVP+UnitTestsTests
//
//  Created by F1xTeoNtTsS on 26.01.2022.
//

import XCTest
@testable import MVP_UnitTests

class MockView: MainViewProtocol {
    func success() {
    }
    
    func failure(error: Error) {
    }
}

class MainTests: XCTestCase {

    var view: MainViewProtocol!
    var networkManager: NetworkManager!
    var presenter: MainViewPresenterProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        view = MockView()
        networkManager = NetworkManager()
        presenter = MainPresenter(view: view, networkManager: networkManager)
    }

    override func tearDownWithError() throws {
        view = nil
        networkManager = nil
        presenter = nil
        try super.tearDownWithError()
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testModuleIsNotNil() {
        XCTAssertNotNil(view, "view isnot nil")
        XCTAssertNotNil(networkManager, "model isnot nil")
        XCTAssertNotNil(presenter, "presenter isnot nil")
    }

}
