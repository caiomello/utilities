//
//  Collections.swift
//  Utilities
//
//  Created by Caio Mello on August 17, 2017.
//  Copyright © 2017 Caio Mello. All rights reserved.
//

import Foundation

extension Array {
	public func split(itemsPerSegment: Int) -> [[Element]] {
		let sequence = stride(from: startIndex, to: endIndex, by: itemsPerSegment)
		
		return sequence.map({
			let rangeEndIndex = $0.advanced(by: itemsPerSegment) > endIndex ? endIndex : $0.advanced(by: itemsPerSegment)
			return Array(self[$0..<rangeEndIndex])
		})
	}
}

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
