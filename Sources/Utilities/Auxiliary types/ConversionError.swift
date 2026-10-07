//
//  ConversionError.swift
//  Watchlist
//
//  Created by Caio Mello on 14.11.21.
//  Copyright © 2021 Caio Mello. All rights reserved.
//

import Foundation

public enum ConversionError: Error, CustomStringConvertible {
    case missingValue(_ value: String)
    case invalidValue(_ description: String)
    case constraintNotMet(_ constraint: String)

    public var description: String {
        switch self {
        case .missingValue(let value):
            return "missingValue: \(value)"
        case .invalidValue(let description):
            return "invalidValue: \(description)"
        case .constraintNotMet(let constraint):
            return "constraintNotMet: \(constraint)"
        }
    }
}
