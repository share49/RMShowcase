//
//  CharactersLoaderTests.swift
//  RMShowcaseTests
//
//  Created by Roger Pintó Diaz on 1/2/23.
//

import XCTest
@testable import RMShowcase

final class CharactersLoaderTests: XCTestCase {
    
    func testLoadWhenThereArentMorePagesLeft() async {
        // Arrange
        let infoResponse = InfoResponse(nextPageNumber: nil)
        let characters = CharactersResponse(info: infoResponse, results: [CharacterResponse.mock])
        let mockNetworkService = MockNetworkService(result: .success(characters: characters))
        let sut = CharactersLoader(networkService: mockNetworkService, paginationManager: PaginationManager())
        
        // Act
        _ = try! await sut.loadCharacters()
        let result = try! await sut.loadCharacters()
        
        // Assert
        XCTAssertFalse(result.isEmpty)
    }
}
