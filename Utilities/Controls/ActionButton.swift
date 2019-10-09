//
//  ActionButton.swift
//  Utilities
//
//  Created by Caio Mello on 8/30/19.
//  Copyright © 2019 Caio Mello. All rights reserved.
//

import UIKit

open class ActionButton: UIControl {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintAdjustmentMode = .normal
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = false
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    public var image: UIImage? {
        didSet {
            imageView.image = image?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(textStyle: .headline))
        }
    }

    public var title: String = "Button" {
        didSet {
            titleLabel.text = title
        }
    }

    public var onColor: UIColor = .systemBlue
    public var offColor: UIColor = .black

    override public var isHighlighted: Bool {
        didSet {
            if oldValue != isHighlighted {
                alpha = isHighlighted ? 0.5 : 1
            }
        }
    }

    override public var isSelected: Bool {
        didSet {
            refreshState()
        }
    }

    override public func tintColorDidChange() {
        refreshState()
    }

    override public func awakeFromNib() {
        super.awakeFromNib()

        layout()
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = bounds.height/2
    }

    private func refreshState() {
        layer.borderColor = onColor.cgColor

        if isSelected {
            backgroundColor = onColor
            imageView.tintColor = offColor
            titleLabel.textColor = offColor
        } else {
            backgroundColor = onColor
            imageView.tintColor = onColor
            titleLabel.textColor = onColor
        }
    }
}

// MARK: - Layout

extension ActionButton {
    private func layout() {
        backgroundColor = .clear
        clipsToBounds = true

        layer.borderWidth = 2

        directionalLayoutMargins = NSDirectionalEdgeInsets(horizontal: 10, vertical: 8)

        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel])
        stackView.isUserInteractionEnabled = false
        stackView.spacing = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.fitToSuperview(obeyMargins: true)
    }
}
