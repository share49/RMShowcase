//
//  Endpoint.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 12/28/22.
//

import Foundation

struct Endpoint {
    
    // MARK: - Properties
    
    let path: String
    var queryItems = [URLQueryItem]()
    var url: URL {
        var components = URLComponents()
        components.scheme = Constants.API.scheme
        components.host = Constants.API.host
        components.path = "/" + path
        components.queryItems = queryItems.isEmpty ? nil : queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        return url
    }
    
    // MARK: - Endpoints
    
    static func graphQL() -> Self {
        Endpoint(path: Constants.API.graphQL)
    }
}
