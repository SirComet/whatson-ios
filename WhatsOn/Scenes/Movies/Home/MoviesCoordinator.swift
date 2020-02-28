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
    case moviesList(title: String, movies: [Movie])
    case movieDetails(movie: Movie)
    case dismissMovieDetails
    
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
            return routeToHome()
        case let .moviesList(title, movies):
            return routeToMoviesList(title: title, movies: movies)
        case let .movieDetails(movie):
            return routeToMovieDetails(movie: movie)
        case .dismissMovieDetails:
            return .pop(animation: .fade)
        case .removeSections:
            sections.removeAll()

            return .none()
        case let .createFeaturedSection(childId, content):
            return createFeaturedSection(childId: childId, content: content)
        case let .createStandardSection(childId, content):
            return createStandardSection(childId: childId, content: content)
        case let .createGenreSection(childId, content):
            return createGenreSection(childId: childId, content: content)
        case let .showSection(childId, container):
            return routeToSection(childId: childId, container: container)
        case let .hideSection(childId):
            return hideSection(childId: childId)
        }
    }
    
    // MARK: - Private methods
    private func routeToHome() -> NavigationTransition {
        let viewController = MoviesViewController()
        let viewModel = MoviesViewModel(router: unownedRouter, servicesContainer: servicesContainer)
        viewController.bind(to: viewModel)

        return .push(viewController)
    }
    
    private func routeToMoviesList(title: String, movies: [Movie]) -> NavigationTransition {
        let viewController = MoviesListViewController()
        guard
            let viewModel = try? MoviesListViewModel(router: unownedRouter,
                                                     servicesContainer: servicesContainer,
                                                     title: title,
                                                     movies: movies)
        else { return .none() }
        
        viewController.bind(to: viewModel)

        return .push(viewController)
    }
    
    private func routeToMovieDetails(movie: Movie) -> NavigationTransition {
        let viewController = MovieDetailsViewController()
        guard
            let viewModel = try? MovieDetailsViewModel(router: unownedRouter,
                                                       servicesContainer: servicesContainer,
                                                       movie: movie)
        else { return .none() }
        
        viewController.bind(to: viewModel)

        return .push(viewController, animation: .fade)
    }
    
    private func routeToSection(childId: String, container: Container) -> NavigationTransition {
        guard let sectionPresentable = sections[childId] else { return .none() }

        return .embed(sectionPresentable, in: container)
    }
    
    private func hideSection(childId: String) -> NavigationTransition {
        guard let sectionViewController = sections[childId]?.viewController else { return .none() }

        sectionViewController.view.removeFromSuperview()
        sectionViewController.willMove(toParent: nil)
        sectionViewController.removeFromParent()
        
        return .none()
    }
    
    private func createFeaturedSection(childId: String, content: SectionContentType) -> NavigationTransition {
        do {
            let viewController = FeaturedViewController()
            let viewModel = try FeaturedViewModel(router: unownedRouter, servicesContainer: servicesContainer, sectionContentType: content)
            viewController.bind(to: viewModel)

            sections[childId] = viewController
        } catch {
            print("Error while creating featured section : \(error)")
        }
        
        return .none()
    }
    
    private func createStandardSection(childId: String, content: SectionContentType) -> NavigationTransition {
        do {
            let viewController = StandardViewController()
            let viewModel = try StandardViewModel(router: unownedRouter, servicesContainer: servicesContainer, sectionContentType: content)
            viewController.bind(to: viewModel)

            sections[childId] = viewController
        } catch {
            print("Error while creating standard section : \(error)")
        }
        
        return .none()
    }
    
    private func createGenreSection(childId: String, content: SectionContentType) -> NavigationTransition {
        do {
            let viewController = GenreViewController()
            let viewModel = try GenreViewModel(router: unownedRouter, servicesContainer: servicesContainer, sectionContentType: content)
            viewController.bind(to: viewModel)

            sections[childId] = viewController
        } catch {
            print("Error while creating genre section : \(error)")
        }
        
        return .none()
    }
}
