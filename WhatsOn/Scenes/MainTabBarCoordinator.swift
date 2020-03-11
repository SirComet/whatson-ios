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
    case search
}

final class MainTabBarCoordinator: TabBarCoordinator<MainTabBarRoute> {
    
    // MARK: - Properties
    private let servicesContainer: DependenciesContainer
    
    private let moviesRouter: StrongRouter<MoviesRoute>
    private let searchRouter: StrongRouter<SearchRoute>

    // MARK: - Lifecycle
    convenience init(servicesContainer: DependenciesContainer) {
        let moviesCoordinator = MoviesCoordinator(servicesContainer: servicesContainer)
        moviesCoordinator.rootViewController.tabBarItem = UITabBarItem(title: R.string.localizable.tab_bar_movies(),
                                                                       image: R.image.icons_tab_bar_movies(),
                                                                       selectedImage: R.image.icons_tab_bar_movies_selected())
        
        let searchCoordinator = SearchCoordinator(servicesContainer: servicesContainer)
        searchCoordinator.rootViewController.tabBarItem = UITabBarItem(title: R.string.localizable.tab_bar_search(),
                                                                       image: R.image.icons_tab_bar_search(),
                                                                       selectedImage: R.image.icons_tab_bar_search_selected())

        self.init(servicesContainer: servicesContainer, moviesRouter: moviesCoordinator.strongRouter, searchRouter: searchCoordinator.strongRouter)
    }

    private init(servicesContainer: DependenciesContainer, moviesRouter: StrongRouter<MoviesRoute>, searchRouter: StrongRouter<SearchRoute>) {
        self.servicesContainer = servicesContainer
        self.moviesRouter = moviesRouter
        self.searchRouter = searchRouter

        super.init(tabs: [moviesRouter, searchRouter], select: moviesRouter)
    }

    // MARK: - Methods

    override func prepareTransition(for route: MainTabBarRoute) -> TabBarTransition {
        switch route {
        case .movies:
            return .select(moviesRouter)
        case .search:
            return .select(searchRouter)
        }
    }
}
