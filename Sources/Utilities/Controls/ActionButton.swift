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
        return imageView
    }()

    public let titleLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = false
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()

    public var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }

    public var title: String = "Button" {
        didSet {
            titleLabel.text = title
        }
    }

    public var titleColor: UIColor = .black {
        didSet {
            titleLabel.textColor = titleColor
            imageView.tintColor = titleColor
        }
    }

    override public var isHighlighted: Bool {
        didSet {
            if oldValue != isHighlighted {
                alpha = isHighlighted ? 0.5 : 1
            }
        }
    }

    override open func awakeFromNib() {
        super.awakeFromNib()

        layout()
    }

    override open func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = bounds.height/4
    }
}

// MARK: - Layout

extension ActionButton {
    private func layout() {
        clipsToBounds = true

        backgroundColor = tintColor
        titleLabel.textColor = .black
        imageView.tintColor = titleLabel.textColor

        directionalLayoutMargins = NSDirectionalEdgeInsets(horizontal: 20, vertical: 12)

        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel])
        stackView.isUserInteractionEnabled = false
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        stackView.fitVerticalEdgesToSuperview(obeyMargins: true)
        stackView.centerHorizontallyInSuperview()

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(>=margin)-[stackView]-(>=margin)-|",
                                                      options: [],
                                                      metrics: ["margin": directionalLayoutMargins.leading],
                                                      views: ["stackView": stackView]))
    }
}
