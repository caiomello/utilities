//
//  VersionTests.swift
//
//
//  Created by Caio Mello on 07.10.26.
//

import Testing
import Utilities

struct VersionTests {
    @Test func parsesMajorMinorAndPatch() throws {
        let version = try Version(string: "1.2.3")

        #expect(version.major == 1)
        #expect(version.minor == 2)
        #expect(version.patch == 3)
    }

    @Test func parsesMajorAndMinorWithoutPatch() throws {
        let version = try Version(string: "1.2")

        #expect(version.major == 1)
        #expect(version.minor == 2)
        #expect(version.patch == nil)
    }

    @Test(arguments: ["", "1", "1.2.3.4", "1.x", "a.b.c", "1..3"])
    func invalidStringsThrow(string: String) {
        #expect(throws: VersioningError.invalidVersion) {
            try Version(string: string)
        }
    }

    @Test(arguments: ["1.2.3", "1.2", "10.0.1"])
    func descriptionRoundTrips(string: String) throws {
        #expect(try Version(string: string).description == string)
    }
}
