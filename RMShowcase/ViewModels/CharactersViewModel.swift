//
//  CharactersViewModel.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 12/29/22.
//

import Foundation

@MainActor final class CharactersViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private let charactersLoader: CharactersLoader
    private var paginationCharacterId = ""
    private var isLoading = false
    @Published private(set) var characters = [Character]()
    @Published private(set) var isFirstLoad = false
    @Published private(set) var hasItems = false
    @Published var alertMessage: AlertMessageInfo?
    
    // MARK: - Initializer
    
    init(charactersLoader: CharactersLoader) {
        self.charactersLoader = charactersLoader
    }
    
    // MARK: - View data
    
    var title: String {
        ls.charactersTitle
    }
    
    var noContentText: String {
        ls.noCharacters
    }
    
    // MARK: - Methods
    
    func loadCharacters() async {
        isFirstLoad = !hasItems
        isLoading = true
        
        defer {
            hasItems = !characters.isEmpty
            isFirstLoad = false
            isLoading = false
        }
        
        do {
            characters = try await charactersLoader.loadCharacters()
            setPaginationCharacterId()
            
        } catch NetworkProviderError.noConnection {
            let message = NetworkProviderError.noConnection.message()
            alertMessage = AlertMessageInfo(title: ls.errorTitle, description: message, dismissText: ls.ok)
            
        } catch NetworkProviderError.errorResponse(let message) {
            alertMessage = AlertMessageInfo(title: ls.errorTitle, description: message, dismissText: ls.ok)
            
        } catch {
            alertMessage = AlertMessageInfo(title: ls.unknownError, description: ls.oops, dismissText: ls.ok)
        }
    }
    
    func loadMoreCharactersIfNeeded(currentCharacterId: String) async {
        guard hasItems && !isLoading,
              let paginationCharacterId = Int(paginationCharacterId),
              let currentCharacterId = Int(currentCharacterId),
              paginationCharacterId < currentCharacterId else {
            
            return
        }
        
        await loadCharacters()
    }
    
    // MARK: - Support methods
    
    private func setPaginationCharacterId() {
        let paginationIndex = characters.endIndex - 5
        if paginationIndex < characters.count && paginationIndex > 0 {
            paginationCharacterId = characters[characters.endIndex - 5].id
        }
    }
}

#if DEBUG
extension CharactersViewModel {
    static let mock = CharactersViewModel(charactersLoader: CharactersLoader.mock)
}
#endif
