//
//  Date.swift
//  Utilities
//
//  Created by Caio Mello on August 17, 2017.
//  Copyright © 2017 Caio Mello. All rights reserved.
//

import Foundation

// MARK: - DateFormatter

extension DateFormatter {
	public static let shared: DateFormatter = {
		let formatter = DateFormatter()
		formatter.locale = Locale(identifier: "en_US_POSIX")
		formatter.timeZone = TimeZone(secondsFromGMT: 0)
		formatter.isLenient = true
		return formatter
	}()
}

// MARK: - Helpers

extension Date {
//	public init(date: Date, hour: Int) {
//		self.init(timeInterval: 0, since: Calendar.current.date(bySetting: .hour, value: hour, of: date)!)
//	}
	
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
		} else if isThisYear() {
			DateFormatter.shared.dateFormat = short ? "MMM d" : "MMMM d"
		} else {
			DateFormatter.shared.dateFormat = short ? "MMM d, yyyy" : "MMMM d, yyyy"
		}
		
		return DateFormatter.shared.string(from: self)
	}
}
