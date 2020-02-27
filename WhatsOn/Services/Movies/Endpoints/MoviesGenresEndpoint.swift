//
//  MoviesGenresEndpoint.swift
//  What'sOn
//
//  Created by Maxime Maheo on 27/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import Foundation

final class MoviesGenresEndpoint: ApiEndpoint {
    
    typealias RequestDataType = Void
    typealias ResponseDataType = [Genre]
    
    // MARK: - Methods
    func buildRequest(parameters: MoviesGenresEndpoint.RequestDataType) throws -> Request {
        let stringUrl = "https://api.themoviedb.org/3/genre/movie/list"
        
        guard
            let request = BaseRequest(baseStringUrl: stringUrl)
        else {
            throw RequestError.failedToRequestWithUrl(stringUrl)
        }
        
        return request
    }
    
    func parseResponse(data: Data) throws -> MoviesGenresEndpoint.ResponseDataType {
        let response = try JSONDecoder().decode(GenreList.self, from: data)
        
        return response.genres
    }
}
