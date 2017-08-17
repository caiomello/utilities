//
//  TableView.swift
//  Utilities
//
//  Created by Caio Mello on August 17, 2017.
//  Copyright © 2017 Caio Mello. All rights reserved.
//

import UIKit

// MARK: - ScrollView

//extension UIScrollView {
//	public func scrollToTop() {
//		contentOffset.x = -contentInset.left
//		contentOffset.y = -contentInset.top
//	}
//}

extension UITableView {
	public func scrollToTop(animated: Bool) {
		guard let cell = cellForRow(at: IndexPath(row: 0, section: 0)) else { return }
		guard let indexPath = indexPath(for: cell) else { return }
		scrollToRow(at: indexPath, at: .top, animated: animated)
	}
	
	public func hideLastSeparator(withCell cell: UITableViewCell, indexPath: IndexPath) {
		cell.separatorInset.left = indexPath.row == numberOfRows(inSection: indexPath.section) - 1 ? CGFloat.greatestFiniteMagnitude : separatorInset.left
	}
}
