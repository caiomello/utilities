//
//  PurchaseButton.swift
//  Utilities
//
//  Created by Caio Mello on 8/30/19.
//  Copyright © 2019 Caio Mello. All rights reserved.
//

import UIKit

public final class PurchaseButton: UIControl {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()

    private let activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.color = .lightGray
        view.hidesWhenStopped = true
        return view
    }()

    public var title: String = "$" {
        didSet {
            titleLabel.text = title
        }
    }

    public var onColor: UIColor = .systemBlue {
        didSet {
            tintColor = onColor
        }
    }

    public func startLoading() {
        animate({
            self.layer.borderColor = UIColor.lightGray.cgColor
            self.isUserInteractionEnabled = false
            self.titleLabel.alpha = 0
            self.activityIndicatorView.startAnimating()
        })
    }

    public func stopLoading() {
        animate({
            self.layer.borderColor = self.onColor.cgColor
            self.isUserInteractionEnabled = true
            self.titleLabel.alpha = 1
            self.activityIndicatorView.stopAnimating()
        })
    }

    override public var isHighlighted: Bool {
        didSet {
            if oldValue != isHighlighted {
                alpha = isHighlighted ? 0.5 : 1
            }
        }
    }

    override public func tintColorDidChange() {
        layer.borderColor = tintColor.cgColor
        titleLabel.textColor = tintColor
    }

    override public func awakeFromNib() {
        super.awakeFromNib()

        layout()
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = bounds.height/2
    }
}

// MARK: - Layout

extension PurchaseButton {
    private func layout() {
        backgroundColor = .clear
        clipsToBounds = true

        layer.borderWidth = 2

        directionalLayoutMargins = NSDirectionalEdgeInsets(horizontal: 12, vertical: 10)

        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicatorView)
        activityIndicatorView.centerToSuperview()

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        titleLabel.fitToSuperview(obeyMargins: true)
    }
}
