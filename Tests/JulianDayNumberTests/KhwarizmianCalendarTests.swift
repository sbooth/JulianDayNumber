//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Testing
@testable import JulianDayNumber

@Suite struct KhwarizmianCalendarTests {
	@Test func epoch() throws {
		#expect(try KhwarizmianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == KhwarizmianCalendar.epoch)
		#expect(try KhwarizmianCalendar.dateFromJulianDayNumber(KhwarizmianCalendar.epoch) == (1, 1, 1))
	}

	@Test func monthLength() {
		for month in 1...12 {
			#expect(KhwarizmianCalendar.numberOfDays(inMonth: month) == 30)
		}
		#expect(KhwarizmianCalendar.numberOfDays(inMonth: 13) == 5)
	}

	@Test func yearLength() {
		#expect(KhwarizmianCalendar.numberOfDaysInYear == 365)
	}

	@Test func julianDayNumber() throws {
		#expect(try KhwarizmianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == 1952068)
		#expect(try KhwarizmianCalendar.dateFromJulianDayNumber(1952068) == (1, 1, 1))
	}

	@Test func limits() throws {
		#expect(try KhwarizmianCalendar.julianDateFrom(year: -999999, month: 1, day: 1) == -363047932.5)
		#expect(try KhwarizmianCalendar.julianDateFrom(year: -99999, month: 1, day: 1) == -34547932.5)
		#expect(try KhwarizmianCalendar.julianDateFrom(year: -9999, month: 1, day: 1) == -1697932.5)
		#expect(try KhwarizmianCalendar.julianDateFrom(year: 9999, month: 13, day: 5) == 5601701.5)
		#expect(try KhwarizmianCalendar.julianDateFrom(year: 99999, month: 13, day: 5) == 38451701.5)
		#expect(try KhwarizmianCalendar.julianDateFrom(year: 999999, month: 13, day: 5) == 366951701.5)

		#expect(try KhwarizmianCalendar.dateAndTimeFromJulianDate(-363047932.5) == (-999999, 1, 1, 0, 0, 0))
		#expect(try KhwarizmianCalendar.dateAndTimeFromJulianDate(-34547932.5) == (-99999, 1, 1, 0, 0, 0))
		#expect(try KhwarizmianCalendar.dateAndTimeFromJulianDate(-1697932.5) == (-9999, 1, 1, 0, 0, 0))
		#expect(try KhwarizmianCalendar.dateAndTimeFromJulianDate(5601701.5) == (9999, 13, 5, 0, 0, 0))
		#expect(try KhwarizmianCalendar.dateAndTimeFromJulianDate(38451701.5) == (99999, 13, 5, 0, 0, 0))
		#expect(try KhwarizmianCalendar.dateAndTimeFromJulianDate(366951701.5) == (999999, 13, 5, 0, 0, 0))
	}

	@Test func arithmeticLimits() throws {
		let minDate = try KhwarizmianCalendar.dateFromJulianDayNumber(.min + 341)
		let minJ = try KhwarizmianCalendar.julianDayNumberFromDate(minDate)
		#expect(minJ == .min + 341)

		let maxDate = try KhwarizmianCalendar.dateFromJulianDayNumber(.max)
		let maxJ = try KhwarizmianCalendar.julianDayNumberFromDate(maxDate)
		#expect(maxJ == .max)
	}
}
