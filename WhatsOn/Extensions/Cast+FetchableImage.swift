//
//  Cast+FetchableImage.swift
//  What'sOn
//
//  Created by Maxime Maheo on 05/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

extension Cast: FetchableImage {

    func imageStringUrl(from host: String) -> String? {
        guard let profilePath = profilePath else { return nil }
        
        return "\(host)/w500\(profilePath)"
    }
        
}
