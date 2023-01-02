//
//  ImageFetcher.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 1/1/23.
//

import UIKit

enum ImageFetcherError: Error {
    case cantGetUIImageFromData
    case cantBuildUrl
}

protocol ImageFetcher {
    func fetch(_ urlString: String) async throws -> UIImage
    func fetch(_ url: URL) async throws -> UIImage
    func fetch(_ urlRequest: URLRequest) async throws -> UIImage
    func cancelFetch(_ urlString: String) async
    func cancelFetch(_ urlRequest: URLRequest) async
}
