//
//  AppCoordinator.swift
//  Netflix
//
//  Created by Maxime Maheo on 22/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import XCoordinator

enum AppRoute: Route {
    case home
}

class AppCoordinator: NavigationCoordinator<AppRoute> {
    
    // MARK: - Properties
    private let servicesContainer = DependenciesContainer()
    
    // MARK: - Lifecycle
    init() {
        super.init(initialRoute: .home)
    }

    // MARK: - Methods
    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        registerServices()
        
        switch route {
        case .home:
            return .presentFullScreen(MainTabBarCoordinator(servicesContainer: servicesContainer), animation: .fade)
        }
    }
    
    // MARK: - Private methods
    private func registerServices() {
        registerMoviesService()
    }
    
    private func registerMoviesService() {
        do {
            let service = try MoviesService(parameters: nil)
            
            servicesContainer.register(MoviesServiceContract.self, factory: { service })
        } catch {
            print("Error while ceating movies service : \(error)")
        }
    }
}
