//
//  Apply.swift
//  What'sOn
//
//  Created by Maxime Maheo on 24/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import Foundation

public protocol Apply { }

extension Apply where Self: AnyObject {

    /// Makes it available to set properties with closures just after initializing.
    ///
    ///     let label = UILabel().apply {
    ///       $0.text = "Hello, World!"
    ///     }
    public func apply(_ block: (Self) throws -> Void) rethrows -> Self {
        try block(self)
        
        return self
    }
    
}

extension NSObject: Apply {}
