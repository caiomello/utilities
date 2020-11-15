//
//  TextInputViewController.swift
//  Utilities
//
//  Created by Caio Mello on 09.05.20.
//  Copyright © 2020 Caio Mello. All rights reserved.
//

import UIKit

open class TextInputViewController: UIViewController {
    @IBOutlet public var scrollView: UIScrollView!
}

// MARK: - Lifecycle

extension TextInputViewController {
    override open func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: - Notifications

extension TextInputViewController {
    @objc private func adjustForKeyboard(notification: Notification) {
        let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)!.cgRectValue

        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset.bottom = 0
        } else {
            let inset = view.convert(keyboardRect, from: nil).size.height
            scrollView.contentInset.bottom = inset - scrollView.safeAreaInsets.bottom
        }

        scrollView.verticalScrollIndicatorInsets.bottom = scrollView.contentInset.bottom
    }
}
