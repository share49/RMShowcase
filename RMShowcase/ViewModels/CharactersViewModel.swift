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
    @Published private(set) var characters = [Character]()
    @Published private(set) var isLoading = false
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
        isLoading = true
        
        defer {
            hasItems = !characters.isEmpty
            isLoading = false
        }
        
        do {
            characters = try await charactersLoader.loadCharacters()
            
        } catch NetworkProviderError.noConnection {
            alertMessage = AlertMessageInfo(title: ls.errorTitle, description: ls.noInternetConnection, dismissText: ls.ok)
            
        } catch NetworkProviderError.errorResponse(let message) {
            alertMessage = AlertMessageInfo(title: ls.errorTitle, description: message, dismissText: ls.ok)
            
        } catch {
            alertMessage = AlertMessageInfo(title: ls.unknownError, description: ls.oops, dismissText: ls.ok)
        }
    }
}

#if DEBUG
extension CharactersViewModel {
    static let mock = CharactersViewModel(charactersLoader: CharactersLoader.mock)
}
#endif
