//
//  Movie+FetchableImage.swift
//  What'sOn
//
//  Created by Maxime Maheo on 26/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

extension Movie: FetchableImage {

    func imageStringUrl(from host: String) -> String? {
        guard let posterPath = posterPath else { return nil }
        
        return "\(host)/w500\(posterPath)"
    }
        
}
