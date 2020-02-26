//
//  ProductionCompany.swift
//  What'sOn
//
//  Created by Maxime Maheo on 26/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

struct ProductionCompany: Codable {
    
    let name: String
    let id: Int
    let logoPath: String?
    let originCountry: String
    
    enum CodingKeys: String, CodingKey {
        case name, id
        case logoPath = "logo_path"
        case originCountry = "origin_country"
    }
    
}
