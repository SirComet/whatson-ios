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
    func discover() -> Single<[Movie]>
    func topRated() -> Single<[Movie]>
    
}
