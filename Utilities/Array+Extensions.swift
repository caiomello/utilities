//
//  Array+Extensions.swift
//  Utilities
//
//  Created by Caio Mello on 6/2/19.
//  Copyright © 2019 Caio Mello. All rights reserved.
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
