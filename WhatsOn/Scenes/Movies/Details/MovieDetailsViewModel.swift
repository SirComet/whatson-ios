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
    var videos: BehaviorRelay<[MovieVideo]> { get }
    var genres: BehaviorRelay<[Genre]> { get }
    var casts: BehaviorRelay<[Cast]> { get }
    var error: PublishRelay<AppError> { get }

    // MARK: - Methods
    func fetchMovieDetails()
    func fetchMoviesRecommendations()
    func fetchMovieVideos()
    func fetchMovieCredits()
    
    func fetchImage<T>(for object: T) -> Single<UIImage> where T: FetchableImage
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
    var videos: BehaviorRelay<[MovieVideo]> = .init(value: [])
    var genres: BehaviorRelay<[Genre]> = .init(value: [])
    var casts: BehaviorRelay<[Cast]> = .init(value: [])
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
    
    func fetchMovieVideos() {
        moviesService
            .videos(id: movie.value.id)
            .subscribe(onSuccess: { [weak self] (videos) in
                self?.videos.accept(videos)
            }, onError: { [weak self] (error) in
                self?.error.accept(AppError(error: error))
            })
            .disposed(by: disposeBag)
    }
    
    func fetchMovieCredits() {
        moviesService
            .credits(id: movie.value.id)
            .subscribe(onSuccess: { [weak self] (credits) in
                self?.casts.accept(credits.cast)
            }, onError: { [weak self] (error) in
                self?.error.accept(AppError(error: error))
            })
            .disposed(by: disposeBag)
    }
    
    func fetchImage<T>(for object: T) -> Single<UIImage> where T: FetchableImage {
        imagesService.fetchImage(for: object)
    }
    
}
