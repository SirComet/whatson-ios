//
//  MovieVideo.swift
//  What'sOn
//
//  Created by Maxime Maheo on 05/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

struct MovieVideoList: Decodable {
    let id: Int
    let results: [MovieVideo]
}

struct MovieVideo: Codable {
    
    let id: String
    let iso6391: String
    let iso31661: String
    let key: String
    let name: String
    let site: String
    let size: Int
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case id, key, name, site, size, type
        case iso6391 = "iso_639_1"
        case iso31661 = "iso_3166_1"
    }
    
}
