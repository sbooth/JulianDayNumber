//
// Copyright © 2021-2024 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Testing
@testable import JulianDayNumber

@Suite struct IslamicCalendarTests {
	@Test func dateValidation() {
		#expect(IslamicCalendar.isDateValid(year: 7, month: 12, day: 30))
		#expect(!IslamicCalendar.isDateValid(year: 7, month: 12, day: 31))
		#expect(!IslamicCalendar.isDateValid(year: 38, month: 12, day: 30))
	}

	@Test func leapYear() {
		#expect(!IslamicCalendar.isLeapYear(1))
		#expect(IslamicCalendar.isLeapYear(2))
		#expect(!IslamicCalendar.isLeapYear(3))
		#expect(!IslamicCalendar.isLeapYear(4))
		#expect(IslamicCalendar.isLeapYear(5))
		#expect(!IslamicCalendar.isLeapYear(6))
		#expect(IslamicCalendar.isLeapYear(7))
		#expect(!IslamicCalendar.isLeapYear(8))
		#expect(!IslamicCalendar.isLeapYear(9))
		#expect(IslamicCalendar.isLeapYear(10))
		#expect(!IslamicCalendar.isLeapYear(11))
		#expect(!IslamicCalendar.isLeapYear(12))
		#expect(IslamicCalendar.isLeapYear(13))
		#expect(!IslamicCalendar.isLeapYear(14))
		#expect(!IslamicCalendar.isLeapYear(15))
		#expect(IslamicCalendar.isLeapYear(16))
		#expect(!IslamicCalendar.isLeapYear(17))
		#expect(IslamicCalendar.isLeapYear(18))
		#expect(!IslamicCalendar.isLeapYear(19))
		#expect(!IslamicCalendar.isLeapYear(20))
		#expect(IslamicCalendar.isLeapYear(21))
		#expect(!IslamicCalendar.isLeapYear(22))
		#expect(!IslamicCalendar.isLeapYear(23))
		#expect(IslamicCalendar.isLeapYear(24))
		#expect(!IslamicCalendar.isLeapYear(25))
		#expect(IslamicCalendar.isLeapYear(26))
		#expect(!IslamicCalendar.isLeapYear(27))
		#expect(!IslamicCalendar.isLeapYear(28))
		#expect(IslamicCalendar.isLeapYear(29))
		#expect(!IslamicCalendar.isLeapYear(30))

		for y in -500...500 {
			let isLeap = IslamicCalendar.isLeapYear(y)
			let j = IslamicCalendar.julianDayNumberFrom(year: y, month: 12, day: isLeap ? 30 : 29)
			let d = IslamicCalendar.dateFromJulianDayNumber(j)
			#expect(d.month == 12)
			#expect(d.day == (isLeap ? 30 : 29))
		}
	}

	@Test func monthCount() {
		#expect(IslamicCalendar.monthsInYear == 12)
	}

	@Test func monthLength() {
		#expect(IslamicCalendar.daysInMonth(year: 1, month: 1) == 30)
		#expect(IslamicCalendar.daysInMonth(year: 1, month: 2) == 29)
		#expect(IslamicCalendar.daysInMonth(year: 1, month: 3) == 30)
		#expect(IslamicCalendar.daysInMonth(year: 1, month: 4) == 29)
		#expect(IslamicCalendar.daysInMonth(year: 1, month: 5) == 30)
		#expect(IslamicCalendar.daysInMonth(year: 1, month: 6) == 29)
		#expect(IslamicCalendar.daysInMonth(year: 1, month: 7) == 30)
		#expect(IslamicCalendar.daysInMonth(year: 1, month: 8) == 29)
		#expect(IslamicCalendar.daysInMonth(year: 1, month: 9) == 30)
		#expect(IslamicCalendar.daysInMonth(year: 1, month: 10) == 29)
		#expect(IslamicCalendar.daysInMonth(year: 1, month: 11) == 30)
		#expect(IslamicCalendar.daysInMonth(year: 1, month: 12) == 29)
		#expect(IslamicCalendar.daysInMonth(year: 2, month: 12) == 30)
		#expect(IslamicCalendar.daysInMonth(year: 4, month: 12) == 29)
		#expect(IslamicCalendar.daysInMonth(year: 7, month: 12) == 30)
	}

	@Test func julianDayNumber() {
		// From Richards
		#expect(IslamicCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == 1948440)
		// From Meeus
		#expect(IslamicCalendar.julianDayNumberFrom(year: 1421, month: 1, day: 1) == 2451641)
	}

	@Test func limits() {
		#expect(IslamicCalendar.julianDateFrom(year: -999999, month: 1, day: 1) == -352418227.5)
		#expect(IslamicCalendar.julianDateFrom(year: -99999, month: 1, day: 1) == -33488227.5)
		#expect(IslamicCalendar.julianDateFrom(year: -9999, month: 1, day: 1) == -1595227.5)
		#expect(IslamicCalendar.julianDateFrom(year: 9999, month: 12, day: 29) == 5491750.5)
		#expect(IslamicCalendar.julianDateFrom(year: 99999, month: 12, day: 29) == 37384750.5)
		#expect(IslamicCalendar.julianDateFrom(year: 999999, month: 12, day: 29) == 356314750.5)

		#expect(IslamicCalendar.dateAndTimeFromJulianDate(-352418227.5) == (-999999, 1, 1, 0, 0, 0))
		#expect(IslamicCalendar.dateAndTimeFromJulianDate(-33488227.5) == (-99999, 1, 1, 0, 0, 0))
		#expect(IslamicCalendar.dateAndTimeFromJulianDate(-1595227.5) == (-9999, 1, 1, 0, 0, 0))
		#expect(IslamicCalendar.dateAndTimeFromJulianDate(5491750.5) == (9999, 12, 29, 0, 0, 0))
		#expect(IslamicCalendar.dateAndTimeFromJulianDate(37384750.5) == (99999, 12, 29, 0, 0, 0))
		#expect(IslamicCalendar.dateAndTimeFromJulianDate(356314750.5) == (999999, 12, 29, 0, 0, 0))
	}

	@Test func arithmeticLimits() {
		// Values smaller than this cause an arithmetic overflow in dateFromJulianDayNumber
		let smallestJDNForIslamicCalendar = Int.min + 325
		var (Y, M, D) = IslamicCalendar.dateFromJulianDayNumber(smallestJDNForIslamicCalendar)
		var jdn = IslamicCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		#expect(smallestJDNForIslamicCalendar == jdn)

		// Values larger than this cause an arithmetic overflow in dateFromJulianDayNumber
		let largestJDNForIslamicCalendar = (Int.max - 15) / 30 - 7664
		(Y, M, D) = IslamicCalendar.dateFromJulianDayNumber(largestJDNForIslamicCalendar)
		jdn = IslamicCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		#expect(largestJDNForIslamicCalendar == jdn)
	}
}
