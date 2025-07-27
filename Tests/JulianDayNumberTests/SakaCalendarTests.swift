//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Testing
@testable import JulianDayNumber

@Suite struct SakaCalendarTests {
	@Test func dateValidation() {
		#expect(SakaCalendar.isDateValid(year: 1, month: 1, day: 1))
		#expect(!SakaCalendar.isDateValid(year: 3, month: 1, day: 31))
		#expect(SakaCalendar.isDateValid(year: 2, month: 1, day: 31))
	}

	@Test func leapYear() {
		#expect(SakaCalendar.isLeapYear(78))
		#expect(!SakaCalendar.isLeapYear(4))
		#expect(!SakaCalendar.isLeapYear(100))
		#expect(SakaCalendar.isLeapYear(750))
		#expect(!SakaCalendar.isLeapYear(1429))
		#expect(SakaCalendar.isLeapYear(1522))
		#expect(!SakaCalendar.isLeapYear(-3))
		#expect(SakaCalendar.isLeapYear(-78))

		for y in -500...500 {
			let isLeap = SakaCalendar.isLeapYear(y)
			let j = SakaCalendar.julianDayNumberFrom(year: y, month: 1, day: isLeap ? 31 : 30)
			let d = SakaCalendar.dateFromJulianDayNumber(j)
			#expect(d.month == 1)
			#expect(d.day == (isLeap ? 31 : 30))
		}
	}

	@Test func monthCount() {
		#expect(SakaCalendar.monthsInYear == 12)
	}

	@Test func monthLength() {
		#expect(SakaCalendar.daysInMonth(year: 1, month: 1) == 30)
		#expect(SakaCalendar.daysInMonth(year: 1, month: 2) == 31)
		#expect(SakaCalendar.daysInMonth(year: 1, month: 3) == 31)
		#expect(SakaCalendar.daysInMonth(year: 1, month: 4) == 31)
		#expect(SakaCalendar.daysInMonth(year: 1, month: 5) == 31)
		#expect(SakaCalendar.daysInMonth(year: 1, month: 6) == 31)
		#expect(SakaCalendar.daysInMonth(year: 1, month: 7) == 30)
		#expect(SakaCalendar.daysInMonth(year: 1, month: 8) == 30)
		#expect(SakaCalendar.daysInMonth(year: 1, month: 9) == 30)
		#expect(SakaCalendar.daysInMonth(year: 1, month: 10) == 30)
		#expect(SakaCalendar.daysInMonth(year: 1, month: 11) == 30)
		#expect(SakaCalendar.daysInMonth(year: 1, month: 12) == 30)
	}

	@Test func yearLength() {
		#expect(SakaCalendar.daysInYear(4) == 365)
		#expect(SakaCalendar.daysInYear(78) == 366)
		#expect(SakaCalendar.daysInYear(100) == 365)
		#expect(SakaCalendar.daysInYear(750) == 366)
		#expect(SakaCalendar.daysInYear(1522) == 366)
	}

	@Test func julianDayNumber() {
		#expect(SakaCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == 1749995)
	}

	@Test func limits() {
		#expect(SakaCalendar.julianDateFrom(year: -999999, month: 1, day: 1) == -363492505.5)
		#expect(SakaCalendar.julianDateFrom(year: -99999, month: 1, day: 1) == -34774255.5)
		#expect(SakaCalendar.julianDateFrom(year: -9999, month: 1, day: 1) == -1902430.5)
		#expect(SakaCalendar.julianDateFrom(year: 9999, month: 12, day: 30) == 5402053.5)
		#expect(SakaCalendar.julianDateFrom(year: 99999, month: 12, day: 30) == 38273878.5)
		#expect(SakaCalendar.julianDateFrom(year: 999999, month: 12, day: 30) == 366992128.5)

		#expect(SakaCalendar.dateAndTimeFromJulianDate(-363492505.5) == (-999999, 1, 1, 0, 0, 0))
		#expect(SakaCalendar.dateAndTimeFromJulianDate(-34774255.5) == (-99999, 1, 1, 0, 0, 0))
		#expect(SakaCalendar.dateAndTimeFromJulianDate(-1902430.5) == (-9999, 1, 1, 0, 0, 0))
		#expect(SakaCalendar.dateAndTimeFromJulianDate(5402053.5) == (9999, 12, 30, 0, 0, 0))
		#expect(SakaCalendar.dateAndTimeFromJulianDate(38273878.5) == (99999, 12, 30, 0, 0, 0))
		#expect(SakaCalendar.dateAndTimeFromJulianDate(366992128.5) == (999999, 12, 30, 0, 0, 0))
	}

	@Test func arithmeticLimits() {
		// Values smaller than this cause an arithmetic overflow in dateFromJulianDayNumber
		let smallestJDNForSakaCalendar: JulianDayNumber = .min + 56457
		var (Y, M, D) = SakaCalendar.dateFromJulianDayNumber(smallestJDNForSakaCalendar)
		var jdn = SakaCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		#expect(smallestJDNForSakaCalendar == jdn)

		// Values larger than this cause an arithmetic overflow in dateFromJulianDayNumber
		let largestJDNForSakaCalendar: JulianDayNumber = 2305795661307959298
		(Y, M, D) = SakaCalendar.dateFromJulianDayNumber(largestJDNForSakaCalendar)
		jdn = SakaCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		#expect(largestJDNForSakaCalendar == jdn)
	}
}
