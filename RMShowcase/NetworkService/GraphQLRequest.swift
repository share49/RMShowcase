//
//  GraphQLRequest.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 12/31/22.
//

import Foundation

struct GraphQLRequest {
    
    // MARK: - Properties
    
    let query: String
    var request: URLRequest {
        let queryRequest = QueryRequest(query: query)
        
        var request = URLRequest(url: Endpoint.graphQL().url)
        request.httpMethod = HttpMethod.post.rawValue
        request.httpBody = try? JSONEncoder().encode(queryRequest)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
}
