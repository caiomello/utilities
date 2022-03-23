//
//  NotificationPromptControllerProtocol.swift
//  
//
//  Created by Caio Mello on 23.03.22.
//

import UIKit

public protocol NotificationPromptControllerProtocol {
    @MainActor func presentNotificationPromptIfNeeded(from presenter: UIViewController)
    func presentNotificationPrompt(from presenter: UIViewController, text: String, completion: @escaping (_ response: NotificationPromptResponse) -> Void)
}

public extension NotificationPromptControllerProtocol {
    func presentNotificationPrompt(from presenter: UIViewController, text: String, completion: @escaping (_ response: NotificationPromptResponse) -> Void) {
        presenter.present(from: .module) {
            let viewController = NotificationPromptViewController(coder: $0, text: text, completion: completion)
            viewController?.view.backgroundColor = presenter.view.backgroundColor
            return viewController
        }
    }
}
