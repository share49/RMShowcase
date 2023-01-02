//
//  PaginationManagerTests.swift
//  RMShowcaseTests
//
//  Created by Roger Pintó Diaz on 1/2/23.
//

import XCTest
@testable import RMShowcase

final class PaginationManagerTests: XCTestCase {
    
    struct TestItem: Identifiable {
        let id: String
    }
    
    // MARK: - Properties
    
    private let items = [
        TestItem(id: "1"),
        TestItem(id: "2"),
        TestItem(id: "3"),
        TestItem(id: "4"),
        TestItem(id: "5"),
        TestItem(id: "6")
    ]
    
    // MARK: - Tests
    
    func testCurrentItemTriggersPagination() {
        // Arrange
        let expectedStartId = "2"
        let sut = PaginationManager()
        
        // Act
        let result = sut.shouldLoadMoreItems(items: items, currentItemId: expectedStartId)
        
        // Assert
        XCTAssertTrue(result)
    }
    
    func testPreviousItemDoesntTriggersPagination() {
        // Arrange
        let expectedStartId = "1"
        let sut = PaginationManager()
        
        // Act
        let result = sut.shouldLoadMoreItems(items: items, currentItemId: expectedStartId)
        
        // Assert
        XCTAssertFalse(result)
    }
    
    func testNextItemDoesntTriggersPagination() {
        // Arrange
        let expectedStartId = "3"
        let sut = PaginationManager()
        
        // Act
        let result = sut.shouldLoadMoreItems(items: items, currentItemId: expectedStartId)
        
        // Assert
        XCTAssertFalse(result)
    }
}
