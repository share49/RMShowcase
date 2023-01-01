//
//  CharactersLoader.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 12/29/22.
//

import Foundation

final class CharactersLoader {
    
    // MARK: - Properties
    
    private let networkService: NetworkProvider
    private var characters = [Character]()
    
    // MARK: - Initializer
    
    init(networkService: NetworkProvider) {
        self.networkService = networkService
    }
    
    // MARK: - Methods
    
    func loadCharacters() async throws -> [Character] {
        let charactersResponse = try await networkService.getCharacters()
        
        let newCharacters = charactersResponse.results.map({ Character(characterResponse: $0) })
        characters.append(contentsOf: newCharacters)
        
        return characters
    }
}

#if DEBUG
extension CharactersLoader {
    static let mock = CharactersLoader(networkService: MockNetworkService(result: .success(characters: CharactersResponse.mock)))
}
#endif
