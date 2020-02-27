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
    case createStandardSection(childId: String, content: SectionContentType)
    case createGenreSection(childId: String, content: SectionContentType)
    
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
            createFeaturedSection(childId: childId, content: content)
            
            return .none()
        case let .createStandardSection(childId, content):
            createStandardSection(childId: childId, content: content)
            
            return .none()
        case let .createGenreSection(childId, content):
            createGenreSection(childId: childId, content: content)
            
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
    
    private func createFeaturedSection(childId: String, content: SectionContentType) {
        do {
            let viewController = FeaturedViewController()
            let viewModel = try FeaturedViewModel(router: unownedRouter, servicesContainer: servicesContainer, sectionContentType: content)
            viewController.bind(to: viewModel)

            sections[childId] = viewController
        } catch {
            print("Error while creating featured section : \(error)")
        }
    }
    
    private func createStandardSection(childId: String, content: SectionContentType) {
        do {
            let viewController = StandardViewController()
            let viewModel = try StandardViewModel(router: unownedRouter, servicesContainer: servicesContainer, sectionContentType: content)
            viewController.bind(to: viewModel)

            sections[childId] = viewController
        } catch {
            print("Error while creating standard section : \(error)")
        }
    }
    
    private func createGenreSection(childId: String, content: SectionContentType) {
        do {
            let viewController = GenreViewController()
            let viewModel = try GenreViewModel(router: unownedRouter, servicesContainer: servicesContainer, sectionContentType: content)
            viewController.bind(to: viewModel)

            sections[childId] = viewController
        } catch {
            print("Error while creating genre section : \(error)")
        }
    }
}
