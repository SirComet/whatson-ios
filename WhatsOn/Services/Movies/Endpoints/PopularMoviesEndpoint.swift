//
//  PopularMoviesEndpoint.swift
//  What'sOn
//
//  Created by Maxime Maheo on 26/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import Foundation

final class PopularMoviesEndpoint: ApiEndpoint {
    
    typealias RequestDataType = Void
    typealias ResponseDataType = [Movie]
    
    // MARK: - Methods
    func buildRequest(parameters: PopularMoviesEndpoint.RequestDataType) throws -> Request {
        let stringUrl = "https://api.themoviedb.org/3/movie/popular"
        
        guard
            let request = BaseRequest(baseStringUrl: stringUrl)
        else {
            throw RequestError.failedToRequestWithUrl(stringUrl)
        }
        
        return request
    }
    
    func parseResponse(data: Data) throws -> PopularMoviesEndpoint.ResponseDataType {
        let response = try JSONDecoder().decode(MovieList.self, from: data)
        
        return response.results
    }
}
