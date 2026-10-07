//
//  VersioningHelperTests.swift
//
//
//  Created by Caio Mello on 07.10.26.
//

import Testing
@testable import Utilities

private final class TestAppVersionProvider: AppVersionProvider {
    var appVersion: String?

    init(appVersion: String?) {
        self.appVersion = appVersion
    }
}

struct VersioningHelperTests {
    @Test func firstLaunchStoresTheCurrentVersion() throws {
        let versionProvider = TestAppVersionProvider(appVersion: nil)
        var helper = VersioningHelper(currentVersion: "1.2.0", versionProvider: versionProvider)

        let launch = try helper.didLaunch()

        guard case .first(let version) = launch else {
            Issue.record("Expected a first launch, got \(launch).")
            return
        }
        #expect(version == (try Version(string: "1.2.0")))
        #expect(versionProvider.appVersion == "1.2.0")
    }

    @Test func regularLaunchKeepsTheStoredVersion() throws {
        let versionProvider = TestAppVersionProvider(appVersion: "1.2.0")
        var helper = VersioningHelper(currentVersion: "1.2.0", versionProvider: versionProvider)

        let launch = try helper.didLaunch()

        guard case .regular(let version) = launch else {
            Issue.record("Expected a regular launch, got \(launch).")
            return
        }
        #expect(version == (try Version(string: "1.2.0")))
        #expect(versionProvider.appVersion == "1.2.0")
    }

    @Test func updatedLaunchReportsBothVersionsAndStoresTheCurrentOne() throws {
        let versionProvider = TestAppVersionProvider(appVersion: "1.1")
        var helper = VersioningHelper(currentVersion: "1.2.0", versionProvider: versionProvider)

        let launch = try helper.didLaunch()

        guard case .updated(let from, let to) = launch else {
            Issue.record("Expected an updated launch, got \(launch).")
            return
        }
        #expect(from == (try Version(string: "1.1")))
        #expect(to == (try Version(string: "1.2.0")))
        #expect(versionProvider.appVersion == "1.2.0")
    }

    @Test func missingVersionThrowsAndLeavesTheStoredVersionUntouched() {
        let versionProvider = TestAppVersionProvider(appVersion: "1.1")
        var helper = VersioningHelper(currentVersion: nil, versionProvider: versionProvider)

        #expect(throws: VersioningError.noBundleVersion) {
            try helper.didLaunch()
        }
        #expect(versionProvider.appVersion == "1.1")
    }
}
