//
//  Sequence+Extensions.swift
//  Utilities
//
//  Created by Caio Mello on 6/2/19.
//  Copyright © 2019 Caio Mello. All rights reserved.
//

import Foundation

extension Sequence {
    public func group<U>(by key: (Element) -> U) -> [U: [Element]] {
        var categories: [U: [Element]] = [:]

        for element in self {
            let key = key(element)

            if case nil = categories[key]?.append(element) {
                categories[key] = [element]
            }
        }

        return categories
    }
}
