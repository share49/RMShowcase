//
//  NavigationControllerMaker.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 12/31/22.
//

import UIKit

struct NavigationControllerMaker {
    
    // MARK: - Properties
    
    private let prefersLargeTitles: Bool
    
    // MARK: - Initializer
    
    init(prefersLargeTitles: Bool = true) {
        self.prefersLargeTitles = prefersLargeTitles
    }
    
    // MARK: - Methods
    
    func make() -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = prefersLargeTitles
        
        return navigationController
    }
}
