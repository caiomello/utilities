//
//  VersioningHelper.swift
//  Watchlist
//
//  Created by Caio Mello on 20.12.21.
//  Copyright © 2021 Caio Mello. All rights reserved.
//

import Foundation
import OSLog

public protocol AppVersionProvider {
    var appVersion: String? { get set }
}

public struct Version: Equatable {
    public let major: Int
    public let minor: Int
    public let patch: Int?

    public var description: String {
        var version = "\(major)" + ".\(minor)"
        if let patch {
            version.append(".\(patch)")
        }
        return version
    }

    public init(string: String) throws {
        let components = string.components(separatedBy: ".")

        if components.count == 3, let major = Int(components[0]), let minor = Int(components[1]), let patch = Int(components[2]) {
            self.major = major
            self.minor = minor
            self.patch = patch
        } else if components.count == 2, let major = Int(components[0]), let minor = Int(components[1]) {
            self.major = major
            self.minor = minor
            self.patch = nil
        } else {
            throw VersioningError.invalidVersion
        }
    }
}

public enum LaunchType {
    case regular(Version)
    case updated(from: Version, to: Version)
    case first(Version)
}

public enum VersioningError: Error {
    case invalidVersion
    case noBundleVersion
}

public struct VersioningHelper {
    private let currentVersionString: String?
    private var versionProvider: any AppVersionProvider
    private let logger = Logger(subsystem: "Utilities", category: "VersioningHelper")

    init(currentVersion: String?, versionProvider: any AppVersionProvider) {
        self.currentVersionString = currentVersion
        self.versionProvider = versionProvider
    }

    public init(bundle: Bundle, versionProvider: any AppVersionProvider) {
        self.init(
            currentVersion: bundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String,
            versionProvider: versionProvider
        )
    }

    public mutating func didLaunch() throws -> LaunchType {
        let previousVersionString = versionProvider.appVersion

        do {
            guard let currentVersionString else { throw VersioningError.noBundleVersion }

            let currentVersion = try Version(string: currentVersionString)

            versionProvider.appVersion = currentVersionString

            if previousVersionString == nil {
                logger.notice("First launch - version \(currentVersion.description)")
                return .first(currentVersion)
            } else if let previousVersionString = previousVersionString, previousVersionString != currentVersionString {
                logger.notice("Updated from version \(previousVersionString) to \(currentVersionString)")
                return .updated(from: try Version(string: previousVersionString), to: currentVersion)
            } else {
                logger.notice("Regular launch - version \(currentVersionString)")
                return .regular(currentVersion)
            }
        } catch {
            logger.notice("Unable to retrieve version - \(error)")
            throw error
        }
    }
}
