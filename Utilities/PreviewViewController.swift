//
//  PreviewViewController.swift
//  Utilities
//
//  Created by Caio Mello on August 22, 2017.
//  Copyright © 2017 Caio Mello. All rights reserved.
//

import UIKit

public struct AspectRatio {
	let width: Int
	let height: Int
}

public protocol Previewable {
	func previewImageAspectRatio() -> AspectRatio
	func previewImageDownloadBlock(_ completion: (UIImage?) -> Void)
}

public class PreviewViewController: UIViewController {
	@IBOutlet private var imageView: UIImageView!
	
	private var item: Previewable?
	private var previewActions: [UIPreviewActionItem] = []
	
	override public var previewActionItems: [UIPreviewActionItem] {
		return previewActions
	}
}

// MARK: - View

extension PreviewViewController {
	override public func viewDidLoad() {
		super.viewDidLoad()
	}
}

// MARK: - Helpers

extension PreviewViewController {
	public class func controller(withItem item: Previewable, actions: [UIPreviewActionItem]) -> PreviewViewController? {
		let previewViewController = UIStoryboard(name: "Preview", bundle: Bundle(for: PreviewViewController.self)).instantiateInitialViewController() as? PreviewViewController
		previewViewController?.item = item
		previewViewController?.previewActions = actions
		previewViewController?.preferredContentSize = CGSize(width: item.previewImageAspectRatio().width, height: item.previewImageAspectRatio().height)
		
		item.previewImageDownloadBlock { (image) in
			previewViewController?.imageView.image = image
		}
		
		return previewViewController
	}
}
