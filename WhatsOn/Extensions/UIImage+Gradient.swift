//
//  UIImage+Gradient.swift
//  What'sOn
//
//  Created by Maxime Maheo on 03/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import UIKit

extension UIImage {
    
    static func withGradient(colors: [UIColor],
                             size: CGSize,
                             start: CGPoint? = nil,
                             end: CGPoint? = nil) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        let cgColors: [CGColor] = colors.map { $0.cgColor }
        
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                        colors: cgColors as CFArray,
                                        locations: nil) else {
            return nil
        }
        
        let startPoint: CGPoint
        let endPoint: CGPoint
        
        if let start = start, let end = end {
            startPoint = start
            endPoint = end
        } else {
            startPoint = CGPoint(x: size.width / 2, y: 0)
            endPoint = CGPoint(x: size.width / 2, y: size.height)
        }

        context.drawLinearGradient(gradient,
                                   start: startPoint,
                                   end: endPoint,
                                   options: [])
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image
    }
    
}
