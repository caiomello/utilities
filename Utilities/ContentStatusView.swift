//
//  ContentStatusView.swift
//  Utilities
//
//  Created by Caio Mello on May 9, 2017.
//  Copyright © 2017 Caio Mello. All rights reserved.
//

import UIKit

enum ContentStatusViewMode {
	case hidden
	case loading
	case title(String)
	case subtitle(title: String, subtitle: String)
	case button(title: String, subtitle: String, buttonTitle: String, buttonAction: () -> Void)
}

class ContentStatusView: UIView {
	@IBOutlet fileprivate var stackView: UIStackView!
	@IBOutlet fileprivate var titleLabel: UILabel!
	@IBOutlet fileprivate var subtitleLabel: UILabel!
	@IBOutlet fileprivate var button: UIButton!
	@IBOutlet fileprivate var activityIndicator: UIActivityIndicatorView!
	
	fileprivate var buttonAction: () -> Void = {}
	
	var mode: ContentStatusViewMode = .hidden {
		didSet {
			configure(withMode: mode)
		}
	}
}

// MARK: - Init

extension ContentStatusView {
	class func load(fromNib nib: UINib) -> ContentStatusView {
		return nib.instantiate(withOwner: nil, options: nil).first as! ContentStatusView
	}
}

// MARK: - View

extension ContentStatusView {
	override func awakeFromNib() {
		super.awakeFromNib()
		
		mode = .hidden
	}
}

// MARK: - Mode

extension ContentStatusView {
	fileprivate func configure(withMode mode: ContentStatusViewMode) {
		switch mode {
		case .hidden:
			isHidden = true
			stackView.isHidden = true
			activityIndicator.stopAnimating()
			
		case .loading:
			isHidden = false
			stackView.isHidden = true
			activityIndicator.startAnimating()
			
		case .title(let title):
			isHidden = false
			stackView.isHidden = false
			activityIndicator.stopAnimating()
			titleLabel.text = title
			subtitleLabel.text = nil
			button.isHidden = true
			
		case .subtitle(let title, let subtitle):
			isHidden = false
			stackView.isHidden = false
			activityIndicator.stopAnimating()
			titleLabel.text = title
			subtitleLabel.text = subtitle
			button.isHidden = true
			
		case .button(let title, let subtitle, let buttonTitle, let buttonAction):
			isHidden = false
			stackView.isHidden = false
			activityIndicator.stopAnimating()
			titleLabel.text = title
			subtitleLabel.text = subtitle
			button.isHidden = false
			button.setTitle(buttonTitle, for: .normal)
			self.buttonAction = buttonAction
		}
	}
}

// MARK: - Actions

extension ContentStatusView {
	@IBAction fileprivate func buttonAction(_ sender: UIButton) {
		buttonAction()
	}
}
