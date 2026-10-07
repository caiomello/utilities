//
//  VersioningHelperTests.swift
//
//
//  Created by Caio Mello on 07.10.26.
//

import Testing
@testable import Utilities

private final class TestAppVersionStore: AppVersionStore {
    var appVersion: String?

    init(appVersion: String?) {
        self.appVersion = appVersion
    }
}

struct VersioningHelperTests {
    @Test func firstLaunchStoresTheCurrentVersion() throws {
        let store = TestAppVersionStore(appVersion: nil)
        var helper = VersioningHelper(currentVersion: "1.2.0", store: store)

        let launch = try helper.didLaunch()

        guard case .first(let version) = launch else {
            Issue.record("Expected a first launch, got \(launch).")
            return
        }
        #expect(version == (try Version(string: "1.2.0")))
        #expect(store.appVersion == "1.2.0")
    }

    @Test func regularLaunchKeepsTheStoredVersion() throws {
        let store = TestAppVersionStore(appVersion: "1.2.0")
        var helper = VersioningHelper(currentVersion: "1.2.0", store: store)

        let launch = try helper.didLaunch()

        guard case .regular(let version) = launch else {
            Issue.record("Expected a regular launch, got \(launch).")
            return
        }
        #expect(version == (try Version(string: "1.2.0")))
        #expect(store.appVersion == "1.2.0")
    }

    @Test func updatedLaunchReportsBothVersionsAndStoresTheCurrentOne() throws {
        let store = TestAppVersionStore(appVersion: "1.1")
        var helper = VersioningHelper(currentVersion: "1.2.0", store: store)

        let launch = try helper.didLaunch()

        guard case .updated(let from, let to) = launch else {
            Issue.record("Expected an updated launch, got \(launch).")
            return
        }
        #expect(from == (try Version(string: "1.1")))
        #expect(to == (try Version(string: "1.2.0")))
        #expect(store.appVersion == "1.2.0")
    }

    @Test func missingVersionThrowsAndLeavesTheStoreUntouched() {
        let store = TestAppVersionStore(appVersion: "1.1")
        var helper = VersioningHelper(currentVersion: nil, store: store)

        #expect(throws: VersioningError.noBundleVersion) {
            try helper.didLaunch()
        }
        #expect(store.appVersion == "1.1")
    }
}
