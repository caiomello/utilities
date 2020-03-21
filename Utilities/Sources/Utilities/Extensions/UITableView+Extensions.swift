//
//  UITableView+Extensions.swift
//  Utilities
//
//  Created by Caio Mello on 6/2/19.
//  Copyright © 2019 Caio Mello. All rights reserved.
//

import UIKit

extension UITableView {
    public func registerCell<T: UITableViewCell>(_ cellClass: T.Type) {
        register(UINib(nibName: "\(T.self)", bundle: nil), forCellReuseIdentifier: "\(T.self)")
    }

    public func registerHeader<T: UITableViewHeaderFooterView>(_ headerClass: T.Type) {
        register(UINib(nibName: "\(T.self)", bundle: nil), forHeaderFooterViewReuseIdentifier: "\(T.self)")
    }

    public func dequeueCell<T: UITableViewCell>(forRowAt indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: "\(T.self)", for: indexPath) as! T
    }

    public func dequeueHeader<T: UITableViewHeaderFooterView>() -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: "\(T.self)") as! T
    }

    public func hideTrailingSeparators() {
        tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
    }

    public func scrollToTop(animated: Bool = false) {
        guard numberOfRows(inSection: 0) > 0 else { return }
        scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: animated)
    }
}
