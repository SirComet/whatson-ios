//
//  SearchCoordinator.swift
//  What'sOn
//
//  Created by Maxime Maheo on 11/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import XCoordinator
import SwiftUI

enum SearchRoute: Route {
    case home
}

final class SearchCoordinator: NavigationCoordinator<SearchRoute> {
    
    // MARK: - Properties
    private let servicesContainer: DependenciesContainer
    
    // MARK: - Lifecycle
    init(servicesContainer: DependenciesContainer) {
        self.servicesContainer = servicesContainer
        
        super.init(initialRoute: .home)
    }

    // MARK: - Methods
    override func prepareTransition(for route: SearchRoute) -> NavigationTransition {
        switch route {
        case .home:
            return routeToHome()
        }
    }
    
    // MARK: - Private methods
    private func routeToHome() -> NavigationTransition {
        let view = SearchView(viewModel: SearchViewModel(router: unownedRouter, servicesContainer: servicesContainer))
        let viewController = UIHostingController(rootView: view)
        
        return .push(viewController)
    }
}
