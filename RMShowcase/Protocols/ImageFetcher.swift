//
//  ImageFetcher.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 1/1/23.
//

import UIKit

enum ImageFetcherError: Error {
    case cantGetUIImageFromData
}

protocol ImageFetcher {
    func fetch(_ url: URL) async throws -> UIImage
    func fetch(_ urlRequest: URLRequest) async throws -> UIImage
    func cancelRequest(_ urlRequest: URLRequest) async
}
