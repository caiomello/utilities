//
//  UITraitCollection+Extensions.swift
//  Utilities
//
//  Created by Caio Mello on 7/16/19.
//  Copyright © 2019 Caio Mello. All rights reserved.
//

import UIKit

public enum SizeClass {
    case compactRegular
    case compactCompact
    case regularCompact
    case regularRegular
}

extension UITraitCollection {
    public var sizeClass: SizeClass {
        if horizontalSizeClass == .compact && verticalSizeClass == .regular {
            return .compactRegular
        } else if horizontalSizeClass == .compact && verticalSizeClass == .compact {
            return .compactCompact
        } else if horizontalSizeClass == .regular && verticalSizeClass == .compact {
            return .regularCompact
        }

        return .regularRegular
    }
}
