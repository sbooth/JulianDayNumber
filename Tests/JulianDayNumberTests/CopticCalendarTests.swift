//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Testing
@testable import JulianDayNumber

@Suite struct CopticCalendarTests {
	@Test func epoch() {
		#expect(CopticCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == CopticCalendar.epoch)
		#expect(CopticCalendar.dateFromJulianDayNumber(CopticCalendar.epoch) == (1, 1, 1))
	}

	@Test func dateValidation() {
		#expect(CopticCalendar.isValid(year: 1739, month: 13, day: 6))
		#expect(!CopticCalendar.isValid(year: 1740, month: 13, day: 6))
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
		#expect(CopticCalendar.numberOfMonthsInYear == 13)
	}

	@Test func monthLength() {
		for month in 1...12 {
			#expect(CopticCalendar.numberOfDaysIn(month: month, year: 1) == 30)
		}
		#expect(CopticCalendar.numberOfDaysIn(month: 13, year: 1) == 5)
		#expect(CopticCalendar.numberOfDaysIn(month: 13, year: 3) == 6)
	}

	@Test func yearLength() {
		#expect(CopticCalendar.numberOfDays(inYear: 1) == 365)
		#expect(CopticCalendar.numberOfDays(inYear: 3) == 366)
		#expect(CopticCalendar.numberOfDays(inYear: 7) == 366)
		#expect(CopticCalendar.numberOfDays(inYear: 8) == 365)
		#expect(CopticCalendar.numberOfDays(inYear: 1739) == 366)
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
		let minDate = CopticCalendar.dateFromJulianDayNumber(.min)
		let minJ = CopticCalendar.julianDayNumberFromDate(minDate)
		#expect(minJ == .min)

		let maxDate = CopticCalendar.dateFromJulianDayNumber(.max)
		let maxJ = CopticCalendar.julianDayNumberFromDate(maxDate)
		#expect(maxJ == .max)

		_ = CopticCalendar.isLeapYear(.min)
		_ = CopticCalendar.isLeapYear(.max)
	}
}
