//
//  CharactersViewModelTests.swift
//  RMShowcaseTests
//
//  Created by Roger Pintó Diaz on 12/31/22.
//

import XCTest
@testable import RMShowcase

@MainActor final class CharactersViewModelTests: XCTestCase {
    
    func testLoadSuccessCharacters() async {
        // Arrange
        let expected = false
        
        let characters = CharactersResponse.mock
        let mockNetworkService = MockNetworkService(result: .success(characters: characters))
        let charactersLoader = CharactersLoader(networkService: mockNetworkService)
        let sut = CharactersViewModel(charactersLoader: charactersLoader)
        
        // Act
        await sut.loadCharacters()
        let result = sut.characters.isEmpty
        
        // Assert
        XCTAssertEqual(result, expected)
    }
    
    func testLoadSuccessHasItems() async {
        // Arrange
        let expected = true
        
        let characters = CharactersResponse.mock
        let mockNetworkService = MockNetworkService(result: .success(characters: characters))
        let charactersLoader = CharactersLoader(networkService: mockNetworkService)
        let sut = CharactersViewModel(charactersLoader: charactersLoader)
        
        // Act
        await sut.loadCharacters()
        let result = sut.hasItems
        
        // Assert
        XCTAssertEqual(result, expected)
    }
    
    func testLoadSuccessStoppedLoading() async {
        // Arrange
        let expected = false
        
        let characters = CharactersResponse.mock
        let mockNetworkService = MockNetworkService(result: .success(characters: characters))
        let charactersLoader = CharactersLoader(networkService: mockNetworkService)
        let sut = CharactersViewModel(charactersLoader: charactersLoader)
        
        // Act
        await sut.loadCharacters()
        let result = sut.isFirstLoad
        
        // Assert
        XCTAssertEqual(result, expected)
    }
    
    func testLoadSuccessNotShowingAlert() async {
        // Arrange
        let characters = CharactersResponse.mock
        let mockNetworkService = MockNetworkService(result: .success(characters: characters))
        let charactersLoader = CharactersLoader(networkService: mockNetworkService)
        let sut = CharactersViewModel(charactersLoader: charactersLoader)
        
        // Act
        await sut.loadCharacters()
        let result = sut.alertMessage
        
        // Assert
        XCTAssertNil(result)
    }
    
    func testLoadFailureWithNoConnectionMessage() async {
        // Arrange
        let error = NetworkProviderError.noConnection
        let expected = error.message()
        
        let mockNetworkService = MockNetworkService(result: .failure(error: error))
        let charactersLoader = CharactersLoader(networkService: mockNetworkService)
        let sut = CharactersViewModel(charactersLoader: charactersLoader)
        
        // Act
        await sut.loadCharacters()
        let result = sut.alertMessage?.description
        
        // Assert
        XCTAssertEqual(result, expected)
    }
    
    func testLoadFailureWithErrorResponseMessage() async {
        // Arrange
        let expected = "Failed to load"
        let error = NetworkProviderError.errorResponse(message: expected)
        
        let mockNetworkService = MockNetworkService(result: .failure(error: error))
        let charactersLoader = CharactersLoader(networkService: mockNetworkService)
        let sut = CharactersViewModel(charactersLoader: charactersLoader)
        
        // Act
        await sut.loadCharacters()
        let result = sut.alertMessage?.description
        
        // Assert
        XCTAssertEqual(result, expected)
    }
    
    func testLoadFailureWithUnknownError() async {
        // Arrange
        let expected = ls.oops
        
        let error = NSError()
        let mockNetworkService = MockNetworkService(result: .failure(error: error))
        let charactersLoader = CharactersLoader(networkService: mockNetworkService)
        let sut = CharactersViewModel(charactersLoader: charactersLoader)
        
        // Act
        await sut.loadCharacters()
        let result = sut.alertMessage?.description
        
        // Assert
        XCTAssertEqual(result, expected)
    }
}
