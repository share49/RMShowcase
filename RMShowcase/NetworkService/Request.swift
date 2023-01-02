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
    
    static func characters(forPageNumber pageNumber: Int) -> URLRequest {
        let query = """
                    {
                        characters(page: \(pageNumber)) {
                            info { next }
                            results { id name image status species gender }
                        }
                    }
                    """
        return GraphQLRequest(query: query).request
    }
    
    static func searchCharacters(_ searchedText: String, pageNumber: Int) -> URLRequest {
        let query = """
                    {
                        characters(page: \(pageNumber), filter: { name: "\(searchedText)" }) {
                            info { next }
                            results { id name image status species gender }
                        }
                    }
                    """
        return GraphQLRequest(query: query).request
    }
    
    static func character(by id: String) -> URLRequest {
        let query = """
                    {
                        character(id: "\(id)") { id name image status species gender type location { name } }
                    }
                    """
        return GraphQLRequest(query: query).request
    }
}
