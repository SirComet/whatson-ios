//
//  MoviesListViewModel.swift
//  What'sOn
//
//  Created by Maxime Maheo on 27/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import XCoordinator
import RxSwift
import RxCocoa
import UIKit

enum MoviesListViewModelAction: ViewModelAction {

}

protocol MoviesListViewModelContract: ViewModel {
    
    // MARK: - Properties
    var title: BehaviorRelay<String> { get }
    var movies: BehaviorRelay<[Movie]> { get }
    
    // MARK: - Methods
    func fetchPoster(for movie: Movie) -> Single<UIImage>
    
}

final class MoviesListViewModel: MoviesListViewModelContract {
    
    // MARK: - Properties
    private let router: UnownedRouter<MoviesRoute>
    private let servicesContainer: DependenciesContainer
        
    private let imagesService: ImagesServiceContract!
    
    private let disposeBag = DisposeBag()
    
    var title: BehaviorRelay<String>
    var movies: BehaviorRelay<[Movie]>
    
    // MARK: - Lifecycle
    init(router: UnownedRouter<MoviesRoute>, servicesContainer: DependenciesContainer, title: String, movies: [Movie]) throws {
        self.router = router
        self.servicesContainer = servicesContainer
        self.title = BehaviorRelay(value: title)
        self.movies = BehaviorRelay(value: movies)
        
        guard let imagesService: ImagesServiceContract = servicesContainer.resolve() else { throw ServiceError.notFound }
        
        self.imagesService = imagesService
    }
    
    // MARK: - Methods
    func handle(action: ViewModelAction) {
        
    }
    
    func fetchPoster(for movie: Movie) -> Single<UIImage> {
        imagesService.fetchImage(for: movie)
    }
    
}
