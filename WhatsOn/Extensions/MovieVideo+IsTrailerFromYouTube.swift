//
//  MovieVideo+IsTrailerFromYouTube.swift
//  What'sOn
//
//  Created by Maxime Maheo on 05/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

extension MovieVideo {
    
    var isTrailerFromYouTube: Bool {
        site == "YouTube" && type == "Trailer"
    }
    
}
