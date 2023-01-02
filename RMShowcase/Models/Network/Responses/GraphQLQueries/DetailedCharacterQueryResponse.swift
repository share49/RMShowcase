//
//  DetailedCharacterQueryResponse.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 1/2/23.
//

import Foundation

struct DetailedCharacterQueryResponse: Decodable {
    
    // MARK: - Properties
    
    let character: DetailedCharacterResponse
    
    // MARK: - Coding keys
    
    private enum CodingKeys: String, CodingKey {
        case character = "character"
    }
}
