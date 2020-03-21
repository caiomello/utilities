//
//  UICollectionViewFlowLayout+Extensions.swift
//  Utilities
//
//  Created by Caio Mello on 6/11/19.
//  Copyright © 2019 Caio Mello. All rights reserved.
//

import UIKit

extension UICollectionViewFlowLayout {
    public func itemSize(withColumns numberOfColumns: Int) -> CGSize {
        let numberOfColumns = CGFloat(numberOfColumns)

        let totalMargin = sectionInset.left + sectionInset.right + collectionView!.safeAreaInsets.left + collectionView!.safeAreaInsets.right
        let totalSpacing = minimumInteritemSpacing * (numberOfColumns - 1)

        let itemWidth = (collectionView!.bounds.width - totalMargin - totalSpacing)/numberOfColumns

        let size = CGSize(size: itemSize, aspectFitToWidth: itemWidth)

        return CGSize(width: size.width, height: size.height)
    }
}
