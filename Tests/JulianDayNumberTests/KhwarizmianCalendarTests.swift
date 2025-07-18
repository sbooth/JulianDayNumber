//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Testing
@testable import JulianDayNumber

@Suite struct KhwarizmianCalendarTests {
	@Test func monthLength() {
		for month in 1...12 {
			#expect(KhwarizmianCalendar.daysInMonth(month) == 30)
		}
		#expect(KhwarizmianCalendar.daysInMonth(13) == 5)
	}

	@Test func julianDayNumber() {
		#expect(KhwarizmianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == 1952068)
		#expect(KhwarizmianCalendar.dateFromJulianDayNumber(1952068) == (1, 1, 1))
	}

	@Test func limits() {
		#expect(KhwarizmianCalendar.julianDateFrom(year: -999999, month: 1, day: 1) == -363047932.5)
		#expect(KhwarizmianCalendar.julianDateFrom(year: -99999, month: 1, day: 1) == -34547932.5)
		#expect(KhwarizmianCalendar.julianDateFrom(year: -9999, month: 1, day: 1) == -1697932.5)
		#expect(KhwarizmianCalendar.julianDateFrom(year: 9999, month: 13, day: 5) == 5601701.5)
		#expect(KhwarizmianCalendar.julianDateFrom(year: 99999, month: 13, day: 5) == 38451701.5)
		#expect(KhwarizmianCalendar.julianDateFrom(year: 999999, month: 13, day: 5) == 366951701.5)

		#expect(KhwarizmianCalendar.dateAndTimeFromJulianDate(-363047932.5) == (-999999, 1, 1, 0, 0, 0))
		#expect(KhwarizmianCalendar.dateAndTimeFromJulianDate(-34547932.5) == (-99999, 1, 1, 0, 0, 0))
		#expect(KhwarizmianCalendar.dateAndTimeFromJulianDate(-1697932.5) == (-9999, 1, 1, 0, 0, 0))
		#expect(KhwarizmianCalendar.dateAndTimeFromJulianDate(5601701.5) == (9999, 13, 5, 0, 0, 0))
		#expect(KhwarizmianCalendar.dateAndTimeFromJulianDate(38451701.5) == (99999, 13, 5, 0, 0, 0))
		#expect(KhwarizmianCalendar.dateAndTimeFromJulianDate(366951701.5) == (999999, 13, 5, 0, 0, 0))
	}

	@Test func arithmeticLimits() {
		// Values smaller than this cause an arithmetic overflow in dateFromJulianDayNumber
//		let smallestJDNForKhwarizmianCalendar: JulianDayNumber = .min + 294
		// Values smaller than this cause an arithmetic overflow in julianDayNumberFrom
		let smallestJDNForKhwarizmianCalendar: JulianDayNumber = .min + 341
		var (Y, M, D) = KhwarizmianCalendar.dateFromJulianDayNumber(smallestJDNForKhwarizmianCalendar)
		var jdn = KhwarizmianCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		#expect(smallestJDNForKhwarizmianCalendar == jdn)

		// Values larger than this cause an arithmetic overflow in dateFromJulianDayNumber
		let largestJDNForKhwarizmianCalendar: JulianDayNumber = .max - 317
		(Y, M, D) = KhwarizmianCalendar.dateFromJulianDayNumber(largestJDNForKhwarizmianCalendar)
		jdn = KhwarizmianCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		#expect(largestJDNForKhwarizmianCalendar == jdn)
	}
}
