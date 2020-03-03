//
//  UIImage+Blur.swift
//  What'sOn
//
//  Created by Maxime Maheo on 03/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import UIKit

extension UIImage {
    
    func blur(radius: CGFloat) -> UIImage? {
        let context = CIContext(options: nil)
        let inputImage = CIImage(image: self)

        let filter = CIFilter(name: "CIGaussianBlur")
        filter?.setValue(inputImage, forKey: kCIInputImageKey)
        filter?.setValue(radius, forKey: kCIInputRadiusKey)
        
        guard
            let inputRect = inputImage?.extent,
            let outputImage = filter?.outputImage,
            let cgImage = context.createCGImage(outputImage, from: inputRect)
        else { return nil }

        return UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
    }
    
}
