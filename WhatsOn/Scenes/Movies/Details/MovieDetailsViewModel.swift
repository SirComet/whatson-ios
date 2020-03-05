//
//  MovieDetailsViewModel.swift
//  What'sOn
//
//  Created by Maxime Maheo on 27/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import XCoordinator
import RxSwift
import RxCocoa
import UIKit

enum MovieDetailsViewModelAction: ViewModelAction {
    case dismiss
    case selectRecommendedMovie(row: Int)
}

protocol MovieDetailsViewModelContract: ViewModel {
    
    // MARK: - Properties
    var movie: BehaviorRelay<Movie> { get }
    var movieDetails: BehaviorRelay<MovieDetails?> { get }
    var recommendedMovies: BehaviorRelay<[Movie]> { get }
    var genres: BehaviorRelay<[Genre]> { get }
    var error: PublishRelay<AppError> { get }

    // MARK: - Methods
    func fetchMovieDetails()
    func fetchMoviesRecommendations()
    func fetchPoster(for movie: Movie) -> Single<UIImage>
}

final class MovieDetailsViewModel: MovieDetailsViewModelContract {
    
    // MARK: - Properties
    private let router: UnownedRouter<MoviesRoute>
    private let servicesContainer: DependenciesContainer
        
    private let moviesService: MoviesServiceContract!
    private let imagesService: ImagesServiceContract!
    
    private let disposeBag = DisposeBag()
    
    var movie: BehaviorRelay<Movie>
    var movieDetails: BehaviorRelay<MovieDetails?> = .init(value: nil)
    var recommendedMovies: BehaviorRelay<[Movie]> = .init(value: [])
    var genres: BehaviorRelay<[Genre]> = .init(value: [])
    var error: PublishRelay<AppError> = .init()
    
    // MARK: - Lifecycle
    init(router: UnownedRouter<MoviesRoute>, servicesContainer: DependenciesContainer, movie: Movie) throws {
        self.router = router
        self.servicesContainer = servicesContainer
        self.movie = BehaviorRelay(value: movie)
        
        guard
            let moviesService: MoviesServiceContract = servicesContainer.resolve(),
            let imagesService: ImagesServiceContract = servicesContainer.resolve()
        else { throw ServiceError.notFound }
        
        self.moviesService = moviesService
        self.imagesService = imagesService
    }
    
    // MARK: - Methods
    func handle(action: ViewModelAction) {
        guard let action = action as? MovieDetailsViewModelAction else { return }
        
        switch action {
        case .dismiss:
            router.trigger(.dismissMovieDetails)
        case let .selectRecommendedMovie(row):
            let recommendedMovie = recommendedMovies.value[row]
            
            router.trigger(.movieDetails(movie: recommendedMovie))
        }
    }
    
    func fetchMovieDetails() {
        moviesService
            .details(id: movie.value.id)
            .subscribe(onSuccess: { [weak self] (movieDetails) in
                self?.movieDetails.accept(movieDetails)
                self?.genres.accept(movieDetails.genres)
            }, onError: { [weak self] (error) in
                self?.error.accept(AppError(error: error))
            })
            .disposed(by: disposeBag)
    }
    
    func fetchMoviesRecommendations() {
        moviesService
            .recommendations(id: movie.value.id)
            .subscribe(onSuccess: { [weak self] (recommendedMovies) in
                self?.recommendedMovies.accept(recommendedMovies)
            }, onError: { [weak self] (error) in
                self?.error.accept(AppError(error: error))
            })
            .disposed(by: disposeBag)
    }
    
    func fetchPoster(for movie: Movie) -> Single<UIImage> {
        imagesService.fetchImage(for: movie)
    }
    
}
