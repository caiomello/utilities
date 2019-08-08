//
//  Date+Extensions.swift
//  Utilities
//
//  Created by Caio Mello on 6/2/19.
//  Copyright © 2019 Caio Mello. All rights reserved.
//

import Foundation

// MARK: - Helpers

extension Date {
    public func year() -> Int {
        return Calendar.current.dateComponents([.year], from: self).year!
    }

    public func isInThePast() -> Bool {
        return Calendar.current.compare(self, to: Date(), toGranularity: .day) == .orderedAscending
    }

    public func isInTheFuture() -> Bool {
        return Calendar.current.compare(self, to: Date(), toGranularity: .day) == .orderedDescending
    }

    public func isBeforeThreeMonthsAgo() -> Bool {
        let threeMonthsAgo = Calendar.current.date(byAdding: .month, value: -3, to: Date())
        return Calendar.current.compare(self, to: threeMonthsAgo!, toGranularity: .month) == .orderedAscending
    }

    public func isInTheLastWeek() -> Bool {
        let oneWeekAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        return Calendar.current.compare(self, to: oneWeekAgo!, toGranularity: .day) == .orderedDescending
    }

    public func isYesterday() -> Bool {
        return Calendar.current.isDateInYesterday(self)
    }

    public func isToday() -> Bool {
        return Calendar.current.isDateInToday(self)
    }

    public func isTomorrow() -> Bool {
        return Calendar.current.isDateInTomorrow(self)
    }

    public func isThisWeek() -> Bool {
        let sixDaysFromNow = Calendar.current.date(byAdding: .day, value: 6, to: Date())
        return isInTheFuture() && self < sixDaysFromNow!
    }

    public func isThisMonth() -> Bool {
        return Calendar.current.isDate(self, equalTo: Date(), toGranularity: .month)
    }

    public func isNextMonth() -> Bool {
        let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: Date())
        return Calendar.current.isDate(self, equalTo: nextMonth!, toGranularity: .month)
    }

    public func isThisYear() -> Bool {
        return Calendar.current.isDate(self, equalTo: Date(), toGranularity: .year)
    }

    public func isNextYear() -> Bool {
        return year() == Date().year() + 1
    }

    public func isAfterNextYear() -> Bool {
        return year() > Date().year() + 1
    }

    public func isUnknown() -> Bool {
        return self == Date.distantPast || self == Date.distantFuture
    }
}

// MARK: - Text

extension Date {
    public func text() -> String? {
        return text(short: false)
    }

    public func shortText() -> String? {
        return text(short: true)
    }

    public func yearText() -> String? {
        if isUnknown() {
            return nil
        }

        DateFormatter.shared.dateFormat = "yyyy"
        return DateFormatter.shared.string(from: self)
    }

    private func text(short: Bool) -> String? {
        if isUnknown() {
            return nil
        } else if isYesterday() {
            return "Yesterday"
        } else if isToday() {
            return "Today"
        } else if isTomorrow() {
            return "Tomorrow"
        } else if isThisWeek() {
            DateFormatter.shared.dateFormat = "EEEE"
        } else if isThisYear(), isInTheFuture() {
            DateFormatter.shared.dateFormat = short ? "MMM d" : "MMMM d"
        } else {
            DateFormatter.shared.dateFormat = short ? "MMM d, yyyy" : "MMMM d, yyyy"
        }

        return DateFormatter.shared.string(from: self)
    }
}
