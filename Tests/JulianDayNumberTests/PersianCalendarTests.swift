//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Testing
@testable import JulianDayNumber

@Suite struct PersianCalendarTests {
	@Test func monthLength() {
		for month in 1...8 {
			#expect(PersianCalendar.daysInMonth(month) == 30)
		}
		#expect(PersianCalendar.daysInMonth(9) == 5)
		for month in 10...13 {
			#expect(PersianCalendar.daysInMonth(month) == 30)
		}
	}

	@Test func yearLength() {
		#expect(PersianCalendar.daysInYear == 365)
	}

	@Test func julianDayNumber() {
		#expect(PersianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == 1952063)
		#expect(PersianCalendar.dateFromJulianDayNumber(1952063) == (1, 1, 1))
	}

	@Test func limits() {
		#expect(PersianCalendar.julianDateFrom(year: -999999, month: 1, day: 1) == -363047937.5)
		#expect(PersianCalendar.julianDateFrom(year: -99999, month: 1, day: 1) == -34547937.5)
		#expect(PersianCalendar.julianDateFrom(year: -9999, month: 1, day: 1) == -1697937.5)
		#expect(PersianCalendar.julianDateFrom(year: 9999, month: 13, day: 30) == 5601696.5)
		#expect(PersianCalendar.julianDateFrom(year: 99999, month: 13, day: 30) == 38451696.5)
		#expect(PersianCalendar.julianDateFrom(year: 999999, month: 13, day: 30) == 366951696.5)

		#expect(PersianCalendar.dateAndTimeFromJulianDate(-363047937.5) == (-999999, 1, 1, 0, 0, 0))
		#expect(PersianCalendar.dateAndTimeFromJulianDate(-34547937.5) == (-99999, 1, 1, 0, 0, 0))
		#expect(PersianCalendar.dateAndTimeFromJulianDate(-1697937.5) == (-9999, 1, 1, 0, 0, 0))
		#expect(PersianCalendar.dateAndTimeFromJulianDate(5601696.5) == (9999, 13, 30, 0, 0, 0))
		#expect(PersianCalendar.dateAndTimeFromJulianDate(38451696.5) == (99999, 13, 30, 0, 0, 0))
		#expect(PersianCalendar.dateAndTimeFromJulianDate(366951696.5) == (999999, 13, 30, 0, 0, 0))
	}

	@Test func arithmeticLimits() {
		// Values smaller than this cause an arithmetic overflow in dateFromJulianDayNumber
//		let smallestJDNForPersianCalendar = Int.min + 294
		// Values smaller than this cause an arithmetic overflow in julianDayNumberFrom
		let smallestJDNForPersianCalendar = Int.min + 336
		var (Y, M, D) = PersianCalendar.dateFromJulianDayNumber(smallestJDNForPersianCalendar)
		var jdn = PersianCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		#expect(smallestJDNForPersianCalendar == jdn)

		// Values larger than this cause an arithmetic overflow in dateFromJulianDayNumber
		let largestJDNForPersianCalendar = Int.max - 77
		(Y, M, D) = PersianCalendar.dateFromJulianDayNumber(largestJDNForPersianCalendar)
		jdn = PersianCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		#expect(largestJDNForPersianCalendar == jdn)
	}
}
