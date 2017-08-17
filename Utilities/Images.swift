//
//  Images.swift
//  Utilities
//
//  Created by Caio Mello on August 17, 2017.
//  Copyright © 2017 Caio Mello. All rights reserved.
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

extension UIImageView {
	public func boundsOfImage() -> CGRect {
		if let image = self.image {
			let widthFactor = image.size.width/self.bounds.size.width
			let heightFactor = image.size.height/self.bounds.size.height
			
			let factor = fmax(widthFactor, heightFactor)
			
			let width = image.size.width/factor
			let height = image.size.height/factor
			
			let x = (self.bounds.size.width - width)/2
			let y = (self.bounds.size.height - height)/2
			
			return CGRect(x: x, y: y, width: width, height: height)
		}
		
		return CGRect.zero
	}
	
	public func addShadow() {
		clipsToBounds = false
		layer.shadowPath = UIBezierPath(rect: boundsOfImage()).cgPath
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOpacity = 1
		layer.shadowRadius = 10
		layer.shadowOffset = CGSize(width: 0, height: 5)
	}
}
