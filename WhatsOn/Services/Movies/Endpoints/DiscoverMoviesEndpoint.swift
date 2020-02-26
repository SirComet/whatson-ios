//
//  DiscoverMoviesEndpoint.swift
//  What'sOn
//
//  Created by Maxime Maheo on 26/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import Foundation

final class DiscoverMoviesEndpoint: ApiEndpoint {
    
    typealias RequestDataType = Void
    typealias ResponseDataType = [Movie]
    
    // MARK: - Methods
    func buildRequest(parameters: DiscoverMoviesEndpoint.RequestDataType) throws -> Request {
        let stringUrl = "https://api.themoviedb.org/3/discover/movie"
        
        guard
            let request = BaseRequest(baseStringUrl: stringUrl)
        else {
            throw RequestError.failedToRequestWithUrl(stringUrl)
        }
  
        request.addQueryParameters(parameters: [
            "sort_by": "popularity.desc",
            "region": Locale.current.regionCode?.uppercased() ?? "US"
        ])
        
        return request
    }
    
    func parseResponse(data: Data) throws -> DiscoverMoviesEndpoint.ResponseDataType {
        let response = try JSONDecoder().decode(MovieList.self, from: data)
        
        return response.results.sorted(by: { $0.voteCount > $1.voteCount })
    }
}
