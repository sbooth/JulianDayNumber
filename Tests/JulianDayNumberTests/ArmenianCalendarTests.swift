//
// SPDX-FileCopyrightText: 2021 Stephen F. Booth <contact@sbooth.dev>
// SPDX-License-Identifier: MIT
//
// Part of https://github.com/sbooth/JulianDayNumber
//

import Testing
@testable import JulianDayNumber

@Suite struct ArmenianCalendarTests {
	@Test func epoch() throws {
		#expect(try ArmenianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == ArmenianCalendar.epoch)
		#expect(try ArmenianCalendar.dateFromJulianDayNumber(ArmenianCalendar.epoch) == (1, 1, 1))
	}

	@Test func monthLength() {
		for month in 1...12 {
			#expect(ArmenianCalendar.numberOfDays(inMonth: month) == 30)
		}
		#expect(ArmenianCalendar.numberOfDays(inMonth: 13) == 5)
	}

	@Test func yearLength() {
		#expect(ArmenianCalendar.numberOfDaysInYear == 365)
	}

	@Test func julianDayNumber() throws {
		#expect(try ArmenianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == 1922868)
		#expect(try ArmenianCalendar.julianDayNumberFrom(year: 1473, month: 4, day: 24) == 2460261)
		#expect(try ArmenianCalendar.dateFromJulianDayNumber(1922868) == (1, 1, 1))
		#expect(try ArmenianCalendar.dateFromJulianDayNumber(2460261) == (1473, 4, 24))
	}

	@Test func limits() throws {
		#expect(try ArmenianCalendar.julianDateFrom(year: -999999, month: 1, day: 1) == -363077132.5)
		#expect(try ArmenianCalendar.julianDateFrom(year: -99999, month: 1, day: 1) == -34577132.5)
		#expect(try ArmenianCalendar.julianDateFrom(year: -9999, month: 1, day: 1) == -1727132.5)
		#expect(try ArmenianCalendar.julianDateFrom(year: 9999, month: 13, day: 5) == 5572501.5)
		#expect(try ArmenianCalendar.julianDateFrom(year: 99999, month: 13, day: 5) == 38422501.5)
		#expect(try ArmenianCalendar.julianDateFrom(year: 999999, month: 13, day: 5) == 366922501.5)

		#expect(try ArmenianCalendar.dateAndTimeFromJulianDate(-363077132.5) == (-999999, 1, 1, 0, 0, 0))
		#expect(try ArmenianCalendar.dateAndTimeFromJulianDate(-34577132.5) == (-99999, 1, 1, 0, 0, 0))
		#expect(try ArmenianCalendar.dateAndTimeFromJulianDate(-1727132.5) == (-9999, 1, 1, 0, 0, 0))
		#expect(try ArmenianCalendar.dateAndTimeFromJulianDate(5572501.5) == (9999, 13, 5, 0, 0, 0))
		#expect(try ArmenianCalendar.dateAndTimeFromJulianDate(38422501.5) == (99999, 13, 5, 0, 0, 0))
		#expect(try ArmenianCalendar.dateAndTimeFromJulianDate(366922501.5) == (999999, 13, 5, 0, 0, 0))
	}

	@Test func arithmeticLimits() throws {
		let minDate = try ArmenianCalendar.dateFromJulianDayNumber(.min + 341)
		let minJ = try ArmenianCalendar.julianDayNumberFromDate(minDate)
		#expect(minJ == .min + 341)

		let maxDate = try ArmenianCalendar.dateFromJulianDayNumber(.max)
		let maxJ = try ArmenianCalendar.julianDayNumberFromDate(maxDate)
		#expect(maxJ == .max)
	}
}
