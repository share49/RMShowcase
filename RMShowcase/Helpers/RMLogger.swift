//
//  RMLogger.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 1/1/23.
//

import Foundation
import OSLog

final class RMLogger {
    
    // MARK: - Properties
    
    static let shared = RMLogger()
    private let logger = Logger(subsystem: "com.hoowie.RMShowcase", category: "Logger")
    
    // MARK: - Initializer
    
    private init() { }
    
    // MARK: - Methods
    
    func debug(_ message: String) {
        #if DEBUG
        logger.debug("🟢 \(message)")
        #endif
    }
    
    func error(_ message: String) {
        logger.error("🔴 \(message)")
    }
}
