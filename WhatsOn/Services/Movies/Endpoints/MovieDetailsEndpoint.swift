//
//  MovieDetailsEndpoint.swift
//  What'sOn
//
//  Created by Maxime Maheo on 03/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import Foundation

final class MovieDetailsEndpoint: ApiEndpoint {
    
    typealias RequestDataType = Int
    typealias ResponseDataType = MovieDetails
    
    // MARK: - Methods
    func buildRequest(parameters: MovieDetailsEndpoint.RequestDataType) throws -> Request {
        let stringUrl = "https://api.themoviedb.org/3/movie/\(parameters)"
        
        guard
            let request = BaseRequest(baseStringUrl: stringUrl)
        else {
            throw RequestError.failedToRequestWithUrl(stringUrl)
        }
        
        return request
    }
    
    func parseResponse(data: Data) throws -> MovieDetailsEndpoint.ResponseDataType {
        try JSONDecoder().decode(MovieDetails.self, from: data)
    }
}
