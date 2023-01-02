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
    private var pageNumber: Int?
    private let paginationManager: PaginationManager
    
    private var items = [Character]()
    private var isLoading = false
    
    // MARK: - Initializer
    
    init(networkService: NetworkProvider, initialPageNumber: Int = Constants.Logic.initialPageNumber, paginationManager: PaginationManager) {
        self.networkService = networkService
        self.pageNumber = initialPageNumber
        self.paginationManager = paginationManager
    }
    
    // MARK: - Methods
    
    func loadCharacters() async throws -> [Character] {
        guard let pageNumber = pageNumber else {
            RMLogger.shared.debug("CharactersLoader: There aren't more pages")
            return items
        }
        
        isLoading = true
        defer { isLoading = false }
        
        let charactersResponse = try await networkService.getCharacters(forPageNumber: pageNumber)
        self.pageNumber = charactersResponse.info.nextPageNumber
        
        let newCharacters = charactersResponse.results.map({ Character(characterResponse: $0) })
        items.append(contentsOf: newCharacters)
        return items
    }
    
    func shouldLoadMoreItems(currentItemId: String) -> Bool {
        guard !isLoading else { return false }
        
        return paginationManager.shouldLoadMoreItems(items: items, currentItemId: currentItemId)
    }
}

#if DEBUG
extension CharactersLoader {
    static let mock = CharactersLoader(networkService: MockNetworkService(result: .success(characters: CharactersResponse.mock)), paginationManager: PaginationManager())
}
#endif
