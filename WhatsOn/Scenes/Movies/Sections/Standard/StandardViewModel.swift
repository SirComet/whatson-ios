//
//  StandardViewModel.swift
//  What'sOn
//
//  Created by Maxime Maheo on 27/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import XCoordinator
import RxSwift
import RxCocoa
import UIKit

protocol StandardViewModelContract {
    
    // MARK: - Properties
    var sectionContentType: SectionContentType { get }
    var movies: BehaviorRelay<[Movie]> { get }
    var error: PublishRelay<AppError> { get }
    var isLoading: BehaviorRelay<Bool> { get }

    // MARK: - Methods
    func fetchPopularMovies()
    func fetchDiscoverMovies()
    func fetchTopRatedMovies()
    func fetchNowPlayingMovies()
    func fetchUpcomingMovies()
    
    func fetchPoster(for movie: Movie) -> Single<UIImage>
    
}

final class StandardViewModel: StandardViewModelContract {
    
    // MARK: - Properties
    private let router: UnownedRouter<MoviesRoute>
    private let servicesContainer: DependenciesContainer
    
    private let moviesService: MoviesServiceContract!
    private let imagesService: ImagesServiceContract!
    
    private let disposeBag = DisposeBag()
    
    var sectionContentType: SectionContentType
    var movies: BehaviorRelay<[Movie]> = .init(value: [])
    var error: PublishRelay<AppError> = .init()
    var isLoading: BehaviorRelay<Bool> = .init(value: false)
    
    // MARK: - Lifecycle
    init(router: UnownedRouter<MoviesRoute>, servicesContainer: DependenciesContainer, sectionContentType: SectionContentType) throws {
        self.router = router
        self.servicesContainer = servicesContainer
        self.sectionContentType = sectionContentType
        
        guard
            let moviesService: MoviesServiceContract = servicesContainer.resolve(),
            let imagesService: ImagesServiceContract = servicesContainer.resolve()
        else { throw ServiceError.notFound }
        
        self.moviesService = moviesService
        self.imagesService = imagesService
    }
    
    func fetchPopularMovies() {
        isLoading.accept(true)
        
        handle(single: moviesService.popular())
    }
    
    func fetchDiscoverMovies() {
        isLoading.accept(true)
        
        handle(single: moviesService.discover())
    }
    
    func fetchTopRatedMovies() {
        isLoading.accept(true)
        
        handle(single: moviesService.topRated())
    }
    
    func fetchNowPlayingMovies() {
        isLoading.accept(true)
        
        handle(single: moviesService.nowPlaying())
    }
    
    func fetchUpcomingMovies() {
        isLoading.accept(true)
        
        handle(single: moviesService.upcoming())
    }
    
    func fetchPoster(for movie: Movie) -> Single<UIImage> {
        imagesService.fetchImage(for: movie)
    }

    // MARK: - Private methods
    private func handle(single: Single<[Movie]>) {
        single
            .subscribe(onSuccess: { [weak self] (movies) in
                self?.isLoading.accept(false)
                
                self?.movies.accept(movies)
            }, onError: { [weak self] (error) in
                self?.isLoading.accept(false)
                
                self?.error.accept(AppError(error: error))
            })
            .disposed(by: disposeBag)
    }
}
