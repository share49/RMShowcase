//
//  ErrorResponse.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 12/29/22.
//

import Foundation

struct ErrorResponse: Decodable {
    
    // MARK: - Properties
    
    let errors: [ErrorInfoResponse]
    
    // MARK: - Coding keys
    
    private enum CodingKeys: String, CodingKey {
        case errors = "errors"
    }
}
