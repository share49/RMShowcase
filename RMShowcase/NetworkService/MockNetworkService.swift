//
//  MockNetworkService.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 12/31/22.
//

import Foundation

enum MockNetworkServiceResult {
    case success(characters: CharactersResponse)
    case failure(error: Error)
}

struct MockNetworkService: NetworkProvider {
    
    // MARK: - Properties
    
    private let result: MockNetworkServiceResult
    
    // MARK: - Initializer
    
    init(result: MockNetworkServiceResult) {
        self.result = result
    }
    
    // MARK: - NetworkProvider
    
    func getCharacters(forPageNumber pageNumber: Int) async throws -> CharactersResponse {
        switch result {
        case .success(let characters):
            return characters
            
        case .failure(let error):
            throw error
        }
    }
}
