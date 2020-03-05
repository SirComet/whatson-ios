//
//  MovieCreditsEndpoint.swift
//  What'sOn
//
//  Created by Maxime Maheo on 05/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import Foundation

final class MovieCreditsEndpoint: ApiEndpoint {
    
    typealias RequestDataType = Int
    typealias ResponseDataType = MovieCredits
    
    // MARK: - Methods
    func buildRequest(parameters: MovieCreditsEndpoint.RequestDataType) throws -> Request {
        let stringUrl = "https://api.themoviedb.org/3/movie/\(parameters)/credits"
        
        guard
            let request = BaseRequest(baseStringUrl: stringUrl)
        else {
            throw RequestError.failedToRequestWithUrl(stringUrl)
        }
        
        return request
    }
    
    func parseResponse(data: Data) throws -> MovieCreditsEndpoint.ResponseDataType {
        try JSONDecoder().decode(MovieCredits.self, from: data)
    }
}
