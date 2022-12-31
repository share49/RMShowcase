//
//  Constants.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 12/28/22.
//

import Foundation

struct Constants {
    
    struct API {
        static let scheme = "https"
        static let graphQL = "graphql"
        static let host = "rickandmortyapi.com"
        
        struct ErrorCodes {
            static let noConnection = -1009 // No network connection
        }
    }
    
    struct NetworkCache {
        static let characters = "characters"
    }
}
