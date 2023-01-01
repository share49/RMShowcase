//
//  CharactersResponse.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 12/28/22.
//

import Foundation

struct CharactersResponse: Decodable {
    
    // MARK: - Properties
    
    let info: InfoResponse
    let results: [CharacterResponse]
    
    // MARK: - Coding keys
    
    private enum CodingKeys: String, CodingKey {
        case info = "info"
        case results = "results"
    }
}

#if DEBUG
extension CharactersResponse {
    static let mock = CharactersResponse(info: InfoResponse.mock, results: [CharacterResponse.mock])
}
#endif
