//
//  CharactersSearcher.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 1/2/23.
//

import Foundation

final class CharactersSearcher {
    
    // MARK: - Properties
    
    private let networkService: NetworkProvider
    private var pageNumber: Int?
    private let paginationManager: PaginationManager
    /// Search debounce time in seconds.
    let debounceTime: Double
    /// Minimum characters number that a text must have to perform the search.
    let minimumCharactersToSearch: Int
    
    private var items = [Character]()
    private var isLoading = false
    private var currentSearch = "" {
        willSet {
            if currentSearch != newValue {
                // Reset page number for new searches
                pageNumber = Constants.Logic.initialPageNumber
                items.removeAll()
            }
        }
    }
    var hasItems: Bool {
        !items.isEmpty
    }
    
    // MARK: - Initializer
    
    init(
        networkService: NetworkProvider,
        initialPageNumber: Int = Constants.Logic.initialPageNumber,
        paginationManager: PaginationManager,
        debounceTime: Double = Constants.Logic.Search.debounceTime,
        minimumCharactersToSearch: Int = Constants.Logic.Search.minimumCharactersToSearch
    ) {
        self.networkService = networkService
        self.pageNumber = initialPageNumber
        self.paginationManager = paginationManager
        self.debounceTime = debounceTime
        self.minimumCharactersToSearch = minimumCharactersToSearch
    }
    
    // MARK: - Methods
    
    func search(_ searchedText: String) async throws -> [Character] {
        currentSearch = searchedText
        
        guard let pageNumber = pageNumber else {
            RMLogger.shared.debug("CharactersSearcher: There aren't more pages")
            return items
        }
        
        isLoading = true
        defer { isLoading = false }
        
        let charactersResponse = try await networkService.searchCharacters(searchedText, pageNumber: pageNumber)
        self.pageNumber = charactersResponse.info.nextPageNumber
        
        let newCharacters = charactersResponse.results.map({ Character(withResponse: $0) })
        items.append(contentsOf: newCharacters)
        return items
    }
    
    func shouldLoadMoreItems(currentItemId: String) -> Bool {
        guard !isLoading else { return false }
        
        return paginationManager.shouldLoadMoreItems(items: items, currentItemId: currentItemId)
    }
}

#if DEBUG
extension CharactersSearcher {
    static let mock = CharactersSearcher(networkService: MockNetworkService(result: .success(item: CharactersResponse.mock)), paginationManager: PaginationManager())
}
#endif
