//
//  MovieVideosEndpoint.swift
//  What'sOn
//
//  Created by Maxime Maheo on 05/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import Foundation

final class MovieVideosEndpoint: ApiEndpoint {
    
    typealias RequestDataType = Int
    typealias ResponseDataType = [MovieVideo]
    
    // MARK: - Methods
    func buildRequest(parameters: MovieVideosEndpoint.RequestDataType) throws -> Request {
        let stringUrl = "https://api.themoviedb.org/3/movie/\(parameters)/videos"
        
        guard
            let request = BaseRequest(baseStringUrl: stringUrl)
        else {
            throw RequestError.failedToRequestWithUrl(stringUrl)
        }
        
        return request
    }
    
    func parseResponse(data: Data) throws -> MovieVideosEndpoint.ResponseDataType {
        let response = try JSONDecoder().decode(MovieVideoList.self, from: data)
        
        return response.results
    }
}
