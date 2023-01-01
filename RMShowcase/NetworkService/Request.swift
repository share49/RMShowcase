//
//  Request.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 12/28/22.
//

import Foundation

enum HttpMethod: String {
    case get, post, put, delete
}

struct Request {
    
    // MARK: - Requests
    
    static func characters() -> URLRequest {
        let query = """
                    {
                        characters {
                            info { next }
                            results { id name image status species gender }
                        }
                    }
                    """
        return GraphQLRequest(query: query).request
    }
}
