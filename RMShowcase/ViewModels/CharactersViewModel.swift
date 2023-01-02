//
//  CharactersViewModel.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 12/29/22.
//

import Foundation
import Combine

@MainActor final class CharactersViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private let charactersLoader: CharactersLoader
    private let charactersSearcher: CharactersSearcher
    
    private var cancellables = Set<AnyCancellable>()
    private var characters = [Character]()
    private var searchedCharacters = [Character]() {
        didSet {
            hasItems = isSearching ? !searchedCharacters.isEmpty : !characters.isEmpty
        }
    }
    private var isSearching: Bool {
        !searchedText.isEmpty
    }
    var items: [Character] {
        isSearching ? searchedCharacters : characters
    }
    
    @Published private(set) var showLoadingView = false
    @Published private(set) var hasItems = false
    @Published var alertMessage: AlertMessageInfo?
    @Published var searchedText = ""
    
    // MARK: - Initializer
    
    init(charactersLoader: CharactersLoader, charactersSearcher: CharactersSearcher) {
        self.charactersLoader = charactersLoader
        self.charactersSearcher = charactersSearcher
        
        setupSearchBinding()
    }
    
    // MARK: - View data
    
    var title: String {
        ls.charactersTitle
    }
    
    var noContentText: String {
        ls.noCharacters
    }
    
    var searchHint: String {
        ls.characterSearchHint
    }
    
    // MARK: - Methods
    
    func loadCharacters() async {
        showLoadingView = !hasItems
        
        defer {
            hasItems = !characters.isEmpty
            showLoadingView = false
        }
        
        do {
            characters = try await charactersLoader.loadCharacters()
            
        } catch NetworkProviderError.noConnection {
            let message = NetworkProviderError.noConnection.message()
            alertMessage = AlertMessageInfo(title: ls.errorTitle, description: message, dismissText: ls.ok)
            
        } catch NetworkProviderError.errorResponse(let message) {
            alertMessage = AlertMessageInfo(title: ls.errorTitle, description: message, dismissText: ls.ok)
            
        } catch {
            alertMessage = AlertMessageInfo(title: ls.unknownError, description: ls.oops, dismissText: ls.ok)
        }
    }
    
    func loadMoreCharactersIfNeeded(currentItemId: String) async {
        if isSearching {
            if charactersSearcher.shouldLoadMoreItems(currentItemId: currentItemId) {
                handleSearchedText(searchedText)
            }
        } else {
            if charactersLoader.shouldLoadMoreItems(currentItemId: currentItemId) {
                await loadCharacters()
            }
        }
    }
    
    // MARK: - Support methods
    
    private func setupSearchBinding() {
        $searchedText
            .removeDuplicates()
            .debounce(for: .seconds(charactersSearcher.debounceTime), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] in self?.handleSearchedText($0) })
            .store(in: &cancellables)
    }
    
    /// Handles search. If the text is empty, it clears the searched characters. It also checks that the text has the required minimum length.
    private func handleSearchedText(_ searchedText: String) {
        guard !searchedText.isEmpty else {
            searchedCharacters.removeAll()
            return
        }
        
        guard searchedText.count >= charactersSearcher.minimumCharactersToSearch else {
            return
        }
        
        Task { await search(searchedText) }
    }
    
    /// Searches text and if successful, it sets the searched characters. On failure, it shows an alert.
    /// If it's a new search, displays a loading indicator while searching.
    private func search(_ searchedText: String) async {
        showLoadingView = !charactersSearcher.hasItems
        defer { showLoadingView = false }
        
        do {
            searchedCharacters = try await charactersSearcher.search(searchedText)
            
        } catch NetworkProviderError.noConnection {
            let message = NetworkProviderError.noConnection.message()
            alertMessage = AlertMessageInfo(title: ls.errorTitle, description: message, dismissText: ls.ok)
            
        } catch NetworkProviderError.errorResponse(let message) {
            alertMessage = AlertMessageInfo(title: ls.errorTitle, description: message, dismissText: ls.ok)
            
        } catch {
            alertMessage = AlertMessageInfo(title: ls.unknownError, description: ls.oops, dismissText: ls.ok)
        }
    }
}

#if DEBUG
extension CharactersViewModel {
    static let mock = CharactersViewModel(charactersLoader: CharactersLoader.mock, charactersSearcher: CharactersSearcher.mock)
}
#endif
