//
//  CollectionView.swift
//  Utilities
//
//  Created by Caio Mello on August 17, 2017.
//  Copyright © 2017 Caio Mello. All rights reserved.
//

import UIKit

extension UICollectionView {
	public func scrollToTop(animated: Bool) {
		guard let cell = cellForItem(at: IndexPath(item: 0, section: 0)) else { return }
		guard let indexPath = indexPath(for: cell) else { return }
		scrollToItem(at: indexPath, at: .top, animated: animated)
	}
}

extension UICollectionViewFlowLayout {
	public func itemSize(withColumns numberOfColumns: Int) -> CGSize {
		let numberOfColumns = CGFloat(numberOfColumns)
		
		let totalMargin = sectionInset.left + sectionInset.right
		let totalSpacing = minimumInteritemSpacing * (numberOfColumns - 1)
		
		let itemWidth = (collectionView!.bounds.width - totalMargin - totalSpacing)/numberOfColumns
		
		let size = CGSize(size: itemSize, aspectFitToWidth: itemWidth)
		
		return CGSize(width: size.width, height: size.height)
	}
}
