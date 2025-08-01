//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Testing
@testable import JulianDayNumber

@Suite struct IslamicCalendarTests {
	@Test func epoch() {
		#expect(IslamicCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == IslamicCalendar.epoch)
		#expect(IslamicCalendar.dateFromJulianDayNumber(IslamicCalendar.epoch) == (1, 1, 1))
	}

	@Test func dateValidation() {
		#expect(IslamicCalendar.isValid(year: 7, month: 12, day: 30))
		#expect(!IslamicCalendar.isValid(year: 7, month: 12, day: 31))
		#expect(!IslamicCalendar.isValid(year: 38, month: 12, day: 30))
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
		#expect(IslamicCalendar.numberOfMonthsInYear == 12)
	}

	@Test func monthLength() {
		for month in stride(from: 1, through: 12, by: 2) {
			#expect(IslamicCalendar.numberOfDaysIn(month: month, year: 1) == 30)
		}
		for month in stride(from: 2, through: 12, by: 2) {
			#expect(IslamicCalendar.numberOfDaysIn(month: month, year: 1) == 29)
		}
		#expect(IslamicCalendar.numberOfDaysIn(month: 12, year: 2) == 30)
		#expect(IslamicCalendar.numberOfDaysIn(month: 12, year: 4) == 29)
		#expect(IslamicCalendar.numberOfDaysIn(month: 12, year: 7) == 30)
	}

	@Test func yearLength() {
		#expect(IslamicCalendar.numberOfDays(inYear: 1) == 354)
		#expect(IslamicCalendar.numberOfDays(inYear: 2) == 355)
		#expect(IslamicCalendar.numberOfDays(inYear: 3) == 354)
		#expect(IslamicCalendar.numberOfDays(inYear: 4) == 354)
		#expect(IslamicCalendar.numberOfDays(inYear: 5) == 355)
		#expect(IslamicCalendar.numberOfDays(inYear: 6) == 354)
		#expect(IslamicCalendar.numberOfDays(inYear: 7) == 355)
		#expect(IslamicCalendar.numberOfDays(inYear: 8) == 354)
		#expect(IslamicCalendar.numberOfDays(inYear: 9) == 354)
		#expect(IslamicCalendar.numberOfDays(inYear: 10) == 355)
		#expect(IslamicCalendar.numberOfDays(inYear: 11) == 354)
		#expect(IslamicCalendar.numberOfDays(inYear: 12) == 354)
		#expect(IslamicCalendar.numberOfDays(inYear: 13) == 355)
		#expect(IslamicCalendar.numberOfDays(inYear: 14) == 354)
		#expect(IslamicCalendar.numberOfDays(inYear: 15) == 354)
		#expect(IslamicCalendar.numberOfDays(inYear: 16) == 355)
		#expect(IslamicCalendar.numberOfDays(inYear: 17) == 354)
		#expect(IslamicCalendar.numberOfDays(inYear: 18) == 355)
		#expect(IslamicCalendar.numberOfDays(inYear: 19) == 354)
		#expect(IslamicCalendar.numberOfDays(inYear: 20) == 354)
		#expect(IslamicCalendar.numberOfDays(inYear: 21) == 355)
		#expect(IslamicCalendar.numberOfDays(inYear: 22) == 354)
		#expect(IslamicCalendar.numberOfDays(inYear: 23) == 354)
		#expect(IslamicCalendar.numberOfDays(inYear: 24) == 355)
		#expect(IslamicCalendar.numberOfDays(inYear: 25) == 354)
		#expect(IslamicCalendar.numberOfDays(inYear: 26) == 355)
		#expect(IslamicCalendar.numberOfDays(inYear: 27) == 354)
		#expect(IslamicCalendar.numberOfDays(inYear: 28) == 354)
		#expect(IslamicCalendar.numberOfDays(inYear: 29) == 355)
		#expect(IslamicCalendar.numberOfDays(inYear: 30) == 354)
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
		let smallestJDNForIslamicCalendar: JulianDayNumber = .min + 325
		var (Y, M, D) = IslamicCalendar.dateFromJulianDayNumber(smallestJDNForIslamicCalendar)
		var jdn = IslamicCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		#expect(smallestJDNForIslamicCalendar == jdn)

		// Values larger than this cause an arithmetic overflow in dateFromJulianDayNumber
		let largestJDNForIslamicCalendar: JulianDayNumber = (.max - 15) / 30 - 7664
		(Y, M, D) = IslamicCalendar.dateFromJulianDayNumber(largestJDNForIslamicCalendar)
		jdn = IslamicCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		#expect(largestJDNForIslamicCalendar == jdn)
	}
}
