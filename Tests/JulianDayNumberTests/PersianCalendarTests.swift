//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Testing
@testable import JulianDayNumber

@Suite struct PersianCalendarTests {
	@Test func epoch() throws {
		#expect(try PersianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == PersianCalendar.epoch)
		#expect(try PersianCalendar.dateFromJulianDayNumber(PersianCalendar.epoch) == (1, 1, 1))
	}

	@Test func monthLength() {
		for month in 1...8 {
			#expect(PersianCalendar.numberOfDays(inMonth: month) == 30)
		}
		#expect(PersianCalendar.numberOfDays(inMonth: 9) == 5)
		for month in 10...13 {
			#expect(PersianCalendar.numberOfDays(inMonth: month) == 30)
		}
	}

	@Test func yearLength() {
		#expect(PersianCalendar.numberOfDaysInYear == 365)
	}

	@Test func julianDayNumber() throws {
		#expect(try PersianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == 1952063)
		#expect(try PersianCalendar.dateFromJulianDayNumber(1952063) == (1, 1, 1))
	}

	@Test func limits() throws {
		#expect(try PersianCalendar.julianDateFrom(year: -999999, month: 1, day: 1) == -363047937.5)
		#expect(try PersianCalendar.julianDateFrom(year: -99999, month: 1, day: 1) == -34547937.5)
		#expect(try PersianCalendar.julianDateFrom(year: -9999, month: 1, day: 1) == -1697937.5)
		#expect(try PersianCalendar.julianDateFrom(year: 9999, month: 13, day: 30) == 5601696.5)
		#expect(try PersianCalendar.julianDateFrom(year: 99999, month: 13, day: 30) == 38451696.5)
		#expect(try PersianCalendar.julianDateFrom(year: 999999, month: 13, day: 30) == 366951696.5)

		#expect(try PersianCalendar.dateAndTimeFromJulianDate(-363047937.5) == (-999999, 1, 1, 0, 0, 0))
		#expect(try PersianCalendar.dateAndTimeFromJulianDate(-34547937.5) == (-99999, 1, 1, 0, 0, 0))
		#expect(try PersianCalendar.dateAndTimeFromJulianDate(-1697937.5) == (-9999, 1, 1, 0, 0, 0))
		#expect(try PersianCalendar.dateAndTimeFromJulianDate(5601696.5) == (9999, 13, 30, 0, 0, 0))
		#expect(try PersianCalendar.dateAndTimeFromJulianDate(38451696.5) == (99999, 13, 30, 0, 0, 0))
		#expect(try PersianCalendar.dateAndTimeFromJulianDate(366951696.5) == (999999, 13, 30, 0, 0, 0))
	}

	@Test func arithmeticLimits() throws {
		let minDate = try PersianCalendar.dateFromJulianDayNumber(.min + 336)
		let minJ = try PersianCalendar.julianDayNumberFromDate(minDate)
		#expect(minJ == .min + 336)

		let maxDate = try PersianCalendar.dateFromJulianDayNumber(.max)
		let maxJ = try PersianCalendar.julianDayNumberFromDate(maxDate)
		#expect(maxJ == .max)
	}
}
