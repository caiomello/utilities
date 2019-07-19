//
//  UIScrollView+Extensions.swift
//  Utilities
//
//  Created by Caio Mello on 7/19/19.
//  Copyright © 2019 Caio Mello. All rights reserved.
//

import UIKit

extension UIScrollView {
    public func scrollToTop(animated: Bool = false) {
        setContentOffset(CGPoint(x: 0, y: -adjustedContentInset.top), animated: animated)
    }
}
