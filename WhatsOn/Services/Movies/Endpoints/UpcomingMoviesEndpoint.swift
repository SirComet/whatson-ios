//
//  UpcomingMoviesEndpoint.swift
//  What'sOn
//
//  Created by Maxime Maheo on 27/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import Foundation

final class UpcomingMoviesEndpoint: ApiEndpoint {
    
    typealias RequestDataType = Void
    typealias ResponseDataType = [Movie]
    
    // MARK: - Methods
    func buildRequest(parameters: UpcomingMoviesEndpoint.RequestDataType) throws -> Request {
        let stringUrl = "https://api.themoviedb.org/3/movie/upcoming"
        
        guard
            let request = BaseRequest(baseStringUrl: stringUrl)
        else {
            throw RequestError.failedToRequestWithUrl(stringUrl)
        }
  
        request.addQueryParameters(parameters: [
            "region": Locale.current.regionCode?.uppercased() ?? "US"
        ])
        
        return request
    }
    
    func parseResponse(data: Data) throws -> UpcomingMoviesEndpoint.ResponseDataType {
        let response = try JSONDecoder().decode(MovieList.self, from: data)
        
        return response.results
    }
}
