//
//  String+FormattedDate.swift
//  What'sOn
//
//  Created by Maxime Maheo on 03/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import Foundation

extension String {
    
    func format(from fromFormat: String = "yyyy-mm-dd", to toFormat: String = "dd MMMM yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        
        guard
            let date = dateFormatter.date(from: self)
        else { return "" }
        
        dateFormatter.dateFormat = toFormat
        
        return dateFormatter.string(from: date)
    }
    
}
