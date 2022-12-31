//
//  ErrorInfoResponse.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 12/31/22.
//

import Foundation

struct ErrorInfoResponse: Decodable {
    
    // MARK: - Properties
    
    let message: String
    
    // MARK: - Coding keys
    
    private enum CodingKeys: String, CodingKey {
        case message = "message"
    }
}
