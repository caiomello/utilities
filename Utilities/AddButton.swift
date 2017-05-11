//
//  AddButton.swift
//  Utilities
//
//  Created by Caio Mello on 7/12/15.
//  Copyright © 2015 Caio Mello. All rights reserved.
//

import UIKit

// TODO: Refactor

@IBDesignable class AddButton: UIControl {
	var titleLabel: UILabel = UILabel()
	
	@IBInspectable var borderWidth: Float = 1 {
		didSet {
			layer.borderWidth = CGFloat(borderWidth)
		}
	}
	
	@IBInspectable var cornerRadius: Float = 4 {
		didSet {
			layer.cornerRadius = CGFloat(cornerRadius)
		}
	}
	
	@IBInspectable var color: UIColor = UIColor.black {
		didSet {
			titleLabel.textColor = color
			layer.borderColor = color.cgColor
		}
	}
	
	@IBInspectable var title: String = "Add" {
		didSet {
			titleLabel.text = title
		}
	}
	
	@IBInspectable var titleSize: Float = 15 {
		didSet {
			titleLabel.font = UIFont.systemFont(ofSize: CGFloat(titleSize), weight: UIFontWeightMedium)
		}
	}
	
	override var isEnabled: Bool {
		didSet {
			refreshState()
		}
	}
	
	override var isHighlighted: Bool {
		didSet {
			refreshState()
		}
	}
	
	override var isSelected: Bool {
		didSet {
			refreshState()
		}
	}
	
	fileprivate func refreshState() {
		if isEnabled {
			if isSelected {
				titleLabel.textColor = superview?.backgroundColor
				backgroundColor = color
				layer.borderColor = color.cgColor
			} else {
				if isHighlighted {
					titleLabel.textColor = superview?.backgroundColor
					backgroundColor = color
					layer.borderColor = color.cgColor
				} else {
					titleLabel.textColor = color
					backgroundColor = superview?.backgroundColor
					layer.borderColor = color.cgColor
				}
			}
		} else {
			let disabledColor = UIColor(red: 140/255, green: 140/255, blue: 140/255, alpha: 1)
			
			if isSelected {
				titleLabel.textColor = superview?.backgroundColor
				backgroundColor = disabledColor
				layer.borderColor = disabledColor.cgColor
			} else {
				titleLabel.textColor = disabledColor
				backgroundColor = superview?.backgroundColor
				layer.borderColor = disabledColor.cgColor
			}
		}
	}
	
	// Required for live rendering
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupLayout()
	}
	
	// Required for initializing from interface builder
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupLayout()
	}
}

// MARK: - Layout

extension AddButton {
	fileprivate func setupLayout() {
		titleLabel.font = UIFont.systemFont(ofSize: CGFloat(titleSize), weight: UIFontWeightMedium)
		titleLabel.textColor = color
		titleLabel.textAlignment = .center
		titleLabel.numberOfLines = 0
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		addSubview(titleLabel)
		
		let views = ["titleLabel": titleLabel]
		
		addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[titleLabel]-10-|", options: [], metrics: nil, views: views))
		addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[titleLabel]-8-|", options: [], metrics: nil, views: views))
	}
}
