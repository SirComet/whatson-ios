//
//  MovieCredits.swift
//  What'sOn
//
//  Created by Maxime Maheo on 05/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

struct MovieCredits: Codable {
    
    let id: Int
    let cast: [Cast]
    let crew: [Crew]
    
}
