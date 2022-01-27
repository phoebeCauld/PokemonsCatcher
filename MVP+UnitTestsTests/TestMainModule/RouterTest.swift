//
//  RouterTest.swift
//  MVP+UnitTestsTests
//
//  Created by F1xTeoNtTsS on 27.01.2022.
//

import XCTest
@testable import MVP_UnitTests


class MockNavigationControler: UINavigationController {
    
    var presentedVC: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        presentedVC = viewController
        super.pushViewController(viewController, animated: animated)
    }
}
class RouterTest: XCTestCase {
    
    var router: RouterProtocol!
    var navigationController: MockNavigationControler!
    var assemblyBuilder: AssemblyBuilder!
    
    override func setUpWithError() throws {
        navigationController = MockNavigationControler()
        assemblyBuilder = AssemblyModuleBuilder()
        router = Router(navigationController: navigationController, assemblyBuilder: assemblyBuilder)
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        navigationController = nil
        assemblyBuilder = nil
        router = nil
        try super.tearDownWithError()
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testRouter() {
        router.showInitialVC()
        let infoVC = navigationController.viewControllers.first
        XCTAssertTrue(infoVC is MainViewController)
    }
}
