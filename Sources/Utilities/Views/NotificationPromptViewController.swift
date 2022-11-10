//
//  NotificationPromptViewController.swift
//
//
//  Created by Caio Mello on 23.03.22.
//

import UIKit

public final class NotificationPromptViewController: UIViewController {
    @IBOutlet private var textLabel: UILabel!
    @IBOutlet private var acceptButton: ActionButton!
    @IBOutlet private var denyButton: UIButton!

    private let configuration: NotificationPromptConfiguration

    private let completion: (_ response: NotificationPromptResponse) -> Void

    public init?(coder: NSCoder, configuration: NotificationPromptConfiguration, completion: @escaping (_ response: NotificationPromptResponse) -> Void) {
        self.configuration = configuration
        self.completion = completion
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

// MARK: - Lifecycle

extension NotificationPromptViewController {
    public override func viewDidLoad() {
        super.viewDidLoad()

        isModalInPresentation = true
        sheetPresentationController?.detents = [.medium()]
        sheetPresentationController?.preferredCornerRadius = 20

        view.directionalLayoutMargins = NSDirectionalEdgeInsets(horizontal: 20, vertical: 20)

        view.tintColor = configuration.accentColor
        view.backgroundColor = configuration.backgroundColor

        textLabel.text = configuration.text
        textLabel.font = configuration.font

        acceptButton.titleLabel.font = configuration.font
        acceptButton.titleColor = configuration.backgroundColor
        acceptButton.backgroundColor = configuration.accentColor
        acceptButton.title = "Enable Notifications"

        denyButton.titleLabel?.font = configuration.font
    }
}

// MARK: - Interaction

extension NotificationPromptViewController {
    @IBAction private func acceptButtonAction(_ sender: ActionButton) {
        completion(.accepted)
        dismiss(animated: true)
    }

    @IBAction private func denyButtonAction(_ sender: UIButton) {
        completion(.denied)
        dismiss(animated: true)
    }
}
