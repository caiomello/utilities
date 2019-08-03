//
//  UIStackView+Extensions.swift
//  Utilities
//
//  Created by Caio Mello on 8/3/19.
//  Copyright © 2019 Caio Mello. All rights reserved.
//

import UIKit

extension UIStackView {
    public func removeArrangedSubviews() {
        removeArrangedSubviews(arrangedSubviews)
    }

    public func removeArrangedSubviews(_ subviews: [UIView]) {
        for subview in subviews {
            removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
    }
}
