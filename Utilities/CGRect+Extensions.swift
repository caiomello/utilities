//
//  CGRect+Extensions.swift
//  Utilities
//
//  Created by Caio Mello on 6/2/19.
//  Copyright © 2019 Caio Mello. All rights reserved.
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
