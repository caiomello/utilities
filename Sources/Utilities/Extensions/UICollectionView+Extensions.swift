//
//  UICollectionView+Extensions.swift
//  Utilities
//
//  Created by Caio Mello on 6/2/19.
//  Copyright © 2019 Caio Mello. All rights reserved.
//

import UIKit

extension UICollectionView {
    public func registerCell<T: UICollectionViewCell>(_ type: T.Type) {
        register(UINib(nibName: "\(T.self)", bundle: nil), forCellWithReuseIdentifier: "\(T.self)")
    }

    public func registerSupplementaryView<T: UICollectionReusableView>(_ type: T.Type, ofKind kind: String) {
        register(UINib(nibName: "\(T.self)", bundle: nil), forSupplementaryViewOfKind: kind, withReuseIdentifier: "\(T.self)")
    }

    public func dequeueCell<T: UICollectionViewCell>(forItemAt indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: "\(T.self)", for: indexPath) as! T
    }

    public func dequeueSupplementaryView<T: UICollectionReusableView>(ofKind kind: String, at indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(T.self)", for: indexPath) as! T
    }

    public func scrollToTop(animated: Bool = false) {
        setContentOffset(CGPoint(x: 0, y: -adjustedContentInset.top), animated: animated)
    }
}
