//
//  MoviesService.swift
//  What'sOn
//
//  Created by Maxime Maheo on 26/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import RxSwift

final class MoviesService: MoviesServiceContract {
    
    // MARK: - Properties
    private let apiRequester = ApiRequester()
    
    // MARK: - Lifecycle
    init(parameters: Any?) throws {
        
    }
    
    // MARK: - Methods
    func popular() -> Single<[Movie]> {
        apiRequester.fetch(PopularMoviesEndpoint(), with: ())
    }
    
}
