//
//  UIViewController+Extensions.swift
//  Utilities
//
//  Created by Caio Mello on 8/21/19.
//  Copyright © 2019 Caio Mello. All rights reserved.
//

import UIKit

extension UIViewController {
    public class func instantiate<T: UIViewController>(_ viewController: @escaping (NSCoder) -> T?) -> T {
        let storyboard = UIStoryboard(name: "\(T.self)", bundle: nil)

        return storyboard.instantiateInitialViewController(creator: viewController)!
    }

    public func show<T: UIViewController>(_ viewController: @escaping (NSCoder) -> T?) {
        let viewController = T.instantiate(viewController)
        show(viewController, sender: nil)
    }

    public func showDetail<T: UIViewController>(_ viewController: @escaping (NSCoder) -> T?) {
        let viewController = T.instantiate(viewController)

        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.barStyle = .black

        showDetailViewController(navigationController, sender: nil)
    }

    public func present<T: UIViewController>(_ viewController: @escaping (NSCoder) -> T?) {
        let viewController = T.instantiate(viewController)

        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.barStyle = .black
        navigationController.modalPresentationStyle = .formSheet

        present(navigationController, animated: true)
    }
}
