//
//  UIView+Extensions.swift
//  Utilities
//
//  Created by Caio Mello on 6/2/19.
//  Copyright © 2019 Caio Mello. All rights reserved.
//

import UIKit

// MARK: - Instantiation

extension UIView {
    public class func fromNib<T: UIView>() -> T {
        let nib = UINib(nibName: String(describing: T.self), bundle: nil)
        return nib.instantiate(withOwner: nil, options: nil).first as! T
    }
}

// MARK: - Animation

extension UIView {
    public func animate(_ animations: @escaping () -> Void, completion: @escaping () -> Void = {}) {
        animate(withDuration: 0.3, animations: animations, completion: completion)
    }

    public func animate(withDuration duration: TimeInterval,
                        after: TimeInterval = 0,
                        animations: @escaping () -> Void,
                        completion: @escaping () -> Void = {}) {

        let animator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1, animations: animations)
        animator.addCompletion { _ in completion() }
        animator.startAnimation(afterDelay: after)
    }
}

// MARK: - Shadow

extension UIView {
    public func addTopShadow() {
        addShadow(path: UIBezierPath(rect: CGRect(width: bounds.width, height: 10)),
                  opacity: 0.2,
                  radius: 8)
    }

    public func addDropShadow(withCornerRadius cornerRadius: CGFloat) {
        addShadow(path: UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius),
                  offset: .zero,
                  opacity: 0.15,
                  radius: 6)
    }

    private func addShadow(path: UIBezierPath,
                           offset: CGSize? = nil,
                           opacity: Float,
                           radius: CGFloat) {

        clipsToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowPath = path.cgPath

        if let offset = offset {
            layer.shadowOffset = offset
        }

        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}

// MARK: - Auto Layout

extension UIView {
    public func addWidthConstraint(_ value: CGFloat) {
        addConstraint(NSLayoutConstraint(item: self,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1,
                                         constant: value))
    }

    public func addHeightConstraint(_ value: CGFloat) {
        addConstraint(NSLayoutConstraint(item: self,
                                         attribute: .height,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1,
                                         constant: value))
    }

    public func fitVerticalEdgesToSuperview(obeyMargins: Bool = false) {
        superview?.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: obeyMargins ? "V:|-[view]-|" : "V:|[view]|",
                options: [],
                metrics: nil,
                views: ["view": self]
            )
        )
    }

    public func fitHorizontalEdgesToSuperview(obeyMargins: Bool = false) {
        superview?.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: obeyMargins ? "H:|-[view]-|" : "H:|[view]|",
                options: [],
                metrics: nil,
                views: ["view": self]
            )
        )
    }

    public func fitToSuperview(obeyMargins: Bool = false) {
        fitVerticalEdgesToSuperview(obeyMargins: obeyMargins)
        fitHorizontalEdgesToSuperview(obeyMargins: obeyMargins)
    }

    public func centerHorizontallyInSuperview() {
        superview?.addConstraint(
            NSLayoutConstraint(
                item: self,
                attribute: .centerX,
                relatedBy: .equal,
                toItem: superview,
                attribute: .centerX,
                multiplier: 1,
                constant: 0
            )
        )
    }

    public func centerVerticallyInSuperview() {
        superview?.addConstraint(
            NSLayoutConstraint(
                item: self,
                attribute: .centerY,
                relatedBy: .equal,
                toItem: superview,
                attribute: .centerY,
                multiplier: 1,
                constant: 0
            )
        )
    }

    public func centerInSuperview() {
        centerHorizontallyInSuperview()
        centerVerticallyInSuperview()
    }
}
