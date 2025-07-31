//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Testing
@testable import JulianDayNumber

@Suite struct FrenchRepublicanCalendarTests {
	@Test func epoch() {
		#expect(FrenchRepublicanCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == FrenchRepublicanCalendar.epoch)
		#expect(FrenchRepublicanCalendar.dateFromJulianDayNumber(FrenchRepublicanCalendar.epoch) == (1, 1, 1))
	}

	@Test func dateValidation() {
		#expect(FrenchRepublicanCalendar.isValid(year: 1, month: 1, day: 1))
		#expect(FrenchRepublicanCalendar.isValid(year: 3, month: 13, day: 6))
		#expect(!FrenchRepublicanCalendar.isValid(year: 4, month: 13, day: 6))
	}

	@Test func leapYear() {
		#expect(FrenchRepublicanCalendar.isLeapYear(3))
		#expect(FrenchRepublicanCalendar.isLeapYear(7))
		#expect(FrenchRepublicanCalendar.isLeapYear(11))
		#expect(FrenchRepublicanCalendar.isLeapYear(95))
		#expect(!FrenchRepublicanCalendar.isLeapYear(99))
		#expect(FrenchRepublicanCalendar.isLeapYear(103))
		#expect(!FrenchRepublicanCalendar.isLeapYear(2))
		#expect(!FrenchRepublicanCalendar.isLeapYear(8))
		#expect(FrenchRepublicanCalendar.isLeapYear(-1))
		#expect(!FrenchRepublicanCalendar.isLeapYear(-2))
		#expect(FrenchRepublicanCalendar.isLeapYear(-5))

		for y in -500...500 {
			let isLeap = FrenchRepublicanCalendar.isLeapYear(y)
			let j = FrenchRepublicanCalendar.julianDayNumberFrom(year: y, month: 13, day: isLeap ? 6 : 5)
			let d = FrenchRepublicanCalendar.dateFromJulianDayNumber(j)
			#expect(d.month == 13)
			#expect(d.day == (isLeap ? 6 : 5))
		}
	}

	@Test func monthCount() {
		#expect(FrenchRepublicanCalendar.numberOfMonthsInYear == 13)
	}

	@Test func monthLength() {
		#expect(FrenchRepublicanCalendar.numberOfDaysIn(month: 1, year: 1) == 30)
		#expect(FrenchRepublicanCalendar.numberOfDaysIn(month: 2, year: 1) == 30)
		#expect(FrenchRepublicanCalendar.numberOfDaysIn(month: 13, year: 2) == 5)
		#expect(FrenchRepublicanCalendar.numberOfDaysIn(month: 13, year: 3) == 6)
		#expect(FrenchRepublicanCalendar.numberOfDaysIn(month: 13, year: 4) == 5)
	}

	@Test func yearLength() {
		#expect(FrenchRepublicanCalendar.numberOfDays(inYear: 3) == 366)
		#expect(FrenchRepublicanCalendar.numberOfDays(inYear: 4) == 365)
		#expect(FrenchRepublicanCalendar.numberOfDays(inYear: 99) == 365)
		#expect(FrenchRepublicanCalendar.numberOfDays(inYear: 103) == 366)
		#expect(FrenchRepublicanCalendar.numberOfDays(inYear: 750) == 365)
		#expect(FrenchRepublicanCalendar.numberOfDays(inYear: 1600) == 365)
	}

	@Test func julianDayNumber() {
		#expect(FrenchRepublicanCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == 2375840)
	}

	@Test func limits() {
		#expect(FrenchRepublicanCalendar.julianDateFrom(year: -999999, month: 1, day: 1) == -362866660.5)
		#expect(FrenchRepublicanCalendar.julianDateFrom(year: -99999, month: 1, day: 1) == -34148410.5)
		#expect(FrenchRepublicanCalendar.julianDateFrom(year: -9999, month: 1, day: 1) == -1276585.5)
		#expect(FrenchRepublicanCalendar.julianDateFrom(year: 9999, month: 13, day: 6) == 6027898.5)
		#expect(FrenchRepublicanCalendar.julianDateFrom(year: 99999, month: 13, day: 6) == 38899723.5)
		#expect(FrenchRepublicanCalendar.julianDateFrom(year: 999999, month: 13, day: 6) == 367617973.5)

		#expect(FrenchRepublicanCalendar.dateAndTimeFromJulianDate(-362866660.5) == (-999999, 1, 1, 0, 0, 0))
		#expect(FrenchRepublicanCalendar.dateAndTimeFromJulianDate(-34148410.5) == (-99999, 1, 1, 0, 0, 0))
		#expect(FrenchRepublicanCalendar.dateAndTimeFromJulianDate(-1276585.5) == (-9999, 1, 1, 0, 0, 0))
		#expect(FrenchRepublicanCalendar.dateAndTimeFromJulianDate(6027898.5) == (9999, 13, 6, 0, 0, 0))
		#expect(FrenchRepublicanCalendar.dateAndTimeFromJulianDate(38899723.5) == (99999, 13, 6, 0, 0, 0))
		#expect(FrenchRepublicanCalendar.dateAndTimeFromJulianDate(367617973.5) == (999999, 13, 6, 0, 0, 0))
	}

	@Test func arithmeticLimits() {
		// Values smaller than this cause an arithmetic overflow in dateFromJulianDayNumber
//		let smallestJDNForFrenchRepublicanCalendar: JulianDayNumber = .min + 56456
		// Values smaller than this cause an arithmetic overflow in julianDayNumberFrom
		let smallestJDNForFrenchRepublicanCalendar: JulianDayNumber = .min + 56759
		var (Y, M, D) = FrenchRepublicanCalendar.dateFromJulianDayNumber(smallestJDNForFrenchRepublicanCalendar)
		var jdn = FrenchRepublicanCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		#expect(smallestJDNForFrenchRepublicanCalendar == jdn)

#if _pointerBitWidth(_64)
		// Values larger than this cause an arithmetic overflow in dateFromJulianDayNumber
		let largestJDNForFrenchRepublicanCalendar: JulianDayNumber = 2305795661307960548
		(Y, M, D) = FrenchRepublicanCalendar.dateFromJulianDayNumber(largestJDNForFrenchRepublicanCalendar)
		jdn = FrenchRepublicanCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		#expect(largestJDNForFrenchRepublicanCalendar == jdn)
#endif
	}
}
