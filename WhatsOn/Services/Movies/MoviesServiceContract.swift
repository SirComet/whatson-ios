//
//  MoviesServiceContract.swift
//  What'sOn
//
//  Created by Maxime Maheo on 26/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import RxSwift

protocol MoviesServiceContract: Service {

    func popular() -> Single<[Movie]>
    func discover(genreIds: [Int]?) -> Single<[Movie]>
    func topRated() -> Single<[Movie]>
    func nowPlaying() -> Single<[Movie]>
    func upcoming() -> Single<[Movie]>
    func trendingWeek() -> Single<[Movie]>
    func genres() -> Single<[Genre]>
    func details(id: Int) -> Single<MovieDetails>
    func recommendations(id: Int) -> Single<[Movie]>
    func videos(id: Int) -> Single<[MovieVideo]>
    func credits(id: Int) -> Single<MovieCredits>
}
