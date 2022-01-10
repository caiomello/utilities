//
//  ContentPresenter.swift
//  
//
//  Created by Caio Mello on 15.11.20.
//

import UIKit

public enum ContentState: Equatable {
    case content
    case loading
    case noContent(configuration: Configuration)

    public static func == (lhs: ContentState, rhs: ContentState) -> Bool {
        switch (lhs, rhs) {
        case (.content, .content), (.loading, .loading), (.noContent, .noContent):
            return true
        default:
            return false
        }
    }

    public struct Configuration {
        let image: UIImage
        let title: String
        let subtitle: String?
        let button: ButtonConfiguration?

        public init(image: UIImage, title: String, subtitle: String? = nil, button: ButtonConfiguration? = nil) {
            self.image = image
            self.title = title
            self.subtitle = subtitle
            self.button = button
        }
    }

    public struct ButtonConfiguration {
        let title: String
        let action: () -> Void

        public init(title: String, action: @escaping () -> Void) {
            self.title = title
            self.action = action
        }
    }
}

public protocol ContentPresenter {
    @MainActor var isLoading: Bool { get }
    @MainActor func setContentState(_ state: ContentState, animated: Bool)
}

extension ContentPresenter where Self: UIViewController {
    @MainActor public var isLoading: Bool {
        return currentView?.isLoading ?? false
    }

    @MainActor public func setContentState(_ state: ContentState, animated: Bool) {
        let currentView = self.currentView

        var newView: ContentStateView?

        if state != .content {
            newView = ContentStateView(state: state)
            newView?.alpha = 0
            newView?.backgroundColor = view.backgroundColor
            newView?.preservesSuperviewLayoutMargins = true
            newView?.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(newView!)
            newView?.fitToSuperview()
        }

        if animated {
            view.animate({
                currentView?.alpha = 0
                newView?.alpha = 1
            }, completion: {
                currentView?.removeFromSuperview()
            })
        } else {
            currentView?.removeFromSuperview()
            newView?.alpha = 1
        }
    }

    private var currentView: ContentStateView? {
        view.subviews.first(where: { $0 is ContentStateView }) as? ContentStateView
    }
}
