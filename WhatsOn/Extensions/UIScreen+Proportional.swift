//
//  UIScreen+Proportional.swift
//  What'sOn
//
//  Created by Maxime Maheo on 26/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import UIKit

extension UIScreen {
    
    static func height(percent: CGFloat) -> CGFloat {
        main.bounds.height * percent / 100
    }
    
    static func width(percent: CGFloat) -> CGFloat {
        main.bounds.width * percent / 100
    }
    
    static var height: CGFloat {
        main.bounds.height
    }
    
    static var width: CGFloat {
        main.bounds.width
    }
    
}
