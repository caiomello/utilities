//
//  NotificationPromptControllerProtocol.swift
//  
//
//  Created by Caio Mello on 23.03.22.
//

import UIKit

public enum NotificationPromptResponse {
    case accepted
    case denied
}

public struct NotificationPromptConfiguration {
    let text: String
    let accentColor: UIColor
    let backgroundColor: UIColor
    let font: UIFont

    public init(text: String, accentColor: UIColor, backgroundColor: UIColor, font: UIFont) {
        self.text = text
        self.accentColor = accentColor
        self.backgroundColor = backgroundColor
        self.font = font
    }
}

public protocol NotificationPromptControllerProtocol {
    @MainActor func presentNotificationPromptIfNeeded(from presenter: UIViewController)
    func presentNotificationPrompt(from presenter: UIViewController, configuration: NotificationPromptConfiguration, completion: @escaping (_ response: NotificationPromptResponse) -> Void)
}

public extension NotificationPromptControllerProtocol {
    func presentNotificationPrompt(from presenter: UIViewController, configuration: NotificationPromptConfiguration, completion: @escaping (_ response: NotificationPromptResponse) -> Void) {
        let storyboard = UIStoryboard(name: "\(NotificationPromptViewController.self)", bundle: .module)
        let viewController: NotificationPromptViewController? = storyboard.instantiateInitialViewController { NotificationPromptViewController(coder: $0, configuration: configuration, completion: completion) }
        presenter.present(viewController!, animated: true)
    }
}
