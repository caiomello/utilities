//
//  AdaptiveFlowLayout.swift
//  Utilities
//
//  Created by Caio Mello on 11/30/16.
//  Copyright © 2016 Caio Mello. All rights reserved.
//

import UIKit

public protocol AdaptiveFlowLayoutDelegate {
	func cellReferenceSize() -> CGSize
	func itemsPerLine() -> Int
	
	// Optional
	func headerReferenceSize() -> CGSize
	func footerReferenceSize() -> CGSize
	func sectionInsets() -> UIEdgeInsets
	func lineSpacing() -> CGFloat
	func interItemSpacing() -> CGFloat
}

extension AdaptiveFlowLayoutDelegate {
	public func headerReferenceSize() -> CGSize {
		return CGSize.zero
	}
	
	public func footerReferenceSize() -> CGSize {
		return CGSize.zero
	}
	
	public func sectionInsets() -> UIEdgeInsets {
		return UIEdgeInsets.zero
	}
	
	public func lineSpacing() -> CGFloat {
		return 0
	}
	
	public func interItemSpacing() -> CGFloat {
		return 0
	}
}

public class AdaptiveFlowLayout: UICollectionViewFlowLayout {
	fileprivate lazy var bounds: CGRect = self.collectionView!.bounds
	
	public var delegate: AdaptiveFlowLayoutDelegate?
	
	override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
		bounds = newBounds
		updateAttributes()
		return true
	}
	
	override public func invalidateLayout() {
		updateAttributes()
		super.invalidateLayout()
	}
	
	private func updateAttributes() {
		if let delegate = delegate {
			sectionInset = delegate.sectionInsets()
			minimumLineSpacing = delegate.lineSpacing()
			minimumInteritemSpacing = delegate.interItemSpacing()
			itemSize = itemSize(with: delegate.cellReferenceSize(), itemsPerLine: delegate.itemsPerLine(), fitToWidth: bounds.width)
			headerReferenceSize = delegate.headerReferenceSize()
			footerReferenceSize = delegate.footerReferenceSize()
		}
	}
	
	private func itemSize(with referenceSize: CGSize, itemsPerLine: Int, fitToWidth width: CGFloat) -> CGSize {
		let itemsPerLine = CGFloat(itemsPerLine)
		
		let totalMargin = sectionInset.left + sectionInset.right
		let totalSpacing = minimumInteritemSpacing * (CGFloat(itemsPerLine) - 1)
		
		let itemWidth = (width - totalMargin - totalSpacing)/itemsPerLine
		
		return CGSize(size: referenceSize, aspectFitToWidth: itemWidth)
	}
}
