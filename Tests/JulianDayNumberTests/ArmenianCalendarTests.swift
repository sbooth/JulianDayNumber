//
// Copyright © 2021-2024 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Testing
@testable import JulianDayNumber

@Suite("Armenian Calendar Tests")
struct ArmenianCalendarTests {
	@Test func testMonthLength() async throws {
		for month in 1...12 {
			try #require(ArmenianCalendar.daysInMonth(month) == 30)
		}
		try #require(ArmenianCalendar.daysInMonth(13) == 5)
	}

	@Test func testJulianDayNumber() async throws {
		try #require(ArmenianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == 1922868)
		try #require(ArmenianCalendar.julianDayNumberFrom(year: 1473, month: 4, day: 24) == 2460261)
		try #require(ArmenianCalendar.dateFromJulianDayNumber(1922868) == (1, 1, 1))
		try #require(ArmenianCalendar.dateFromJulianDayNumber(2460261) == (1473, 4, 24))
	}

	@Test func testLimits() async throws {
		try #require(ArmenianCalendar.julianDateFrom(year: -999999, month: 1, day: 1) == -363077132.5)
		try #require(ArmenianCalendar.julianDateFrom(year: -99999, month: 1, day: 1) == -34577132.5)
		try #require(ArmenianCalendar.julianDateFrom(year: -9999, month: 1, day: 1) == -1727132.5)
		try #require(ArmenianCalendar.julianDateFrom(year: 9999, month: 13, day: 5) == 5572501.5)
		try #require(ArmenianCalendar.julianDateFrom(year: 99999, month: 13, day: 5) == 38422501.5)
		try #require(ArmenianCalendar.julianDateFrom(year: 999999, month: 13, day: 5) == 366922501.5)

		try #require(ArmenianCalendar.dateAndTimeFromJulianDate(-363077132.5) == (-999999, 1, 1, 0, 0, 0))
		try #require(ArmenianCalendar.dateAndTimeFromJulianDate(-34577132.5) == (-99999, 1, 1, 0, 0, 0))
		try #require(ArmenianCalendar.dateAndTimeFromJulianDate(-1727132.5) == (-9999, 1, 1, 0, 0, 0))
		try #require(ArmenianCalendar.dateAndTimeFromJulianDate(5572501.5) == (9999, 13, 5, 0, 0, 0))
		try #require(ArmenianCalendar.dateAndTimeFromJulianDate(38422501.5) == (99999, 13, 5, 0, 0, 0))
		try #require(ArmenianCalendar.dateAndTimeFromJulianDate(366922501.5) == (999999, 13, 5, 0, 0, 0))
	}

	@Test func testArithmeticLimits() async throws {
		// Values smaller than this cause an arithmetic overflow in dateFromJulianDayNumber
//		let smallestJDNForArmenianCalendar = Int.min + 294
		// Values smaller than this cause an arithmetic overflow in julianDayNumberFrom
		let smallestJDNForArmenianCalendar = Int.min + 341
		var (Y, M, D) = ArmenianCalendar.dateFromJulianDayNumber(smallestJDNForArmenianCalendar)
		var jdn = ArmenianCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		try #require(smallestJDNForArmenianCalendar == jdn)

		// Values larger than this cause an arithmetic overflow in dateFromJulianDayNumber
		let largestJDNForArmenianCalendar = Int.max - 317
		(Y, M, D) = ArmenianCalendar.dateFromJulianDayNumber(largestJDNForArmenianCalendar)
		jdn = ArmenianCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		try #require(largestJDNForArmenianCalendar == jdn)
	}
}
