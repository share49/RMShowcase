//
//  LocationResponse.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 1/2/23.
//

import Foundation

struct LocationResponse: Decodable {
    
    // MARK: - Properties
    
    let name: String
    
    // MARK: - Coding keys
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
    }
}
