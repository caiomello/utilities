//
//  UITableView+Extensions.swift
//  Utilities
//
//  Created by Caio Mello on 6/2/19.
//  Copyright © 2019 Caio Mello. All rights reserved.
//

import UIKit

extension UITableView {
    func registerCell<T: UITableViewCell>(_ cellClass: T.Type) {
        register(UINib(nibName: "\(T.self)", bundle: nil), forCellReuseIdentifier: "\(T.self)")
    }

    func registerHeader<T: UITableViewHeaderFooterView>(_ headerClass: T.Type) {
        register(UINib(nibName: "\(T.self)", bundle: nil), forHeaderFooterViewReuseIdentifier: "\(T.self)")
    }

    func dequeueCell<T: UITableViewCell>(forRowAt indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: "\(T.self)", for: indexPath) as! T
    }

    func dequeueHeader<T: UITableViewHeaderFooterView>() -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: "\(T.self)") as! T
    }

    func hideLastSeparators() {
        tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
    }
}
