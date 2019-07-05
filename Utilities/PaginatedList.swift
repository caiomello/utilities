//
//  PaginatedList.swift
//  Utilities
//
//  Created by Caio Mello on 7/5/19.
//  Copyright © 2019 Caio Mello. All rights reserved.
//

import Foundation

public protocol PaginatedList {
    var page: Int { get set }
    func requestPage(_ page: Int)
}

extension PaginatedList {
    public func requestNextPageIfNeeded(currentIndex: Int, itemsPerPage: Int, initialPage: Int, offset: Int = 0) {
        let currentPage = initialPage == 0 ? page + 1 : page

        let lastIndexInCurrentPage = itemsPerPage * currentPage

        if currentIndex == (lastIndexInCurrentPage - offset) {
            requestPage(page + 1)
        }
    }
}
