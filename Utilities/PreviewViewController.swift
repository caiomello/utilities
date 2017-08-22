//
//  PreviewViewController.swift
//  Utilities
//
//  Created by Caio Mello on August 22, 2017.
//  Copyright © 2017 Caio Mello. All rights reserved.
//

import UIKit

public protocol Previewable {
	func previewImageAspectRatio() -> CGSize
	func previewImageDownloadBlock(_ completion: @escaping (UIImage?) -> Void)
}

public class PreviewViewController: UIViewController {
	@IBOutlet public var imageView: UIImageView!
	
	public var item: Previewable?
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
			print(previewViewController?.imageView)
			previewViewController?.imageView.image = image
		}
		
		return previewViewController
	}
}
