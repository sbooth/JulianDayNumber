//
// Copyright © 2021-2024 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Testing
@testable import JulianDayNumber

@Suite struct BahaiCalendarTests {
	@Test func dateValidation() {
		#expect(BahaiCalendar.isDateValid(year: 1, month: 1, day: 1))
		#expect(!BahaiCalendar.isDateValid(year: 3, month: 19, day: 5))
		#expect(BahaiCalendar.isDateValid(year: 4, month: 19, day: 5))
	}

	@Test func leapYear() {
		#expect(!BahaiCalendar.isLeapYear(1))
		#expect(BahaiCalendar.isLeapYear(4))
		#expect(BahaiCalendar.isLeapYear(100))
		#expect(!BahaiCalendar.isLeapYear(750))
		#expect(BahaiCalendar.isLeapYear(900))
		#expect(BahaiCalendar.isLeapYear(1236))
		#expect(!BahaiCalendar.isLeapYear(1429))
		#expect(!BahaiCalendar.isLeapYear(-3))
		#expect(BahaiCalendar.isLeapYear(-4))
		#expect(BahaiCalendar.isLeapYear(-8))
		#expect(BahaiCalendar.isLeapYear(-100))

		for y in -500...500 {
			let isLeap = BahaiCalendar.isLeapYear(y)
			let j = BahaiCalendar.julianDayNumberFrom(year: y, month: 19, day: isLeap ? 5 : 4)
			let d = BahaiCalendar.dateFromJulianDayNumber(j)
			#expect(d.month == 19)
			#expect(d.day == (isLeap ? 5 : 4))
		}
	}

	@Test func monthCount() {
		#expect(BahaiCalendar.monthsInYear == 20)
	}

	@Test func monthLength() {
		#expect(BahaiCalendar.daysInMonth(year: 1, month: 1) == 19)
		#expect(BahaiCalendar.daysInMonth(year: 1, month: 2) == 19)
		#expect(BahaiCalendar.daysInMonth(year: 1, month: 3) == 19)
		#expect(BahaiCalendar.daysInMonth(year: 1, month: 4) == 19)
		#expect(BahaiCalendar.daysInMonth(year: 1, month: 5) == 19)
		#expect(BahaiCalendar.daysInMonth(year: 1, month: 6) == 19)
		#expect(BahaiCalendar.daysInMonth(year: 1, month: 7) == 19)
		#expect(BahaiCalendar.daysInMonth(year: 1, month: 8) == 19)
		#expect(BahaiCalendar.daysInMonth(year: 1, month: 9) == 19)
		#expect(BahaiCalendar.daysInMonth(year: 1, month: 10) == 19)
		#expect(BahaiCalendar.daysInMonth(year: 1, month: 11) == 19)
		#expect(BahaiCalendar.daysInMonth(year: 1, month: 12) == 19)
		#expect(BahaiCalendar.daysInMonth(year: 1, month: 13) == 19)
		#expect(BahaiCalendar.daysInMonth(year: 1, month: 14) == 19)
		#expect(BahaiCalendar.daysInMonth(year: 1, month: 15) == 19)
		#expect(BahaiCalendar.daysInMonth(year: 1, month: 16) == 19)
		#expect(BahaiCalendar.daysInMonth(year: 1, month: 17) == 19)
		#expect(BahaiCalendar.daysInMonth(year: 1, month: 18) == 19)
		#expect(BahaiCalendar.daysInMonth(year: 1, month: 20) == 19)
		#expect(BahaiCalendar.daysInMonth(year: 2, month: 19) == 4)
		#expect(BahaiCalendar.daysInMonth(year: 3, month: 19) == 4)
		#expect(BahaiCalendar.daysInMonth(year: 4, month: 19) == 5)
	}

	@Test func julianDayNumber() {
		#expect(BahaiCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == 2394647)
	}

	@Test func limits() {
		#expect(BahaiCalendar.julianDateFrom(year: -999999, month: 1, day: 1) == -362847853.5)
		#expect(BahaiCalendar.julianDateFrom(year: -99999, month: 1, day: 1) == -34129603.5)
		#expect(BahaiCalendar.julianDateFrom(year: -9999, month: 1, day: 1) == -1257778.5)
		#expect(BahaiCalendar.julianDateFrom(year: 9999, month: 20, day: 19) == 6046704.5)
		#expect(BahaiCalendar.julianDateFrom(year: 99999, month: 20, day: 19) == 38918529.5)
		#expect(BahaiCalendar.julianDateFrom(year: 999999, month: 20, day: 19) == 367636779.5)

		#expect(BahaiCalendar.dateAndTimeFromJulianDate(-362847853.5) == (-999999, 1, 1, 0, 0, 0))
		#expect(BahaiCalendar.dateAndTimeFromJulianDate(-34129603.5) == (-99999, 1, 1, 0, 0, 0))
		#expect(BahaiCalendar.dateAndTimeFromJulianDate(-1257778.5) == (-9999, 1, 1, 0, 0, 0))
		#expect(BahaiCalendar.dateAndTimeFromJulianDate(6046704.5) == (9999, 20, 19, 0, 0, 0))
		#expect(BahaiCalendar.dateAndTimeFromJulianDate(38918529.5) == (99999, 20, 19, 0, 0, 0))
		#expect(BahaiCalendar.dateAndTimeFromJulianDate(367636779.5) == (999999, 20, 19, 0, 0, 0))
	}

	@Test func arithmeticLimits() {
		// Values smaller than this cause an arithmetic overflow in dateFromJulianDayNumber
		let smallestJDNForBahaiCalendar = Int.min + 56457
		var (Y, M, D) = BahaiCalendar.dateFromJulianDayNumber(smallestJDNForBahaiCalendar)
		var jdn = BahaiCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		#expect(smallestJDNForBahaiCalendar == jdn)

		// Values larger than this cause an arithmetic overflow in dateFromJulianDayNumber
		let largestJDNForBahaiCalendar = 2305795661307959248
		(Y, M, D) = BahaiCalendar.dateFromJulianDayNumber(largestJDNForBahaiCalendar)
		jdn = BahaiCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		#expect(largestJDNForBahaiCalendar == jdn)
	}
}
