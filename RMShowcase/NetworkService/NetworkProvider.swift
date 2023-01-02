//
//  NetworkProvider.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 12/28/22.
//

import Foundation

protocol NetworkProvider {
    
    // MARK: - Characters
    
    func getCharacters(forPageNumber pageNumber: Int) async throws -> CharactersResponse
    func searchCharacters(_ searchedText: String, pageNumber: Int) async throws -> CharactersResponse
    func character(by id: String) async throws -> DetailedCharacterResponse
}
