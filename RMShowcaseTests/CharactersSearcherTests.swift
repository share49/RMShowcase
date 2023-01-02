//
//  CharactersSearcherTests.swift
//  RMShowcaseTests
//
//  Created by Roger Pintó Diaz on 1/2/23.
//

import XCTest
@testable import RMShowcase

final class CharactersSearcherTests: XCTestCase {
    
    func testSearchWhenThereArentMorePagesLeft() async {
        // Arrange
        let searchedText = "Test"
        let infoResponse = InfoResponse(nextPageNumber: nil)
        let characters = CharactersResponse(info: infoResponse, results: [CharacterResponse.mock])
        let mockNetworkService = MockNetworkService(result: .success(item: characters))
        let sut = CharactersSearcher(networkService: mockNetworkService, paginationManager: PaginationManager())
        
        // Act
        _ = try! await sut.search(searchedText)
        let result = try! await sut.search(searchedText)
        
        // Assert
        XCTAssertFalse(result.isEmpty)
    }
    
    func testSearchPagination() async {
        // Arrange
        let searchedText = "Test"
        
        let responseResults = [CharacterResponse.mock]
        let expected = responseResults.count * 2
        
        let characters = CharactersResponse(info: InfoResponse.mock, results: responseResults)
        let mockNetworkService = MockNetworkService(result: .success(item: characters))
        let sut = CharactersSearcher(networkService: mockNetworkService, paginationManager: PaginationManager())
        
        // Act
        _ = try! await sut.search(searchedText)
        let items = try! await sut.search(searchedText)
        let result = items.count
        
        // Assert
        XCTAssertEqual(result, expected)
    }
    
    func testHasItemsAfterSearch() async {
        // Arrange
        let searchedText = "Test"
        let characters = CharactersResponse.mock
        let mockNetworkService = MockNetworkService(result: .success(item: characters))
        let sut = CharactersSearcher(networkService: mockNetworkService, paginationManager: PaginationManager())
        
        // Act
        _ = try! await sut.search(searchedText)
        let result = sut.hasItems
        
        // Assert
        XCTAssertTrue(result)
    }
    
    func testSearchReturnsItems() async {
        // Arrange
        let searchedText = "Test"
        let characters = CharactersResponse.mock
        let mockNetworkService = MockNetworkService(result: .success(item: characters))
        let sut = CharactersSearcher(networkService: mockNetworkService, paginationManager: PaginationManager())
        
        // Act
        let result = try! await sut.search(searchedText)
        
        // Assert
        XCTAssertFalse(result.isEmpty)
    }
}
