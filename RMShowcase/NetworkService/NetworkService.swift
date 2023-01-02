//
//  NetworkService.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 12/28/22.
//

import Foundation

struct NetworkService: NetworkProvider {
    
    // MARK: - Properties
    
    private let urlSession: URLSession
    private let cache: NetworkCache<String, Data>
    
    // MARK: - Initializer
    
    init(urlSession: URLSession = .shared, cache: NetworkCache<String, Data> = NetworkCache<String, Data>()) {
        self.urlSession = urlSession
        self.cache = cache
    }
    
    // MARK: - Characters
    
    /// Gets the 20 characters of the desired page number. Uses the cached response if it exists.
    func getCharacters(forPageNumber pageNumber: Int) async throws -> CharactersResponse {
        let cacheId = "\(Constants.NetworkCache.characters)\(pageNumber)"
        
        if let cachedData = cache[cacheId] {
            let queryDataResponse: QueryDataResponse<CharactersQueryResponse> = try decodeDataWithErrorHandling(data: cachedData)
            return queryDataResponse.data.characters
        }
        
        let request = Request.characters(forPageNumber: pageNumber)
        let (data, _) = try await performRequest(request)
        let queryDataResponse: QueryDataResponse<CharactersQueryResponse> = try decodeDataWithErrorHandling(data: data, cacheKey: cacheId)
        return queryDataResponse.data.characters
    }
    
    /// Search and get the 20 characters of the desired page number. Uses the cached response if it exists.
    func searchCharacters(_ searchedText: String, pageNumber: Int) async throws -> CharactersResponse {
        let cacheId = "\(Constants.NetworkCache.characters)_\(searchedText.lowercased())_\(pageNumber)"
        
        if let cachedData = cache[cacheId] {
            let queryDataResponse: QueryDataResponse<CharactersQueryResponse> = try decodeDataWithErrorHandling(data: cachedData)
            return queryDataResponse.data.characters
        }
        
        let request = Request.searchCharacters(searchedText, pageNumber: pageNumber)
        let (data, _) = try await performRequest(request)
        let queryDataResponse: QueryDataResponse<CharactersQueryResponse> = try decodeDataWithErrorHandling(data: data, cacheKey: cacheId)
        return queryDataResponse.data.characters
    }
    
    // MARK: - Support methods
    
    /// Performs a request and handles if there is no network connection by throwing an error.
    private func performRequest(_ request: URLRequest) async throws -> (Data, URLResponse) {
        do {
            return try await urlSession.data(for: request)
        } catch {
            if (error as NSError).code == Constants.API.ErrorCodes.noConnection {
                throw NetworkProviderError.noConnection
            } else {
                throw error
            }
        }
    }
    
    /// Decode data and handle response errors.
    private func decodeDataWithErrorHandling<T: Decodable>(data: Data, jsonDecoder: JSONDecoder = JSONDecoder(), cacheKey: String? = nil) throws -> T {
        if let decodedData: T = try? jsonDecoder.decode(T.self, from: data) {
            if let cacheKey = cacheKey {
                cache[cacheKey] = data
            }
            
            return decodedData
            
        } else if let errorResponse = try? jsonDecoder.decode(ErrorResponse.self, from: data) {
            let errorMessage = ResponseErrorHelper.message(for: errorResponse)
            throw NetworkProviderError.errorResponse(message: errorMessage)
        }
        
        throw NetworkProviderError.errorResponse(message: ls.oops)
    }
}
