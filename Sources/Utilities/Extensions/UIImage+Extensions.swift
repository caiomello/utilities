//
//  UIImage+Extensions.swift
//  Utilities
//
//  Created by Caio Mello on 6/2/19.
//  Copyright © 2019 Caio Mello. All rights reserved.
//

import UIKit

extension UIImage {
    public convenience init(color: UIColor) {
        let rect = CGRect(x: 0, y: 0, width: 4, height: 5)

        UIGraphicsBeginImageContext(rect.size)

        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()!

        UIGraphicsEndImageContext()

        self.init(cgImage: image.cgImage!)
    }
}
