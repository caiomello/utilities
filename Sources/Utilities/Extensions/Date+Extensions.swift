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
    public var year: Int {
        return Calendar.current.dateComponents([.year], from: self).year!
    }

    public var isYesterday: Bool {
        return Calendar.current.isDateInYesterday(self)
    }

    public var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }

    public var isTomorrow: Bool {
        return Calendar.current.isDateInTomorrow(self)
    }

    public var isInThePast: Bool {
        return Calendar.current.compare(self, to: Date(), toGranularity: .day) == .orderedAscending
    }

    public var isInTheFuture: Bool {
        return Calendar.current.compare(self, to: Date(), toGranularity: .day) == .orderedDescending
    }

    public var isBeforeThreeMonthsAgo: Bool {
        let threeMonthsAgo = Calendar.current.date(byAdding: .month, value: -3, to: Date())
        return Calendar.current.compare(self, to: threeMonthsAgo!, toGranularity: .month) == .orderedAscending
    }

    public var isBeforeSixMonthsAgo: Bool {
        let sixMonthsAgo = Calendar.current.date(byAdding: .month, value: -6, to: Date())
        return Calendar.current.compare(self, to: sixMonthsAgo!, toGranularity: .month) == .orderedAscending
    }

    public var isInTheLastWeek: Bool {
        let oneWeekAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        return Calendar.current.compare(self, to: oneWeekAgo!, toGranularity: .day) == .orderedDescending
    }

    public var isInTheLastTwoWeeks: Bool {
        let twoWeeksAgo = Calendar.current.date(byAdding: .day, value: -14, to: Date())
        return Calendar.current.compare(self, to: twoWeeksAgo!, toGranularity: .day) == .orderedDescending
    }

    public var isInTheNextTwelveMonths: Bool {
        let twelveMonthsFromNow = Calendar.current.date(byAdding: .month, value: 12, to: Date())
        let firstDayOfTwelveMonthsFromNow = Calendar.current.date(bySetting: .day, value: 1, of: twelveMonthsFromNow!)
        return Calendar.current.compare(self, to: firstDayOfTwelveMonthsFromNow!, toGranularity: .month) == .orderedAscending
    }

    public var isThisWeek: Bool {
        let sixDaysFromNow = Calendar.current.date(byAdding: .day, value: 6, to: Date())
        return isInTheFuture && Calendar.current.compare(self, to: sixDaysFromNow!, toGranularity: .day) == .orderedAscending
    }

    public var isThisMonth: Bool {
        return Calendar.current.isDate(self, equalTo: Date(), toGranularity: .month)
    }

    public var isNextMonth: Bool {
        let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: Date())
        return Calendar.current.isDate(self, equalTo: nextMonth!, toGranularity: .month)
    }

    public var isThisYear: Bool {
        return Calendar.current.isDate(self, equalTo: Date(), toGranularity: .year)
    }

    public var isNextYear: Bool {
        return year == Date().year + 1
    }

    public var isAfterNextYear: Bool {
        return year > Date().year + 1
    }
}


// MARK: - Text

public enum DateTextStyle {
    case full
    case short
    case year
}

extension Date {
    public func text(style: DateTextStyle) -> String {
        if isYesterday {
            return "Yesterday"
        } else if isToday {
            return "Today"
        } else if isTomorrow {
            return "Tomorrow"
        } else if isThisWeek {
            return Formatters.weekdayDateFormatter.string(from: self)
        } else {
            switch style {
            case .short:
                if isInTheNextTwelveMonths {
                    return Formatters.nearFutureDateFormatter.string(from: self)
                } else {
                    return Formatters.shortDateFormatter.string(from: self)
                }
            case .full:
                return Formatters.fullDateFormatter.string(from: self)
            case .year:
                return Formatters.yearDateFormatter.string(from: self)
            }
        }
    }
}
