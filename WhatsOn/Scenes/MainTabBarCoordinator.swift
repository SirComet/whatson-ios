//
//  MainTabBarCoordinator.swift
//  Netflix
//
//  Created by Maxime Maheo on 22/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//
import UIKit
import XCoordinator

enum MainTabBarRoute: Route {
    case movies
}

final class MainTabBarCoordinator: TabBarCoordinator<MainTabBarRoute> {
    
    // MARK: - Properties
    private let moviesRouter: StrongRouter<MoviesRoute>
    private let servicesContainer: DependenciesContainer

    // MARK: - Lifecycle
    convenience init(servicesContainer: DependenciesContainer) {
        let moviesCoordinator = MoviesCoordinator(servicesContainer: servicesContainer)
        moviesCoordinator.rootViewController.tabBarItem = UITabBarItem(title: R.string.localizable.tab_bar_movies(),
                                                                       image: R.image.icons_tab_bar_movies(),
                                                                       selectedImage: R.image.icons_tab_bar_movies_selected())

        self.init(servicesContainer: servicesContainer, moviesRouter: moviesCoordinator.strongRouter)
    }

    private init(servicesContainer: DependenciesContainer, moviesRouter: StrongRouter<MoviesRoute>) {
        self.servicesContainer = servicesContainer
        self.moviesRouter = moviesRouter

        super.init(tabs: [moviesRouter], select: moviesRouter)
    }

    // MARK: - Methods

    override func prepareTransition(for route: MainTabBarRoute) -> TabBarTransition {
        switch route {
        case .movies:
            return .select(moviesRouter)
        }
    }
}
