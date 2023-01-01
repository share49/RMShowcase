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
    let imageUrlString: String
    let status: String
    let species: String
    let gender: String
    
    // MARK: - Coding keys
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case imageUrlString = "image"
        case status = "status"
        case species = "species"
        case gender = "gender"
        
    }
}

#if DEBUG
extension CharacterResponse {
    static let mock = CharacterResponse(
        id: "21",
        name: "Aqua Morty",
        imageUrlString: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        status: "Alive",
        species: "Human",
        gender: "Male"
    )
}
#endif
