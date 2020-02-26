//
//  SpokenLanguage.swift
//  What'sOn
//
//  Created by Maxime Maheo on 26/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

struct SpokenLanguage: Codable {
    
    let iso6391: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case iso6391 = "iso_639_1"
    }
    
}
