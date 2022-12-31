//
//  ResponseErrorHelperTests.swift
//  RMShowcaseTests
//
//  Created by Roger Pintó Diaz on 12/31/22.
//

import XCTest
@testable import RMShowcase

final class ResponseErrorHelperTests: XCTestCase {
    
    func testGetErrorMessage() {
        // Arrange
        let expected = "TestErrorMessage"
        let errorInfoResponse = ErrorInfoResponse(message: expected)
        let errorResponse = ErrorResponse(errors: [errorInfoResponse])
        
        // Act
        let result = ResponseErrorHelper.message(for: errorResponse)
        
        // Assert
        XCTAssertEqual(result, expected)
    }
    
    func testGetErrorMessageForEmptyErrorInfo() {
        // Arrange
        let expected = "EmptyMessage"
        let errorResponse = ErrorResponse(errors: [])
        
        // Act
        let result = ResponseErrorHelper.message(for: errorResponse, defaultMessage: expected)
        
        // Assert
        XCTAssertEqual(result, expected)
    }
}
