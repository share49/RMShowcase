//
//  NetworkProviderError.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 1/1/23.
//

import Foundation

enum NetworkProviderError: Error {
    
    case errorResponse(message: String)
    case noConnection
    
    /// Returns the associated message if the error has an input
    /// message and else a localized description of the error
    func message() -> String {
        switch self {
        case .errorResponse(let message):
            return message
            
        case .noConnection:
            return ls.noInternetConnection
        }
    }
}
