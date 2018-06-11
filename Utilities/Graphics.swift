//
//  Graphics.swift
//  Utilities
//
//  Created by Caio Mello on August 17, 2017.
//  Copyright © 2017 Caio Mello. All rights reserved.
//

import UIKit

extension CGRect {
	public init(size: CGSize) {
        self.init()
        self.origin = CGPoint(x: 0, y: 0)
		self.size = size
	}
	
	public init(width: CGFloat, height: CGFloat) {
		self.init(size: CGSize(width: width, height: height))
	}
}

extension CGSize {
	public init(size: CGSize, aspectFitToWidth width: CGFloat) {
        self.init()
        
		let scaleFactor = width/size.width
        self.width = size.width * scaleFactor
		self.height = size.height * scaleFactor
	}
	
	public init(size: CGSize, aspectFitToHeight height: CGFloat) {
        self.init()
        
		let scaleFactor = height/size.height
        self.width = size.width * scaleFactor
		self.height = size.height * scaleFactor
	}
}
