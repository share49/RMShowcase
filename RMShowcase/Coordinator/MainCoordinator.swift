//
//  MainCoordinator.swift
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
        let paginationManager = PaginationManager()
        let charactersLoader = CharactersLoader(networkService: networkService, paginationManager: paginationManager)
        let charactersSearcher = CharactersSearcher(networkService: networkService, paginationManager: paginationManager)
        let viewModel = CharactersViewModel(charactersLoader: charactersLoader, charactersSearcher: charactersSearcher)
        let imageLoader = ImageLoader()
        
        let hostingController = UIHostingController(rootView: CharactersListView(viewModel: viewModel, imageFetcher: imageLoader))
        navigationController.pushViewController(hostingController, animated: false)
    }
}
