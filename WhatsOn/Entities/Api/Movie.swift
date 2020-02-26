//
//  Movie.swift
//  What'sOn
//
//  Created by Maxime Maheo on 26/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

struct MovieList: Decodable {
    let page: Int
    let results: [Movie]
    let totalResults: Int
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}

struct Movie: Codable {
    
    let posterPath: String?
    let isForAdult: Bool
    let overview: String
    let releaseDate: String?
    let genreIds: [Int]
    let id: Int
    let originalTitle: String
    let originalLanguage: String
    let title: String
    let backdropPath: String?
    let popularity: Double
    let voteCount: Int
    let hasVideo: Bool
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case overview, id, title, popularity
        case posterPath = "poster_path"
        case isForAdult = "adult"
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case backdropPath = "backdrop_path"
        case voteCount = "vote_count"
        case hasVideo = "video"
        case voteAverage = "vote_average"
        
    }
    
}
