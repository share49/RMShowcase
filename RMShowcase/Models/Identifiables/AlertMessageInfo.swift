//
//  AlertMessageInfo.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 12/31/22.
//

import Foundation

struct AlertMessageInfo: Identifiable {

    // MARK: - Properties
    
    let id = UUID()
    let title: String
    let description: String
    let dismissText: String
}
