//
//  ArrayExtensionsTests.swift
//
//
//  Created by Caio Mello on 07.10.26.
//

import Testing
import Utilities

struct ArrayExtensionsTests {
    @Test func splitKeepsTheRemainderInTheLastSegment() {
        #expect([1, 2, 3, 4, 5].split(itemsPerSegment: 2) == [[1, 2], [3, 4], [5]])
    }

    @Test func splitIntoEvenSegments() {
        #expect([1, 2, 3, 4].split(itemsPerSegment: 2) == [[1, 2], [3, 4]])
    }

    @Test func splitWithSegmentLargerThanArrayReturnsOneSegment() {
        #expect([1, 2, 3].split(itemsPerSegment: 5) == [[1, 2, 3]])
    }

    @Test func splitOfEmptyArrayReturnsNoSegments() {
        #expect([Int]().split(itemsPerSegment: 2) == [])
    }
}
