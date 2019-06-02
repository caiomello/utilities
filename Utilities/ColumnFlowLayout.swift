//
//  ColumnFlowLayout.swift
//  Utilities
//
//  Created by Caio Mello on 6/2/19.
//  Copyright © 2019 Caio Mello. All rights reserved.
//

import UIKit

public final class ColumnFlowLayout: UICollectionViewFlowLayout {
    public let referenceItemSize: CGSize
    public let numberOfColumns: Int

    public init(referenceItemSize: CGSize, numberOfColumns: Int, itemSpacing: CGFloat, verticalInset: CGFloat) {
        self.referenceItemSize = referenceItemSize
        self.numberOfColumns = numberOfColumns
        super.init()

        minimumInteritemSpacing = itemSpacing
        minimumLineSpacing = itemSpacing

        sectionInset.top = verticalInset
        sectionInset.bottom = verticalInset
    }

    required init(coder: NSCoder) {
        fatalError()
    }

    override public func prepare() {
        super.prepare()

        guard let collectionView = collectionView else { return }

        sectionInset.left = collectionView.directionalLayoutMargins.leading
        sectionInset.right = collectionView.directionalLayoutMargins.trailing

        itemSize = calculatedItemSize()
    }

    public func contentHeight(forItemCount numberOfItems: Int) -> CGFloat {
        let numberOfColumns = CGFloat(self.numberOfColumns)
        let numberOfItems = CGFloat(numberOfItems)
        let numberOfLines = ceil(numberOfItems / numberOfColumns)

        return sectionInset.top
            + itemSize.height * numberOfLines
            + minimumLineSpacing * (numberOfLines - 1)
            + sectionInset.bottom
    }

    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}

// MARK: - Helpers

extension ColumnFlowLayout {
    private func calculatedItemSize() -> CGSize {
        guard let collectionView = collectionView else { return .zero }

        let numberOfColumns = CGFloat(self.numberOfColumns)

        let totalMargin = sectionInset.left
            + sectionInset.right
            + collectionView.safeAreaInsets.left
            + collectionView.safeAreaInsets.right

        let totalSpacing = minimumInteritemSpacing * (numberOfColumns - 1)

        let itemWidth = (collectionView.bounds.width - totalMargin - totalSpacing) / numberOfColumns

        return CGSize(size: referenceItemSize, aspectFitToWidth: itemWidth)
    }
}
