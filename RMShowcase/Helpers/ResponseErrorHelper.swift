//
//  ResponseErrorHelper.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 12/29/22.
//

import Foundation

/// ResponseErrorHelper transforms an error response into an understandable error message by localizing the message, parsing an error code or providing additional information about an error.
struct ResponseErrorHelper {
    
    // MARK: - Methods
    
    /// Returns a user friendly error message of an ErrorResponse.
    static func message(for errorResponse: ErrorResponse, defaultMessage: String = ls.unknownError) -> String {
        errorResponse.errors.first?.message ?? defaultMessage
    }
}
