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
    let type: String?
    let locationName: String?
}

extension Character {
    
    init(withResponse response: CharacterResponse) {
        id = response.id
        name = response.name
        imageUrlString = response.imageUrlString
        status = response.status
        species = response.species
        gender = response.gender
        type = nil
        locationName = nil
    }
    
    init(withResponse response: DetailedCharacterResponse) {
        id = response.id
        name = response.name
        imageUrlString = response.imageUrlString
        status = response.status
        species = response.species
        gender = response.gender
        type = response.type
        locationName = response.location.name
    }
}

#if DEBUG
extension Character {
    static let mock = Character(withResponse: CharacterResponse.mock)
}
#endif
