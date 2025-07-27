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

	@Test func leapYear() {
		#expect(!SyrianCalendar.isLeapYear(1))
		#expect(SyrianCalendar.isLeapYear(3))
		#expect(SyrianCalendar.isLeapYear(7))
		#expect(SyrianCalendar.isLeapYear(1739))
		#expect(!SyrianCalendar.isLeapYear(1740))
		#expect(SyrianCalendar.isLeapYear(-1))
		#expect(!SyrianCalendar.isLeapYear(-2))

		for y in -500...500 {
			let isLeap = SyrianCalendar.isLeapYear(y)
			let j = SyrianCalendar.julianDayNumberFrom(year: y, month: 6, day: isLeap ? 29 : 28)
			let d = SyrianCalendar.dateFromJulianDayNumber(j)
			#expect(d.month == 6)
			#expect(d.day == (isLeap ? 29 : 28))
		}
	}

	@Test func monthCount() {
		#expect(SyrianCalendar.monthsInYear == 12)
	}

	@Test func monthLength() {
		#expect(SyrianCalendar.daysInMonth(year: 1, month: 1) == 31)
		#expect(SyrianCalendar.daysInMonth(year: 1, month: 2) == 30)
		#expect(SyrianCalendar.daysInMonth(year: 1, month: 3) == 31)
		#expect(SyrianCalendar.daysInMonth(year: 1, month: 4) == 31)
		#expect(SyrianCalendar.daysInMonth(year: 1, month: 6) == 31)
		#expect(SyrianCalendar.daysInMonth(year: 1, month: 7) == 30)
		#expect(SyrianCalendar.daysInMonth(year: 1, month: 8) == 31)
		#expect(SyrianCalendar.daysInMonth(year: 1, month: 9) == 30)
		#expect(SyrianCalendar.daysInMonth(year: 1, month: 10) == 31)
		#expect(SyrianCalendar.daysInMonth(year: 1, month: 11) == 31)
		#expect(SyrianCalendar.daysInMonth(year: 1, month: 12) == 30)

		#expect(SyrianCalendar.daysInMonth(year: 1, month: 5) == 28)
		#expect(SyrianCalendar.daysInMonth(year: 3, month: 5) == 29)
	}

	@Test func yearLength() {
		#expect(SyrianCalendar.daysInYear(1) == 365)
		#expect(SyrianCalendar.daysInYear(3) == 366)
		#expect(SyrianCalendar.daysInYear(7) == 366)
		#expect(SyrianCalendar.daysInYear(8) == 365)
		#expect(SyrianCalendar.daysInYear(1739) == 366)
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
