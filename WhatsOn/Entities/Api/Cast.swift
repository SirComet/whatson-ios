//
//  Cast.swift
//  What'sOn
//
//  Created by Maxime Maheo on 05/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

struct Cast: Codable {
    
    let castId: Int
    let character: String
    let creditId: String
    let gender: Int?
    let id: Int
    let name: String
    let order: Int
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case character, gender, id, name, order
        case castId = "cast_id"
        case creditId = "credit_id"
        case profilePath = "profile_path"
    }
    
}
