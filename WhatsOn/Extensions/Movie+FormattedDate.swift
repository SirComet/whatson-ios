//
//  Movie+FormattedDate.swift
//  What'sOn
//
//  Created by Maxime Maheo on 03/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import Foundation

extension Movie {
    var formattedReleaseDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
    
        guard
            let releaseDate = releaseDate,
            let date = dateFormatter.date(from: releaseDate)
        else { return "" }
        
        dateFormatter.dateFormat = "dd MMMM yyyy"
        
        return dateFormatter.string(from: date)
    }
}
