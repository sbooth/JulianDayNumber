//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Testing
@testable import JulianDayNumber

@Suite struct ArmenianCalendarTests {
	@Test func monthLength() {
		for month in 1...12 {
			#expect(ArmenianCalendar.daysInMonth(month) == 30)
		}
		#expect(ArmenianCalendar.daysInMonth(13) == 5)
	}

	@Test func yearLength() {
		#expect(ArmenianCalendar.daysInYear == 365)
	}

	@Test func julianDayNumber() {
		#expect(ArmenianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == 1922868)
		#expect(ArmenianCalendar.julianDayNumberFrom(year: 1473, month: 4, day: 24) == 2460261)
		#expect(ArmenianCalendar.dateFromJulianDayNumber(1922868) == (1, 1, 1))
		#expect(ArmenianCalendar.dateFromJulianDayNumber(2460261) == (1473, 4, 24))
	}

	@Test func limits() {
		#expect(ArmenianCalendar.julianDateFrom(year: -999999, month: 1, day: 1) == -363077132.5)
		#expect(ArmenianCalendar.julianDateFrom(year: -99999, month: 1, day: 1) == -34577132.5)
		#expect(ArmenianCalendar.julianDateFrom(year: -9999, month: 1, day: 1) == -1727132.5)
		#expect(ArmenianCalendar.julianDateFrom(year: 9999, month: 13, day: 5) == 5572501.5)
		#expect(ArmenianCalendar.julianDateFrom(year: 99999, month: 13, day: 5) == 38422501.5)
		#expect(ArmenianCalendar.julianDateFrom(year: 999999, month: 13, day: 5) == 366922501.5)

		#expect(ArmenianCalendar.dateAndTimeFromJulianDate(-363077132.5) == (-999999, 1, 1, 0, 0, 0))
		#expect(ArmenianCalendar.dateAndTimeFromJulianDate(-34577132.5) == (-99999, 1, 1, 0, 0, 0))
		#expect(ArmenianCalendar.dateAndTimeFromJulianDate(-1727132.5) == (-9999, 1, 1, 0, 0, 0))
		#expect(ArmenianCalendar.dateAndTimeFromJulianDate(5572501.5) == (9999, 13, 5, 0, 0, 0))
		#expect(ArmenianCalendar.dateAndTimeFromJulianDate(38422501.5) == (99999, 13, 5, 0, 0, 0))
		#expect(ArmenianCalendar.dateAndTimeFromJulianDate(366922501.5) == (999999, 13, 5, 0, 0, 0))
	}

	@Test func arithmeticLimits() {
		// Values smaller than this cause an arithmetic overflow in dateFromJulianDayNumber
//		let smallestJDNForArmenianCalendar: JulianDayNumber = .min + 294
		// Values smaller than this cause an arithmetic overflow in julianDayNumberFrom
		let smallestJDNForArmenianCalendar: JulianDayNumber = .min + 341
		var (Y, M, D) = ArmenianCalendar.dateFromJulianDayNumber(smallestJDNForArmenianCalendar)
		var jdn = ArmenianCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		#expect(smallestJDNForArmenianCalendar == jdn)

		// Values larger than this cause an arithmetic overflow in dateFromJulianDayNumber
		let largestJDNForArmenianCalendar: JulianDayNumber = .max - 317
		(Y, M, D) = ArmenianCalendar.dateFromJulianDayNumber(largestJDNForArmenianCalendar)
		jdn = ArmenianCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		#expect(largestJDNForArmenianCalendar == jdn)
	}
}
