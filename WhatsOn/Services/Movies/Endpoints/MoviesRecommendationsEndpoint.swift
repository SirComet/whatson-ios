//
//  MoviesRecommendationsEndpoint.swift
//  What'sOn
//
//  Created by Maxime Maheo on 05/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import Foundation

final class MoviesRecommendationsEndpoint: ApiEndpoint {
    
    typealias RequestDataType = Int
    typealias ResponseDataType = [Movie]
    
    // MARK: - Methods
    func buildRequest(parameters: MoviesRecommendationsEndpoint.RequestDataType) throws -> Request {
        let stringUrl = "https://api.themoviedb.org/3/movie/\(parameters)/recommendations"
        
        guard
            let request = BaseRequest(baseStringUrl: stringUrl)
        else {
            throw RequestError.failedToRequestWithUrl(stringUrl)
        }
        
        return request
    }
    
    func parseResponse(data: Data) throws -> MoviesRecommendationsEndpoint.ResponseDataType {
        let response = try JSONDecoder().decode(MovieList.self, from: data)
        
        return response.results
    }
}
