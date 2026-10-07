//
//  SequenceExtensionsTests.swift
//
//
//  Created by Caio Mello on 07.10.26.
//

import Testing
import Utilities

struct SequenceExtensionsTests {
    @Test func groupCollectsElementsUnderTheirKeyInOrder() {
        let groups = [1, 2, 3, 4, 5].group { $0 % 2 == 0 }

        #expect(groups == [false: [1, 3, 5], true: [2, 4]])
    }

    @Test func groupOfEmptySequenceIsEmpty() {
        #expect([Int]().group { $0 }.isEmpty)
    }
}
