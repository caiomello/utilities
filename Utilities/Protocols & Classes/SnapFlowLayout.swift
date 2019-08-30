//
//  SnapFlowLayout.swift
//  Utilities
//
//  Created by Caio Mello on 6/2/19.
//  Copyright © 2019 Caio Mello. All rights reserved.
//

import UIKit

public final class SnapFlowLayout: UICollectionViewFlowLayout {
    override public func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }

        let targetRect = CGRect(x: proposedContentOffset.x,
                                y: 0,
                                width: collectionView.bounds.size.width,
                                height: collectionView.bounds.size.height)

        let layoutAttributes = super.layoutAttributesForElements(in: targetRect)

        // Scroll direction: Left -> Right
        // In this case, the first element that will be visible in `layoutAttributes` should be displayed.
        if velocity.x < 0 {
            return CGPoint(x: layoutAttributes!.first!.frame.origin.x - sectionInset.left,
                           y: proposedContentOffset.y)
        }

        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizontalOffset = proposedContentOffset.x + collectionView.contentInset.left

        layoutAttributes?.forEach {
            // Scroll direction: Right -> Left or when velocity is zero (user stops to scroll)
            if velocity.x > 0 || fabsf(Float($0.frame.origin.x - horizontalOffset)) < fabsf(Float(offsetAdjustment)) {
                offsetAdjustment = $0.frame.origin.x - horizontalOffset
            }
        }

        return CGPoint(x: proposedContentOffset.x + offsetAdjustment - sectionInset.left,
                       y: proposedContentOffset.y)
    }

    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
