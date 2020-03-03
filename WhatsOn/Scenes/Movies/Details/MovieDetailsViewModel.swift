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
}

protocol MovieDetailsViewModelContract: ViewModel {
    
    // MARK: - Properties
    var movie: BehaviorRelay<Movie> { get }
    
    // MARK: - Methods
    func fetchPosterImage() -> Single<UIImage>
}

final class MovieDetailsViewModel: MovieDetailsViewModelContract {
    
    // MARK: - Properties
    private let router: UnownedRouter<MoviesRoute>
    private let servicesContainer: DependenciesContainer
        
    private let imagesService: ImagesServiceContract!
    
    private let disposeBag = DisposeBag()
    
    var movie: BehaviorRelay<Movie>
    
    // MARK: - Lifecycle
    init(router: UnownedRouter<MoviesRoute>, servicesContainer: DependenciesContainer, movie: Movie) throws {
        self.router = router
        self.servicesContainer = servicesContainer
        self.movie = BehaviorRelay(value: movie)
        
        guard let imagesService: ImagesServiceContract = servicesContainer.resolve() else { throw ServiceError.notFound }
        
        self.imagesService = imagesService
    }
    
    // MARK: - Methods
    func handle(action: ViewModelAction) {
        guard let action = action as? MovieDetailsViewModelAction else { return }
        
        switch action {
        case .dismiss:
            router.trigger(.dismissMovieDetails)
        }
    }
    
    func fetchPosterImage() -> Single<UIImage> {
        imagesService.fetchImage(for: movie.value)
    }
    
}
