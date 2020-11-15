//
//  ContentStateView.swift
//  
//
//  Created by Caio Mello on 15.11.20.
//

import UIKit

final class ContentStateView: UIView {
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
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.textAlignment = .center
        label.textColor = .lightGray
        label.numberOfLines = 0
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textAlignment = .center
        label.textColor = .lightGray
        label.numberOfLines = 0
        return label
    }()

    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
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

    var isLoading: Bool {
        activityIndicatorView.isAnimating
    }

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
            break

        case .loading:
            stackView.isHidden = true
            activityIndicatorView.startAnimating()


        case .noContent(let configuration):
            stackView.isHidden = false
            activityIndicatorView.stopAnimating()
            imageView.image = configuration.image
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
