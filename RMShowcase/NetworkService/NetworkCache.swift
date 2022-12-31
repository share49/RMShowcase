//
//  NetworkCache.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 12/29/22.
//

import Foundation

final class NetworkCache<Key: Hashable, Value> {
    
    // MARK: - Properties
    
    private let wrapped = NSCache<WrappedKey, Entry>()
    private let dateProvider: () -> Date
    private let entryLifetime: TimeInterval
    
    // MARK: - Initializer
    
    /// entryLifetime of 1 hour
    init(dateProvider: @escaping () -> Date = Date.init, entryLifetime: TimeInterval = 60 * 60 * 1) {
        self.dateProvider = dateProvider
        self.entryLifetime = entryLifetime
    }
    
    // MARK: - Support methods
    
    private func insert(_ value: Data, forKey key: Key) {
        let date = dateProvider().addingTimeInterval(entryLifetime)
        let entry = Entry(value: value, expirationDate: date)
        wrapped.setObject(entry, forKey: WrappedKey(key))
    }
    
    private func removeValue(forKey key: Key) {
        wrapped.removeObject(forKey: WrappedKey(key))
    }
    
    private func value(forKey key: Key) -> Data? {
        guard let entry = wrapped.object(forKey: WrappedKey(key)) else {
            return nil
        }
        
        guard dateProvider() < entry.expirationDate else {
            removeValue(forKey: key) // Discard values that have expired
            return nil
        }
        
        return entry.value
    }
}

extension NetworkCache {
    
    subscript(key: Key) -> Data? {
        get {
            value(forKey: key)
        }
        set {
            guard let value = newValue else {
                // Removes any value for that key if nil was assigned using subscript
                removeValue(forKey: key)
                return
            }
            
            insert(value, forKey: key)
        }
    }
}

private extension NetworkCache {
    
    final class Entry {
        
        // MARK: - Properties
        
        let value: Data
        let expirationDate: Date
        
        // MARK: - Initializer
        
        init(value: Data, expirationDate: Date) {
            self.value = value
            self.expirationDate = expirationDate
        }
    }
    
    final class WrappedKey: NSObject {
        
        // MARK: - Properties
        
        let key: Key
        override var hash: Int {
            key.hashValue
        }
        
        // MARK: - Initializer
        
        init(_ key: Key) {
            self.key = key
        }
        
        // MARK: - Methods
        
        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? WrappedKey else {
                return false
            }
            
            return value.key == key
        }
    }
}
