//
//  NetworkProvider.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 12/28/22.
//

import Foundation

enum NetworkProviderError: Error {
    case errorResponse(message: String)
    case noConnection
}

protocol NetworkProvider {
    
    // MARK: - Characters
    
    func getCharacters() async throws -> CharactersResponse
}
