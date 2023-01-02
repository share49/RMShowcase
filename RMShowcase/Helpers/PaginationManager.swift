//
//  PaginationManager.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 1/2/23.
//

import Foundation

struct PaginationManager {
    
    // MARK: - Properties
    
    /// Number of elements remaining to reach the end of the array.
    /// This number is used to trigger paging as the list of items nears the end.
    private let remainingItemsToStartPagination: Int
    
    // MARK: - Initializer
    
    init(remainingItemsToStartPagination: Int = Constants.Logic.remainingItemsToStartPagination) {
        self.remainingItemsToStartPagination = remainingItemsToStartPagination
    }
    
    // MARK: - Methods
    
    func shouldLoadMoreItems(items: [any Identifiable<String>], currentItemId: String) -> Bool {
        let paginationIndex = items.endIndex - remainingItemsToStartPagination
        
        guard paginationIndex > 0 && paginationIndex < items.count else {
            return false
        }
        
        return items[paginationIndex].id == currentItemId
    }
}
