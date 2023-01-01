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
    private var pageNumber: Int?
    
    // MARK: - Initializer
    
    init(networkService: NetworkProvider, initialPageNumber: Int = 1) {
        self.networkService = networkService
        self.pageNumber = initialPageNumber
    }
    
    // MARK: - Methods
    
    func loadCharacters() async throws -> [Character] {
        guard let pageNumber = pageNumber else {
            RMLogger.shared.debug("CharactersLoader: There aren't more pages")
            return []
        }
        
        let charactersResponse = try await networkService.getCharacters(forPageNumber: pageNumber)
        self.pageNumber = charactersResponse.info.nextPageNumber
        
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
