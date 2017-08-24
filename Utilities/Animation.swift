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
		view.animate(animations: animations)
	}
	
	public func animate(withDuration duration: TimeInterval, animations: @escaping () -> Void) {
		view.animate(withDuration: duration, animations: animations)
	}
}

extension UIView {
	public func animate(animations: @escaping () -> Void) {
		animate(withDuration: 0.3, animations: animations)
	}
	
	public func animate(withDuration duration: TimeInterval, animations: @escaping () -> Void) {
		UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
			animations()
		}.startAnimation()
	}
}
