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
    
    @MainActor func start() {
        let networkService = NetworkService()
        let charactersLoader = CharactersLoader(networkService: networkService)
        let viewModel = CharactersViewModel(charactersLoader: charactersLoader)
        
        let hostingController = UIHostingController(rootView: CharactersListView(viewModel: viewModel))
        navigationController.pushViewController(hostingController, animated: false)
    }
}
