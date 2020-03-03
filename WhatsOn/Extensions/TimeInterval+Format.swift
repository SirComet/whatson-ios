//
//  TimeInterval+Format.swift
//  What'sOn
//
//  Created by Maxime Maheo on 03/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import Foundation

extension TimeInterval {
    
    func format(units: NSCalendar.Unit = [.hour, .minute]) -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .brief
        formatter.zeroFormattingBehavior = [.pad]
        formatter.allowedUnits = units
        
        return formatter.string(from: self) ?? "--"
    }
    
}
