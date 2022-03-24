//
//  NotificationPromptControllerProtocol.swift
//  
//
//  Created by Caio Mello on 23.03.22.
//

import UIKit

public protocol NotificationPromptControllerProtocol {
    @MainActor func presentNotificationPromptIfNeeded(from presenter: UIViewController)
    func presentNotificationPrompt(from presenter: UIViewController, text: String, accentColor: UIColor, backgroundColor: UIColor, completion: @escaping (_ response: NotificationPromptResponse) -> Void)
}

public extension NotificationPromptControllerProtocol {
    func presentNotificationPrompt(from presenter: UIViewController, text: String, accentColor: UIColor, backgroundColor: UIColor, completion: @escaping (_ response: NotificationPromptResponse) -> Void) {
        let storyboard = UIStoryboard(name: "\(NotificationPromptViewController.self)", bundle: .module)
        let viewController: NotificationPromptViewController? = storyboard.instantiateInitialViewController { NotificationPromptViewController(coder: $0, text: text, accentColor: accentColor, backgroundColor: backgroundColor, completion: completion) }
        presenter.present(viewController!, animated: true)
    }
}
