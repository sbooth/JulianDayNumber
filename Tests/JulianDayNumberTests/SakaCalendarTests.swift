//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Testing
@testable import JulianDayNumber

@Suite struct SakaCalendarTests {
	@Test func epoch() {
		#expect(SakaCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == SakaCalendar.epoch)
		#expect(SakaCalendar.dateFromJulianDayNumber(SakaCalendar.epoch) == (1, 1, 1))
	}

	@Test func dateValidation() {
		#expect(SakaCalendar.isValid(year: 1, month: 1, day: 1))
		#expect(!SakaCalendar.isValid(year: 3, month: 1, day: 31))
		#expect(SakaCalendar.isValid(year: 2, month: 1, day: 31))
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
		#expect(SakaCalendar.numberOfMonthsInYear == 12)
	}

	@Test func monthLength() {
		#expect(SakaCalendar.numberOfDaysIn(month: 1, year: 1) == 30)
		#expect(SakaCalendar.numberOfDaysIn(month: 2, year: 1) == 31)
		#expect(SakaCalendar.numberOfDaysIn(month: 3, year: 1) == 31)
		#expect(SakaCalendar.numberOfDaysIn(month: 4, year: 1) == 31)
		#expect(SakaCalendar.numberOfDaysIn(month: 5, year: 1) == 31)
		#expect(SakaCalendar.numberOfDaysIn(month: 6, year: 1) == 31)
		#expect(SakaCalendar.numberOfDaysIn(month: 7, year: 1) == 30)
		#expect(SakaCalendar.numberOfDaysIn(month: 8, year: 1) == 30)
		#expect(SakaCalendar.numberOfDaysIn(month: 9, year: 1) == 30)
		#expect(SakaCalendar.numberOfDaysIn(month: 10, year: 1) == 30)
		#expect(SakaCalendar.numberOfDaysIn(month: 11, year: 1) == 30)
		#expect(SakaCalendar.numberOfDaysIn(month: 12, year: 1) == 30)
	}

	@Test func yearLength() {
		#expect(SakaCalendar.numberOfDays(inYear: 4) == 365)
		#expect(SakaCalendar.numberOfDays(inYear: 78) == 366)
		#expect(SakaCalendar.numberOfDays(inYear: 100) == 365)
		#expect(SakaCalendar.numberOfDays(inYear: 750) == 366)
		#expect(SakaCalendar.numberOfDays(inYear: 1522) == 366)
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
#if _pointerBitWidth(_64)
		// Values smaller than this cause an arithmetic overflow in dateFromJulianDayNumber
		let smallestJDNForSakaCalendar: JulianDayNumber = -9223372036852969357

		let minDate = SakaCalendar.dateFromJulianDayNumber(smallestJDNForSakaCalendar)
		let minJ = SakaCalendar.julianDayNumberFromDate(minDate)
		#expect(minJ == smallestJDNForSakaCalendar)
#endif

		let maxDate = SakaCalendar.dateFromJulianDayNumber(.max)
		let maxJ = SakaCalendar.julianDayNumberFromDate(maxDate)
		#expect(maxJ == .max)
	}
}
