//
//  Crew.swift
//  What'sOn
//
//  Created by Maxime Maheo on 05/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

struct Crew: Codable {
    
    let creditId: String
    let department: String
    let gender: Int?
    let id: Int
    let job: String
    let name: String
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case department, gender, id, job, name
        case creditId = "credit_id"
        case profilePath = "profile_path"
    }
    
}
