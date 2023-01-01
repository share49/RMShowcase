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
    
    struct UI {
        static let smallMargin: CGFloat = bigMargin / 3
        static let bigMargin: CGFloat = 24 // Apple's margin
        
        static let avatarCornerRadius: CGFloat = 10
        
        static let avatarHeight: CGFloat = 100
    }
    
    struct Image {
        static let avatarPlaceholder = "logoSmall"
    }
}
