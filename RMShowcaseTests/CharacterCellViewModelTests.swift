//
//  CharacterCellViewModelTests.swift
//  RMShowcaseTests
//
//  Created by Roger Pintó Diaz on 1/2/23.
//

import XCTest
@testable import RMShowcase

@MainActor final class CharacterCellViewModelTests: XCTestCase {
    
    func testCharacterName() {
        // Arrange
        let characterResponse = CharacterResponse.mock
        let expected = characterResponse.name
        
        let character = Character(withResponse: characterResponse)
        let sut = CharacterCellViewModel(character: character, imageFetcher: ImageLoader())
        
        // Act
        let result = sut.name
        
        // Assert
        XCTAssertEqual(result, expected)
    }
    
    func testCharacterStatus() {
        // Arrange
        let characterResponse = CharacterResponse.mock
        let expected = "\(ls.characterStatus): \(characterResponse.status)"
        
        let character = Character(withResponse: characterResponse)
        let sut = CharacterCellViewModel(character: character, imageFetcher: ImageLoader())
        
        // Act
        let result = sut.status
        
        // Assert
        XCTAssertEqual(result, expected)
    }
    
    func testCharacterSpeciesAndGender() {
        // Arrange
        let characterResponse = CharacterResponse.mock
        let expected = "\(characterResponse.species) - \(characterResponse.gender)"
        
        let character = Character(withResponse: characterResponse)
        let sut = CharacterCellViewModel(character: character, imageFetcher: ImageLoader())
        
        // Act
        let result = sut.speciesAndGender
        
        // Assert
        XCTAssertEqual(result, expected)
    }
}
