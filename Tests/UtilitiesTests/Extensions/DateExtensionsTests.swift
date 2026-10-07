//
//  DateExtensionsTests.swift
//
//
//  Created by Caio Mello on 07.10.26.
//

import Foundation
import Testing
import Utilities

struct DateExtensionsTests {
    private let calendar = Calendar.current

    private func date(byAdding component: Calendar.Component, value: Int) throws -> Date {
        try #require(calendar.date(byAdding: component, value: value, to: Date()))
    }

    private func fixedDate(year: Int, month: Int, day: Int) throws -> Date {
        try #require(calendar.date(from: DateComponents(year: year, month: month, day: day)))
    }

    @Test func yearIsTheCalendarYear() throws {
        #expect(try fixedDate(year: 2000, month: 1, day: 15).year == 2000)
    }

    @Test func yesterdayTodayAndTomorrowAreRecognised() throws {
        let yesterday = try date(byAdding: .day, value: -1)
        let today = Date()
        let tomorrow = try date(byAdding: .day, value: 1)

        #expect(yesterday.isYesterday)
        #expect(today.isYesterday == false)

        #expect(today.isToday)
        #expect(tomorrow.isToday == false)

        #expect(tomorrow.isTomorrow)
        #expect(today.isTomorrow == false)
    }

    @Test func pastAndFutureExcludeToday() throws {
        let yesterday = try date(byAdding: .day, value: -1)
        let tomorrow = try date(byAdding: .day, value: 1)

        #expect(yesterday.isInThePast)
        #expect(Date().isInThePast == false)

        #expect(tomorrow.isInTheFuture)
        #expect(Date().isInTheFuture == false)
    }

    @Test func monthsAgoCompareByMonth() throws {
        #expect(try date(byAdding: .month, value: -4).isBeforeThreeMonthsAgo)
        #expect(try date(byAdding: .month, value: -3).isBeforeThreeMonthsAgo == false)

        #expect(try date(byAdding: .month, value: -7).isBeforeSixMonthsAgo)
        #expect(try date(byAdding: .month, value: -6).isBeforeSixMonthsAgo == false)
    }

    @Test func recentWeeksExcludeTheirFirstDay() throws {
        #expect(try date(byAdding: .day, value: -6).isInTheLastWeek)
        #expect(try date(byAdding: .day, value: -7).isInTheLastWeek == false)

        #expect(try date(byAdding: .day, value: -13).isInTheLastTwoWeeks)
        #expect(try date(byAdding: .day, value: -14).isInTheLastTwoWeeks == false)
    }

    @Test func nextTwelveMonthsIncludesTheEleventhMonthAndExcludesTheThirteenth() throws {
        #expect(try date(byAdding: .month, value: 11).isInTheNextTwelveMonths)
        #expect(try date(byAdding: .month, value: 13).isInTheNextTwelveMonths == false)
    }

    @Test func thisWeekCoversTheNextFiveDays() throws {
        #expect(try date(byAdding: .day, value: 1).isThisWeek)
        #expect(try date(byAdding: .day, value: 5).isThisWeek)
        #expect(Date().isThisWeek == false)
        #expect(try date(byAdding: .day, value: 6).isThisWeek == false)
    }

    @Test func monthsAreRecognised() throws {
        let nextMonth = try date(byAdding: .month, value: 1)

        #expect(Date().isThisMonth)
        #expect(nextMonth.isThisMonth == false)

        #expect(nextMonth.isNextMonth)
        #expect(Date().isNextMonth == false)
    }

    @Test func yearsAreRecognised() throws {
        let nextYear = try date(byAdding: .year, value: 1)
        let yearAfterNext = try date(byAdding: .year, value: 2)

        #expect(Date().isThisYear)
        #expect(nextYear.isThisYear == false)

        #expect(nextYear.isNextYear)
        #expect(Date().isNextYear == false)
        #expect(yearAfterNext.isNextYear == false)

        #expect(yearAfterNext.isAfterNextYear)
        #expect(nextYear.isAfterNextYear == false)
    }

    @Test func relativeDaysUseWords() throws {
        let yesterday = try date(byAdding: .day, value: -1)
        let tomorrow = try date(byAdding: .day, value: 1)

        for style in [DateTextStyle.full, .short, .year] {
            #expect(yesterday.text(style: style) == "Yesterday")
            #expect(Date().text(style: style) == "Today")
            #expect(tomorrow.text(style: style) == "Tomorrow")
        }
    }

    @Test func daysThisWeekUseTheWeekday() throws {
        let date = try date(byAdding: .day, value: 3)
        let weekday = calendar.weekdaySymbols[calendar.component(.weekday, from: date) - 1]

        for style in [DateTextStyle.full, .short, .year] {
            #expect(date.text(style: style) == weekday)
        }
    }

    @Test func fullStyleShowsMonthDayAndYear() throws {
        #expect(try fixedDate(year: 2000, month: 1, day: 15).text(style: .full) == "January 15, 2000")
    }

    @Test func yearStyleShowsYear() throws {
        #expect(try fixedDate(year: 2000, month: 1, day: 15).text(style: .year) == "2000")
    }

    @Test func shortStyleOmitsYearWithinTheNextTwelveMonths() throws {
        #expect(try fixedDate(year: 2000, month: 1, day: 15).text(style: .short) == "January 15")
    }

    @Test func shortStyleAbbreviatesBeyondTheNextTwelveMonths() throws {
        #expect(try fixedDate(year: 2100, month: 3, day: 5).text(style: .short) == "Mar 5, 2100")
    }
}
