//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Testing
@testable import JulianDayNumber

@Suite struct MacedonianCalendarTests {
	@Test func epoch() {
		#expect(MacedonianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == MacedonianCalendar.epoch)
		#expect(MacedonianCalendar.dateFromJulianDayNumber(MacedonianCalendar.epoch) == (1, 1, 1))
	}

	@Test func julianDayNumber() {
		#expect(MacedonianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == 1607709)
		#expect(MacedonianCalendar.dateFromJulianDayNumber(1607709) == (1, 1, 1))
	}

	@Test func leapYear() {
		#expect(!MacedonianCalendar.isLeapYear(1))
		#expect(MacedonianCalendar.isLeapYear(3))
		#expect(MacedonianCalendar.isLeapYear(7))
		#expect(MacedonianCalendar.isLeapYear(1739))
		#expect(!MacedonianCalendar.isLeapYear(1740))
		#expect(MacedonianCalendar.isLeapYear(-1))
		#expect(!MacedonianCalendar.isLeapYear(-2))

		for y in -500...500 {
			let isLeap = MacedonianCalendar.isLeapYear(y)
			let j = MacedonianCalendar.julianDayNumberFrom(year: y, month: 6, day: isLeap ? 29 : 28)
			let d = MacedonianCalendar.dateFromJulianDayNumber(j)
			#expect(d.month == 6)
			#expect(d.day == (isLeap ? 29 : 28))
		}
	}

	@Test func monthCount() {
		#expect(MacedonianCalendar.numberOfMonthsInYear == 12)
	}

	@Test func monthLength() {
		#expect(MacedonianCalendar.numberOfDaysIn(month: 1, year: 1) == 30)
		#expect(MacedonianCalendar.numberOfDaysIn(month: 2, year: 1) == 31)
		#expect(MacedonianCalendar.numberOfDaysIn(month: 3, year: 1) == 30)
		#expect(MacedonianCalendar.numberOfDaysIn(month: 4, year: 1) == 31)
		#expect(MacedonianCalendar.numberOfDaysIn(month: 5, year: 1) == 31)
		#expect(MacedonianCalendar.numberOfDaysIn(month: 7, year: 1) == 31)
		#expect(MacedonianCalendar.numberOfDaysIn(month: 8, year: 1) == 30)
		#expect(MacedonianCalendar.numberOfDaysIn(month: 9, year: 1) == 31)
		#expect(MacedonianCalendar.numberOfDaysIn(month: 10, year: 1) == 30)
		#expect(MacedonianCalendar.numberOfDaysIn(month: 11, year: 1) == 31)
		#expect(MacedonianCalendar.numberOfDaysIn(month: 12, year: 1) == 31)

		#expect(MacedonianCalendar.numberOfDaysIn(month: 6, year: 1) == 28)
		#expect(MacedonianCalendar.numberOfDaysIn(month: 6, year: 3) == 29)
	}

	@Test func yearLength() {
		#expect(MacedonianCalendar.numberOfDays(inYear: 1) == 365)
		#expect(MacedonianCalendar.numberOfDays(inYear: 3) == 366)
		#expect(MacedonianCalendar.numberOfDays(inYear: 7) == 366)
		#expect(MacedonianCalendar.numberOfDays(inYear: 8) == 365)
		#expect(MacedonianCalendar.numberOfDays(inYear: 1739) == 366)
	}

	@Test func limits() {
		#expect(MacedonianCalendar.julianDateFrom(year: -999999, month: 1, day: 1) == -363642291.5)
		#expect(MacedonianCalendar.julianDateFrom(year: -99999, month: 1, day: 1) == -34917291.5)
		#expect(MacedonianCalendar.julianDateFrom(year: -9999, month: 1, day: 1) == -2044791.5)
		#expect(MacedonianCalendar.julianDateFrom(year: 9999, month: 12, day: 31) == 5259842.5)
		#expect(MacedonianCalendar.julianDateFrom(year: 99999, month: 12, day: 31) == 38132342.5)
		#expect(MacedonianCalendar.julianDateFrom(year: 999999, month: 12, day: 31) == 366857342.5)

		#expect(MacedonianCalendar.dateAndTimeFromJulianDate(-363642291.5) == (-999999, 1, 1, 0, 0, 0))
		#expect(MacedonianCalendar.dateAndTimeFromJulianDate(-34917291.5) == (-99999, 1, 1, 0, 0, 0))
		#expect(MacedonianCalendar.dateAndTimeFromJulianDate(-2044791.5) == (-9999, 1, 1, 0, 0, 0))
		#expect(MacedonianCalendar.dateAndTimeFromJulianDate(5259842.5) == (9999, 12, 31, 0, 0, 0))
		#expect(MacedonianCalendar.dateAndTimeFromJulianDate(38132342.5) == (99999, 12, 31, 0, 0, 0))
		#expect(MacedonianCalendar.dateAndTimeFromJulianDate(366857342.5) == (999999, 12, 31, 0, 0, 0))
	}

	@Test func arithmeticLimits() {
		// Values smaller than this cause an arithmetic overflow in dateFromJulianDayNumber
		let smallestJDNForMacedonianCalendar: JulianDayNumber = .min + 144
		var (Y, M, D) = MacedonianCalendar.dateFromJulianDayNumber(smallestJDNForMacedonianCalendar)
		var jdn = MacedonianCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		#expect(smallestJDNForMacedonianCalendar == jdn)

		// Values larger than this cause an arithmetic overflow in dateFromJulianDayNumber
		let largestJDNForMacedonianCalendar: JulianDayNumber = (.max - MacedonianCalendar.converter.v) / MacedonianCalendar.converter.r - MacedonianCalendar.converter.j
		(Y, M, D) = MacedonianCalendar.dateFromJulianDayNumber(largestJDNForMacedonianCalendar)
		jdn = MacedonianCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		#expect(largestJDNForMacedonianCalendar == jdn)
	}
}
