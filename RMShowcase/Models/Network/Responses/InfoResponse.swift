//
//  InfoResponse.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 12/28/22.
//

import Foundation

struct InfoResponse: Decodable {
    
    // MARK: - Properties
    
    let nextPageNumber: Int?
    
    // MARK: - Coding keys
    
    private enum CodingKeys: String, CodingKey {
        case nextPageNumber = "next"
    }
}
