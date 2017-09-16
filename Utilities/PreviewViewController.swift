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
	
	public convenience init(item: Previewable, actions: [UIPreviewAction]) {
		self.init()
		
		view.backgroundColor = .black
		
		imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(imageView)
		view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[imageView]|", options: [], metrics: nil, views: ["imageView": imageView]))
		view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[imageView]|", options: [], metrics: nil, views: ["imageView": imageView]))
		
		self.item = item
		self.previewActions = actions
		self.preferredContentSize = item.previewImageAspectRatio()
		
		item.previewImageDownloadBlock { (image) in
			self.imageView.image = image
			
			if let image = image {
				self.preferredContentSize = image.size
			}
		}
	}
}
