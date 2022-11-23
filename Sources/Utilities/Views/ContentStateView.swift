//
//  ContentStateView.swift
//  
//
//  Created by Caio Mello on 15.11.20.
//

import UIKit

public final class ContentStateView: UIView {
    public struct Appearance {
        public static var shared = ContentStateView.Appearance()
        public var titleFont: UIFont?
        public var subtitleFont: UIFont?
        public var buttonFont: UIFont?
    }

    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [imageView, textStackView, button])
        view.axis = .vertical
        view.alignment = .center
        view.spacing = 24
        return view
    }()

    private lazy var textStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        view.axis = .vertical
        view.spacing = 8
        return view
    }()

    private let imageView: UIImageView = {
        let view = UIImageView()
        view.tintColor = .lightGray
        view.contentMode = .scaleAspectFit
        view.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 64)
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.font = Appearance.shared.titleFont ?? UIFont.preferredFont(forTextStyle: .title1)
        label.textAlignment = .center
        label.textColor = .lightGray
        label.numberOfLines = 0
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.font = Appearance.shared.subtitleFont ?? UIFont.preferredFont(forTextStyle: .body)
        label.textAlignment = .center
        label.textColor = .lightGray
        label.numberOfLines = 0
        return label
    }()

    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.titleLabel?.font = Appearance.shared.buttonFont ?? UIFont.preferredFont(forTextStyle: .headline)
        button.addTarget(self, action: #selector(getter: buttonAction), for: .touchUpInside)
        return button
    }()

    private let activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.hidesWhenStopped = true
        view.color = .white
        return view
    }()

    @objc private lazy var buttonAction: (() -> Void)? = nil

    var isLoading = false

    public required init(state: ContentState) {
        super.init(frame: .zero)
        configure(state: state)
        layout()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

// MARK: - Configuration

extension ContentStateView {
    private func configure(state: ContentState) {
        switch state {
        case .content:
            isLoading = false

        case .loading:
            isLoading = true
            stackView.isHidden = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                self?.activityIndicatorView.startAnimating()
            }


        case .noContent(let configuration):
            isLoading = false
            activityIndicatorView.stopAnimating()
            stackView.isHidden = false
            imageView.image = configuration.image
            imageView.isHidden = configuration.image == nil
            titleLabel.text = configuration.title
            subtitleLabel.text = configuration.subtitle

            UIView.performWithoutAnimation { [weak self] in
                self?.button.setTitle(configuration.button?.title, for: .normal)
                self?.button.layoutIfNeeded()
            }

            buttonAction = configuration.button?.action
        }
    }
}

// MARK: - Layout

extension ContentStateView {
    private func layout() {
        backgroundColor = .systemBackground

        directionalLayoutMargins = NSDirectionalEdgeInsets(horizontal: 64, vertical: 64)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.centerVerticallyInSuperview()
        stackView.fitHorizontalEdgesToSuperview(obeyMargins: true)

        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicatorView)
        activityIndicatorView.centerInSuperview()
    }
}
