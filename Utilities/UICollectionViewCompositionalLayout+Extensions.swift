//
//  UICollectionViewCompositionalLayout+Extensions.swift
//  Utilities
//
//  Created by Caio Mello on 7/5/19.
//  Copyright © 2019 Caio Mello. All rights reserved.
//

import UIKit

extension UICollectionViewCompositionalLayout {
    public class func columnCompositionalLayout(numberOfColumnsCompact: Int, numberOfColumnsRegular: Int, itemAspectRatio: CGSize, spacing: CGFloat, insets: NSDirectionalEdgeInsets) -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (section: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let numberOfColumns = layoutEnvironment.traitCollection.horizontalSizeClass == .compact ? numberOfColumnsCompact : numberOfColumnsRegular

            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(itemAspectRatio.width/itemAspectRatio.height),
                                                  heightDimension: .fractionalHeight(1))

            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupHeight: CGFloat = {
                let totalSpacing = spacing * (CGFloat(numberOfColumns) - 1)
                let horizontalInsets = insets.leading + insets.trailing

                let itemWidth = (layoutEnvironment.container.effectiveContentSize.width - totalSpacing - horizontalInsets)/CGFloat(numberOfColumns)

                return itemWidth * itemAspectRatio.height/itemAspectRatio.width
            }()

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .absolute(groupHeight))

            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: numberOfColumns)
            group.interItemSpacing = .fixed(spacing)

            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = spacing
            section.contentInsets = insets

            return section
        }
    }
}
