//
//  DetailedCharacterResponse.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 1/2/23.
//

import Foundation

struct DetailedCharacterResponse: Decodable {
    
    // MARK: - Properties
    
    let id: String
    let name: String
    let imageUrlString: String
    let status: String
    let species: String
    let gender: String
    let type: String
    let location: LocationResponse
    
    // MARK: - Coding keys
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case imageUrlString = "image"
        case status = "status"
        case species = "species"
        case gender = "gender"
        case type = "type"
        case location = "location"
    }
}

#if DEBUG
extension DetailedCharacterResponse {
    static let mock = DetailedCharacterResponse(
        id: "21",
        name: "Aqua Morty",
        imageUrlString: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        status: "Alive",
        species: "Human",
        gender: "Male",
        type: "Rick's Toxic Side",
        location: LocationResponse(name: "Earth")
    )
}
#endif
