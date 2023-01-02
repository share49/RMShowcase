//
//  ImageLoader.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 1/1/23.
//

import UIKit

actor ImageLoader: ImageFetcher {
    
    // MARK: - Enums
    
    private enum LoaderStatus {
        case inProgress(Task<UIImage, Error>)
        case fetched(UIImage)
    }
    
    // MARK: - Properties
    
    private let urlSession: URLSession
    private var images = [URLRequest: LoaderStatus]()
    
    // MARK: - Initializer
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    // MARK: - Methods
    
    func fetch(_ urlString: String) async throws -> UIImage {
        guard let url = URL(string: urlString) else {
            RMLogger.shared.error("ImageLoader: Can't get URL for: \(urlString)")
            throw ImageFetcherError.cantBuildUrl
        }
        
        let request = URLRequest(url: url)
        return try await fetch(request)
    }
    
    func fetch(_ url: URL) async throws -> UIImage {
        let request = URLRequest(url: url)
        return try await fetch(request)
    }
    
    func fetch(_ urlRequest: URLRequest) async throws -> UIImage {
        if let status = images[urlRequest] {
            switch status {
            case .fetched(let image):
                return image
            case .inProgress(let task):
                return try await task.value
            }
        }
        
        if let image = imageFromFileSystem(for: urlRequest) {
            images[urlRequest] = .fetched(image)
            return image
        }
        
        let task: Task<UIImage, Error> = Task {
            let (imageData, _) = try await urlSession.data(for: urlRequest)
            
            guard let image = UIImage(data: imageData) else {
                RMLogger.shared.error("ImageLoader: cantGetUIImageFromData")
                throw ImageFetcherError.cantGetUIImageFromData
            }
            
            persistImageData(imageData, for: urlRequest)
            
            return image
        }
        
        images[urlRequest] = .inProgress(task)
        
        let image = try await task.value
        
        images[urlRequest] = .fetched(image)
        
        return image
    }
    
    func cancelFetch(_ urlString: String) async {
        guard let url = URL(string: urlString) else {
            RMLogger.shared.error("ImageLoader: Can't get URL for: \(urlString)")
            return
        }
        
        await cancelFetch(URLRequest(url: url))
    }
    
    func cancelFetch(_ urlRequest: URLRequest) async {
        if case .inProgress(let task) = images[urlRequest] {
            task.cancel()
            images.removeValue(forKey: urlRequest)
        }
    }
    
    // MARK: - Support methods
    
    private func imageFromFileSystem(for urlRequest: URLRequest) -> UIImage? {
        guard let url = fileName(for: urlRequest) else {
            RMLogger.shared.error("ImageLoader: Unable to generate a local path for \(urlRequest)")
            return nil
        }
        
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        
        return UIImage(data: data)
    }
    
    private func fileName(for urlRequest: URLRequest) -> URL? {
        guard let urlString = urlRequest.url?.absoluteString,
              let applicationSupport = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            
            return nil
        }
        
        let fileName = urlString.replacingOccurrences(of: "https://", with: "").replacingOccurrences(of: "/", with: "_")
        return applicationSupport.appendingPathComponent(fileName)
    }
    
    private func persistImageData(_ imageData: Data, for urlRequest: URLRequest) {
        guard let url = fileName(for: urlRequest) else {
            RMLogger.shared.error("ImageLoader: Unable to generate a local path for \(urlRequest)")
            return
        }
        
        do {
            try imageData.write(to: url)
        } catch {
            RMLogger.shared.error("ImageLoader: Writing image data to \(url.absoluteURL)")
        }
    }
}
