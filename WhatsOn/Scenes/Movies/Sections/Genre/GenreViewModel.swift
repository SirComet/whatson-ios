//
//  GenreViewModel.swift
//  What'sOn
//
//  Created by Maxime Maheo on 27/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import XCoordinator
import RxSwift
import RxCocoa
import UIKit

protocol GenreViewModelContract {
    
    // MARK: - Properties
    var sectionContentType: SectionContentType { get }
    var genres: BehaviorRelay<[Genre]> { get }
    var error: PublishRelay<AppError> { get }
    var isLoading: BehaviorRelay<Bool> { get }

    // MARK: - Methods
    func fetchMoviesGenres()
    
}

final class GenreViewModel: GenreViewModelContract {
    
    // MARK: - Properties
    private let router: UnownedRouter<MoviesRoute>
    private let servicesContainer: DependenciesContainer
    
    private let moviesService: MoviesServiceContract!
    
    private let disposeBag = DisposeBag()
    
    var sectionContentType: SectionContentType
    var genres: BehaviorRelay<[Genre]> = .init(value: [])
    var error: PublishRelay<AppError> = .init()
    var isLoading: BehaviorRelay<Bool> = .init(value: false)
    
    // MARK: - Lifecycle
    init(router: UnownedRouter<MoviesRoute>, servicesContainer: DependenciesContainer, sectionContentType: SectionContentType) throws {
        self.router = router
        self.servicesContainer = servicesContainer
        self.sectionContentType = sectionContentType
        
        guard
            let moviesService: MoviesServiceContract = servicesContainer.resolve()
        else { throw ServiceError.notFound }
        
        self.moviesService = moviesService
    }
    
    func fetchMoviesGenres() {
        isLoading.accept(true)
        
        moviesService
            .genres()
            .subscribe(onSuccess: { [weak self] (genres) in
                self?.isLoading.accept(false)
                
                self?.genres.accept(genres)
            }, onError: { [weak self] (error) in
                self?.isLoading.accept(false)
                
                self?.error.accept(AppError(error: error))
            })
            .disposed(by: disposeBag)
    }
    
}
