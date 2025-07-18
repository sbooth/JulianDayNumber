//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Testing
@testable import JulianDayNumber

@Suite struct SyrianCalendarTests {
	@Test func julianDayNumber() {
		#expect(SyrianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == 1607739)
		#expect(SyrianCalendar.dateFromJulianDayNumber(1607739) == (1, 1, 1))
	}

	@Test func limits() {
		#expect(SyrianCalendar.julianDateFrom(year: -999999, month: 1, day: 1) == -363642261.5)
		#expect(SyrianCalendar.julianDateFrom(year: -99999, month: 1, day: 1) == -34917261.5)
		#expect(SyrianCalendar.julianDateFrom(year: -9999, month: 1, day: 1) == -2044761.5)
		#expect(SyrianCalendar.julianDateFrom(year: 9999, month: 12, day: 30) == 5259872.5)
		#expect(SyrianCalendar.julianDateFrom(year: 99999, month: 12, day: 30) == 38132372.5)
		#expect(SyrianCalendar.julianDateFrom(year: 999999, month: 12, day: 30) == 366857372.5)

		#expect(SyrianCalendar.dateAndTimeFromJulianDate(-363642261.5) == (-999999, 1, 1, 0, 0, 0))
		#expect(SyrianCalendar.dateAndTimeFromJulianDate(-34917261.5) == (-99999, 1, 1, 0, 0, 0))
		#expect(SyrianCalendar.dateAndTimeFromJulianDate(-2044761.5) == (-9999, 1, 1, 0, 0, 0))
		#expect(SyrianCalendar.dateAndTimeFromJulianDate(5259872.5) == (9999, 12, 30, 0, 0, 0))
		#expect(SyrianCalendar.dateAndTimeFromJulianDate(38132372.5) == (99999, 12, 30, 0, 0, 0))
		#expect(SyrianCalendar.dateAndTimeFromJulianDate(366857372.5) == (999999, 12, 30, 0, 0, 0))
	}

	@Test func arithmeticLimits() {
		// Values smaller than this cause an arithmetic overflow in dateFromJulianDayNumber
		let smallestJDNForSyrianCalendar: JulianDayNumber = .min + 144
		var (Y, M, D) = SyrianCalendar.dateFromJulianDayNumber(smallestJDNForSyrianCalendar)
		var jdn = SyrianCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		#expect(smallestJDNForSyrianCalendar == jdn)

		// Values larger than this cause an arithmetic overflow in dateFromJulianDayNumber
		let largestJDNForSyrianCalendar: JulianDayNumber = (.max - 3) / 4 - 1401
		(Y, M, D) = SyrianCalendar.dateFromJulianDayNumber(largestJDNForSyrianCalendar)
		jdn = SyrianCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		#expect(largestJDNForSyrianCalendar == jdn)
	}
}
