//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Testing
@testable import JulianDayNumber

@Suite struct CopticCalendarTests {
	@Test func dateValidation() {
		#expect(CopticCalendar.isDateValid(year: 1739, month: 13, day: 6))
		#expect(!CopticCalendar.isDateValid(year: 1740, month: 13, day: 6))
	}

	@Test func leapYear() {
		#expect(!CopticCalendar.isLeapYear(1))
		#expect(CopticCalendar.isLeapYear(3))
		#expect(CopticCalendar.isLeapYear(7))
		#expect(CopticCalendar.isLeapYear(1739))
		#expect(!CopticCalendar.isLeapYear(1740))
		#expect(CopticCalendar.isLeapYear(-1))
		#expect(!CopticCalendar.isLeapYear(-2))

		for y in -500...500 {
			let isLeap = CopticCalendar.isLeapYear(y)
			let j = CopticCalendar.julianDayNumberFrom(year: y, month: 13, day: isLeap ? 6 : 5)
			let d = CopticCalendar.dateFromJulianDayNumber(j)
			#expect(d.month == 13)
			#expect(d.day == (isLeap ? 6 : 5))
		}
	}

	@Test func monthCount() {
		#expect(CopticCalendar.monthsInYear == 13)
	}

	@Test func monthLength() {
		#expect(CopticCalendar.daysInMonth(year: 1, month: 1) == 30)
		#expect(CopticCalendar.daysInMonth(year: 1, month: 2) == 30)
		#expect(CopticCalendar.daysInMonth(year: 1, month: 3) == 30)
		#expect(CopticCalendar.daysInMonth(year: 1, month: 4) == 30)
		#expect(CopticCalendar.daysInMonth(year: 1, month: 5) == 30)
		#expect(CopticCalendar.daysInMonth(year: 1, month: 6) == 30)
		#expect(CopticCalendar.daysInMonth(year: 1, month: 7) == 30)
		#expect(CopticCalendar.daysInMonth(year: 1, month: 8) == 30)
		#expect(CopticCalendar.daysInMonth(year: 1, month: 9) == 30)
		#expect(CopticCalendar.daysInMonth(year: 1, month: 10) == 30)
		#expect(CopticCalendar.daysInMonth(year: 1, month: 11) == 30)
		#expect(CopticCalendar.daysInMonth(year: 1, month: 12) == 30)
		#expect(CopticCalendar.daysInMonth(year: 1, month: 13) == 5)
		#expect(CopticCalendar.daysInMonth(year: 3, month: 13) == 6)
	}

	@Test func julianDayNumber() {
		#expect(CopticCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == 1825030)
		#expect(CopticCalendar.dateFromJulianDayNumber(1825030) == (1, 1, 1))
	}

	@Test func limits() {
		#expect(CopticCalendar.julianDateFrom(year: -999999, month: 1, day: 1) == -363424970.5)
		#expect(CopticCalendar.julianDateFrom(year: -99999, month: 1, day: 1) == -34699970.5)
		#expect(CopticCalendar.julianDateFrom(year: -9999, month: 1, day: 1) == -1827470.5)
		#expect(CopticCalendar.julianDateFrom(year: 9999, month: 13, day: 5) == 5477162.5)
		#expect(CopticCalendar.julianDateFrom(year: 99999, month: 13, day: 5) == 38349662.5)
		#expect(CopticCalendar.julianDateFrom(year: 999999, month: 13, day: 5) == 367074662.5)

		#expect(CopticCalendar.dateAndTimeFromJulianDate(-363424970.5) == (-999999, 1, 1, 0, 0, 0))
		#expect(CopticCalendar.dateAndTimeFromJulianDate(-34699970.5) == (-99999, 1, 1, 0, 0, 0))
		#expect(CopticCalendar.dateAndTimeFromJulianDate(-1827470.5) == (-9999, 1, 1, 0, 0, 0))
		#expect(CopticCalendar.dateAndTimeFromJulianDate(5477162.5) == (9999, 13, 5, 0, 0, 0))
		#expect(CopticCalendar.dateAndTimeFromJulianDate(38349662.5) == (99999, 13, 5, 0, 0, 0))
		#expect(CopticCalendar.dateAndTimeFromJulianDate(367074662.5) == (999999, 13, 5, 0, 0, 0))
	}

	@Test func arithmeticLimits() {
		// Values smaller than this cause an arithmetic overflow in dateFromJulianDayNumber
//		let smallestJDNForCopticCalendar: JulianDayNumber = .min + 144
		// Values smaller than this cause an arithmetic overflow in julianDayNumberFrom
		let smallestJDNForCopticCalendar: JulianDayNumber = .min + 384
		var (Y, M, D) = CopticCalendar.dateFromJulianDayNumber(smallestJDNForCopticCalendar)
		var jdn = CopticCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		#expect(smallestJDNForCopticCalendar == jdn)

		// Values larger than this cause an arithmetic overflow in dateFromJulianDayNumber
		let largestJDNForCopticCalendar: JulianDayNumber = (.max - 3) / 4 - 124
		(Y, M, D) = CopticCalendar.dateFromJulianDayNumber(largestJDNForCopticCalendar)
		jdn = CopticCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		#expect(largestJDNForCopticCalendar == jdn)
	}
}
