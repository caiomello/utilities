//
//  UICollectionView+Extensions.swift
//  Utilities
//
//  Created by Caio Mello on 6/2/19.
//  Copyright © 2019 Caio Mello. All rights reserved.
//

import UIKit

extension UICollectionView {
    public func registerCell<T: UICollectionViewCell>(_ cellClass: T.Type) {
        register(UINib(nibName: "\(T.self)", bundle: nil), forCellWithReuseIdentifier: "\(T.self)")
    }

    public func dequeueCell<T: UICollectionViewCell>(forItemAt indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: "\(T.self)", for: indexPath) as! T
    }

    public func scrollToTop(animated: Bool = false) {
        if numberOfItems(inSection: 0) > 0 {
            scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: animated)
        }
    }
}
