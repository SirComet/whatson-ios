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

enum GenreViewModelAction: ViewModelAction {
    case selectGenre(row: Int)
}

protocol GenreViewModelContract: ViewModel {
    
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
    
    // MARK: - Methods
    func handle(action: ViewModelAction) {
        guard let action = action as? GenreViewModelAction else { return }
        
        switch action {
        case let .selectGenre(row):
            select(row: row)
        }
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
    
    // MARK: - Private methods
    private func select(row: Int) {
        let genre = genres.value[row]
        
        isLoading.accept(true)
        
        moviesService
            .discover(genreIds: [genre.id])
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] (movies) in
                self?.isLoading.accept(false)
                
                self?.router.trigger(.moviesList(title: "\(genre.smiley) \(genre.name)", movies: movies))
            }, onError: { [weak self] (error) in
                self?.isLoading.accept(false)
                
                self?.error.accept(AppError(error: error))
            })
            .disposed(by: disposeBag)
    }
    
}
