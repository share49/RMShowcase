//
//  Character.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 12/31/22.
//

import Foundation

struct Character: Identifiable {
    
    // MARK: - Properties
    
    let id: String
    let name: String
}

extension Character {
    
    init(characterResponse: CharacterResponse) {
        id = characterResponse.id
        name = characterResponse.name
    }
}

#if DEBUG
extension Character {
    static let mock = Character(characterResponse: CharacterResponse.mock)
}
#endif
