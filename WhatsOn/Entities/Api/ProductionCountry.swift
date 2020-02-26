//
//  ProductionCountry.swift
//  What'sOn
//
//  Created by Maxime Maheo on 26/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

struct ProductionCountry: Codable {
    
    let iso31661: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case name
        case iso31661 = "iso_3166_1"
    }
    
}
