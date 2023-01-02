//
//  CharactersProvider.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 1/2/23.
//

import Foundation

final class CharactersProvider {
    
    // MARK: - Properties
    
    private let loader: CharactersLoader
    private let searcher: CharactersSearcher
    
    // MARK: - Initializer
    
    init(loader: CharactersLoader, searcher: CharactersSearcher) {
        self.loader = loader
        self.searcher = searcher
    }
}
