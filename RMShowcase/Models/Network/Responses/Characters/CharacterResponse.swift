//
//  CharacterResponse.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 12/28/22.
//

import Foundation

struct CharacterResponse: Decodable {
    
    // MARK: - Properties
    
    let id: String
    let name: String
    
    // MARK: - Coding keys
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}

#if DEBUG
extension CharacterResponse {
    static let mock = CharacterResponse(id: "21", name: "Aqua Morty")
}
#endif
