//
//  CGSize+Extensions.swift
//  Utilities
//
//  Created by Caio Mello on 6/2/19.
//  Copyright © 2019 Caio Mello. All rights reserved.
//

import UIKit

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
