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
    
    func discover(genreIds: [Int]?) -> Single<[Movie]> {
        apiRequester.fetch(DiscoverMoviesEndpoint(), with: (genreIds))
    }
    
    func topRated() -> Single<[Movie]> {
        apiRequester.fetch(TopRatedMoviesEndpoint(), with: ())
    }
    
    func nowPlaying() -> Single<[Movie]> {
        apiRequester.fetch(NowPlayingMoviesEndpoint(), with: ())
    }
    
    func upcoming() -> Single<[Movie]> {
        apiRequester.fetch(UpcomingMoviesEndpoint(), with: ())
    }
    
    func trendingWeek() -> Single<[Movie]> {
        apiRequester.fetch(TrendingWeekMoviesEndpoint(), with: ())
    }
    
    func genres() -> Single<[Genre]> {
        apiRequester.fetch(MoviesGenresEndpoint(), with: ())
    }
    
    func details(id: Int) -> Single<MovieDetails> {
        apiRequester.fetch(MovieDetailsEndpoint(), with: id)
    }
    
    func recommendations(id: Int) -> Single<[Movie]> {
        apiRequester.fetch(MoviesRecommendationsEndpoint(), with: id)
    }
    
}
