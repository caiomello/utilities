//
//  DateFormatter+Extensions.swift
//  Utilities
//
//  Created by Caio Mello on 6/2/19.
//  Copyright © 2019 Caio Mello. All rights reserved.
//

import Foundation

extension DateFormatter {
    public static let shared: DateFormatter = {
        let formatter = DateFormatter()
        formatter.isLenient = true
        return formatter
    }()
}
