//
//  QueryDataResponse.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 12/31/22.
//

import Foundation

struct QueryDataResponse<T: Decodable>: Decodable {
    
    // MARK: - Properties
    
    let data: T
    
    // MARK: - Coding keys
    
    private enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}
