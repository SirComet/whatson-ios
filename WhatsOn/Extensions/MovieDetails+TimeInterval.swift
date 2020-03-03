//
//  MovieDetails+TimeInterval.swift
//  What'sOn
//
//  Created by Maxime Maheo on 03/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import Foundation

extension MovieDetails {
    
    var duration: TimeInterval {
        guard let runtime = runtime else { return .zero }
        
        return TimeInterval(runtime * 60)
    }
    
}
