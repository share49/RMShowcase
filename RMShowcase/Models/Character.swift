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
    let imageUrlString: String
    let status: String
    let species: String
    let gender: String
}

extension Character {
    
    init(characterResponse: CharacterResponse) {
        id = characterResponse.id
        name = characterResponse.name
        imageUrlString = characterResponse.imageUrlString
        status = characterResponse.status
        species = characterResponse.species
        gender = characterResponse.gender
    }
}

#if DEBUG
extension Character {
    static let mock = Character(characterResponse: CharacterResponse.mock)
}
#endif
