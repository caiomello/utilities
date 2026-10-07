//
//  ConversionErrorTests.swift
//
//
//  Created by Caio Mello on 07.10.26.
//

import Testing
import Utilities

struct ConversionErrorTests {
    @Test func missingValueDescription() {
        #expect(ConversionError.missingValue("title").description == "missingValue: title")
    }

    @Test func invalidValueDescription() {
        #expect(ConversionError.invalidValue("date").description == "invalidValue: date")
    }

    @Test func constraintNotMetDescription() {
        #expect(ConversionError.constraintNotMet("non-empty").description == "constraintNotMet: non-empty")
    }
}
