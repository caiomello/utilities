//
//  Animation.swift
//  Utilities
//
//  Created by Caio Mello on August 17, 2017.
//  Copyright © 2017 Caio Mello. All rights reserved.
//

import UIKit

extension UIViewController {
	public func animate(animations: @escaping () -> Void) {
		view.animate {
			animations()
		}
	}
}

extension UIView {
	public func animate(animations: @escaping () -> Void) {
		UIViewPropertyAnimator(duration: 0.3, dampingRatio: 1) {
			animations()
		}.startAnimation()
	}
}
