//
//  TraitCollection.swift
//  Utilities
//
//  Created by Caio Mello on August 17, 2017.
//  Copyright © 2017 Caio Mello. All rights reserved.
//

import UIKit

public enum SizeClass {
	case compactRegular
	case compactCompact
	case regularCompact
	case regularRegular
}

extension UITraitCollection {
	public func sizeClass() -> SizeClass {
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
