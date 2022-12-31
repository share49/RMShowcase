//
//  RMShowcaseTests.swift
//  RMShowcaseTests
//
//  Created by Roger Pintó Diaz on 12/28/22.
//

import XCTest
@testable import RMShowcase

@MainActor final class MainCoordinatorTests: XCTestCase {
    
    func testCoordinatorStartCount() {
        // Arrange
        let expected = 1
        let sut = MainCoordinator(navigationController: UINavigationController())
        
        // Act
        sut.start()
        let result = sut.navigationController.viewControllers.count
        
        // Assert
        XCTAssertEqual(result, expected)
    }
    
    func testCoordinatorStartsCharactersList() {
        // Arrange
        let expected = "UIHostingController<\(CharactersListView.self)>"
        let sut = MainCoordinator(navigationController: UINavigationController())
        
        // Act
        sut.start()
        let startedViewController = sut.navigationController.viewControllers.first!
        let result = String(describing: startedViewController.classForCoder)
        
        // Assert
        XCTAssertEqual(result, expected)
    }
}
