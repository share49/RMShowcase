//
//  Coordinator.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 12/28/22.
//

import SwiftUI

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
}

final class MainCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController
    
    // MARK: - Initializer
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Flows
    
    func start() {
        let hostingController = UIHostingController(rootView: CharactersListView())
        navigationController.pushViewController(hostingController, animated: false)
    }
}

#if DEBUG
extension MainCoordinator {
    static let mock = MainCoordinator(navigationController: UINavigationController())
}
#endif
