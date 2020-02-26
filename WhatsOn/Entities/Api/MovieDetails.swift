//
//  MovieDetails.swift
//  What'sOn
//
//  Created by Maxime Maheo on 26/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

struct MovieDetails: Codable {
    
    let isForAdult: Bool
    let backdropPath: String?
    let budget: Int
    let genres: [Genre]
    let homepage: String?
    let id: Int
    let imdbId: Int?
    let originalLanguage: String
    let originalTitle: String
    let overview: String?
    let popularity: Double
    let posterPath: String?
    let productionCompanies: [ProductionCompany]
    let productionCountries: [ProductionCountry]
    let releaseDate: String
    let revenue: Int
    let runtime: Int?
    let spokenLanguages: [SpokenLanguage]
    let status: String
    let tagline: String?
    let title: String
    let hasVideo: Bool
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case budget, genres, homepage, id, overview, popularity, revenue, runtime, status, tagline, title
        case isForAdult = "adult"
        case backdropPath = "backdrop_path"
        case imdbId = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case spokenLanguages = "spoken_languages"
        case hasVideo = "video"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
}
