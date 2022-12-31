//
//  EndpointTests.swift
//  RMShowcaseTests
//
//  Created by Roger Pintó Diaz on 12/31/22.
//

import XCTest
@testable import RMShowcase

final class EndpointTests: XCTestCase {
    
    func testGraphQLEndpoint() {
        // Arrange
        let expected = URL(string: "https://rickandmortyapi.com/graphql")
        let sut = Endpoint.graphQL()
        
        // Act
        let result = sut.url
        
        // Assert
        XCTAssertEqual(result, expected)
    }
}
