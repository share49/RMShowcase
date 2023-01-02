//
//  MockNetworkService.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 12/31/22.
//

import Foundation

enum MockNetworkServiceResult {
    case success(item: Decodable)
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
            return characters as! CharactersResponse
            
        case .failure(let error):
            throw error
        }
    }
    
    func searchCharacters(_ searchedText: String, pageNumber: Int) async throws -> CharactersResponse {
        switch result {
        case .success(let characters):
            return characters as! CharactersResponse
            
        case .failure(let error):
            throw error
        }
    }
    
    func character(by id: String) async throws -> DetailedCharacterResponse {
        switch result {
        case .success(let character):
            return character as! DetailedCharacterResponse
            
        case .failure(let error):
            throw error
        }
    }
}
