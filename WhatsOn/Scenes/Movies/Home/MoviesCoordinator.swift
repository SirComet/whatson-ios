//
//  MoviesCoordinator.swift
//  Netflix
//
//  Created by Maxime Maheo on 22/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import UIKit
import XCoordinator

enum MoviesRoute: Route {
    case home
    case removeSections
    case createFeaturedSection(childId: String, content: SectionContentType)
    case showSection(childId: String, container: Container)
    case hideSection(childId: String)
}

final class MoviesCoordinator: NavigationCoordinator<MoviesRoute> {
    
    // MARK: - Properties
    private let servicesContainer: DependenciesContainer
    
    private var sections: [String: Presentable] = [:]

    // MARK: - Lifecycle
    init(servicesContainer: DependenciesContainer) {
        self.servicesContainer = servicesContainer
        
        super.init(initialRoute: .home)
    }

    // MARK: - Methods
    override func prepareTransition(for route: MoviesRoute) -> NavigationTransition {
        switch route {
        case .home:
            let viewController = MoviesViewController()
            let viewModel = MoviesViewModel(router: unownedRouter, servicesContainer: servicesContainer)
            viewController.bind(to: viewModel)

            return .push(viewController)
        case .removeSections:
            sections.removeAll()

            return .none()
        case let .createFeaturedSection(childId, content):
            let viewController = FeaturedViewController()
            let viewModel = FeaturedViewModel(router: unownedRouter, servicesContainer: servicesContainer, sectionContentType: content)
            viewController.bind(to: viewModel)

            sections[childId] = viewController

            return .none()
        case let .showSection(childId, container):
            guard let sectionPresentable = sections[childId] else { return .none() }

            return .embed(sectionPresentable, in: container)
        case let .hideSection(childId):
            guard let sectionViewController = sections[childId]?.viewController else {
                return .none()
            }

            sectionViewController.view.removeFromSuperview()
            sectionViewController.willMove(toParent: nil)
            sectionViewController.removeFromParent()

            return .none()
        }
    }
}
