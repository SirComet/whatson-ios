//
//  Int+CurrencyFormat.swift
//  What'sOn
//
//  Created by Maxime Maheo on 05/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import Foundation

extension Int {
    
    func format(style: NumberFormatter.Style) -> String? {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = style
        formatter.locale = Locale.current
        
        return formatter.string(from: NSNumber(value: self))
    }
    
}
