//
//  Pagination.swift
//  Utilities
//
//  Created by Caio Mello on April 28, 2017.
//  Copyright © 2017 Caio Mello. All rights reserved.
//

import Foundation

public protocol Pagination {
	var page: Int { get set }
	func requestFirstPage()
	func requestNextPage()
}

extension Pagination {
	/**
	Requests the next page of items based on the current items on a list.
	- parameter dataSource: Array of items that are the data source of a list.
	- parameter currentIndex: Index for the last displayed cell (usually from the IndexPath in willDisplayCell method).
	- parameter itemsPerPage: Number of items per page requested.
	- parameter offset: Offset that triggers the next page request. E.g. Offset is 10. Items per page is 30. Next page is requested after displaying item 20.
	*/
	public func requestNextPageIfNeeded(dataSource: [Any], currentIndex: Int, itemsPerPage: Int, offset: Int) {
		let maximumNumberOfItemsForCurrentPage = itemsPerPage * page
		
		if dataSource.count >= maximumNumberOfItemsForCurrentPage && currentIndex == (maximumNumberOfItemsForCurrentPage - offset) {
			requestNextPage()
		}
	}
}
