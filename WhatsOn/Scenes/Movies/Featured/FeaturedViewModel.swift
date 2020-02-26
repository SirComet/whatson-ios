//
//  FeaturedViewModel.swift
//  What'sOn
//
//  Created by Maxime Maheo on 25/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import XCoordinator
import RxSwift
import RxCocoa

protocol FeaturedViewModelContract {
    
    // MARK: - Properties
    var sectionContentType: SectionContentType { get }
    var popularMovies: BehaviorRelay<[Movie]> { get }
    var error: PublishRelay<AppError> { get }
    var isLoading: BehaviorRelay<Bool> { get }

    // MARK: - Methods
    func fetchPopularMovies()
}

final class FeaturedViewModel: FeaturedViewModelContract {
    
    // MARK: - Properties
    private let router: UnownedRouter<MoviesRoute>
    private let servicesContainer: DependenciesContainer
    
    private let moviesService: MoviesServiceContract?
    
    private let disposeBag = DisposeBag()
    
    var sectionContentType: SectionContentType
    var popularMovies: BehaviorRelay<[Movie]> = .init(value: [])
    var error: PublishRelay<AppError> = .init()
    var isLoading: BehaviorRelay<Bool> = .init(value: false)
    
    // MARK: - Lifecycle
    init(router: UnownedRouter<MoviesRoute>, servicesContainer: DependenciesContainer, sectionContentType: SectionContentType) {
        self.router = router
        self.servicesContainer = servicesContainer
        self.sectionContentType = sectionContentType
        
        moviesService = servicesContainer.resolve()
    }
    
    func fetchPopularMovies() {
        isLoading.accept(true)
        
        moviesService?
            .popular()
            .subscribe(onSuccess: { [weak self] (movies) in
                self?.isLoading.accept(false)
                
                self?.popularMovies.accept(movies)
            }, onError: { [weak self] (error) in
                self?.isLoading.accept(false)
                
                self?.error.accept(AppError(error: error))
            })
            .disposed(by: disposeBag)
    }

}
