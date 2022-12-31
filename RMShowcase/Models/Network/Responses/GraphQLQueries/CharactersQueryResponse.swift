//
//  CharactersQueryResponse.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 12/31/22.
//

import Foundation

struct CharactersQueryResponse: Decodable {
    
    // MARK: - Properties
    
    let characters: CharactersResponse
    
    // MARK: - Coding keys
    
    private enum CodingKeys: String, CodingKey {
        case characters = "characters"
    }
}
