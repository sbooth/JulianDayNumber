//
// SPDX-FileCopyrightText: 2021 Stephen F. Booth <contact@sbooth.dev>
// SPDX-License-Identifier: MIT
//
// Part of https://github.com/sbooth/JulianDayNumber
//

import Testing
@testable import JulianDayNumber

@Suite struct JulianCalendarTests {
	@Test func epoch() throws {
		#expect(try JulianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == JulianCalendar.epoch)
		#expect(try JulianCalendar.dateFromJulianDayNumber(JulianCalendar.epoch) == (1, 1, 1))
	}

	@Test func dateValidation() {
		#expect(JulianCalendar.isValid(year: 1600, month: 2, day: 29))
		#expect(JulianCalendar.isValid(year: 1700, month: 2, day: 29))
	}

	@Test func leapYear() throws {
		#expect(!JulianCalendar.isLeapYear(1))
		#expect(JulianCalendar.isLeapYear(4))
		#expect(JulianCalendar.isLeapYear(100))
		#expect(!JulianCalendar.isLeapYear(750))
		#expect(JulianCalendar.isLeapYear(900))
		#expect(JulianCalendar.isLeapYear(1236))
		#expect(!JulianCalendar.isLeapYear(1429))
		#expect(JulianCalendar.isLeapYear(1700))
		#expect(!JulianCalendar.isLeapYear(-3))
		#expect(JulianCalendar.isLeapYear(-4))
		#expect(JulianCalendar.isLeapYear(-8))
		#expect(JulianCalendar.isLeapYear(-100))

		for y in -500...1752 {
			let isLeap = JulianCalendar.isLeapYear(y)
			let j = try JulianCalendar.julianDayNumberFrom(year: y, month: 2, day: isLeap ? 29 : 28)
			let d = try JulianCalendar.dateFromJulianDayNumber(j)
			#expect(d.month == 2)
			#expect(d.day == (isLeap ? 29 : 28))
		}
	}

	@Test func monthCount() {
		#expect(JulianCalendar.numberOfMonthsInYear == 12)
	}

	@Test func monthLength() {
		#expect(JulianCalendar.numberOfDaysIn(month: 2, year: 1600) == 29)
		#expect(JulianCalendar.numberOfDaysIn(month: 2, year: 1700) == 29)
	}

	@Test func yearLength() {
		#expect(JulianCalendar.numberOfDays(inYear: 1) == 365)
		#expect(JulianCalendar.numberOfDays(inYear: 4) == 366)
		#expect(JulianCalendar.numberOfDays(inYear: 100) == 366)
		#expect(JulianCalendar.numberOfDays(inYear: 750) == 365)
		#expect(JulianCalendar.numberOfDays(inYear: 900) == 366)
	}

	@Test func ordinalDay() throws {
		#expect(try JulianCalendar.ordinalDayFrom(year: 1901, month: 1, day: 1) == 1)
		#expect(try JulianCalendar.ordinalDayFrom(year: 1901, month: 1, day: 31) == 31)
		#expect(try JulianCalendar.ordinalDayFrom(year: 1901, month: 2, day: 1) == 32)
		#expect(try JulianCalendar.ordinalDayFrom(year: 1901, month: 2, day: 28) == 59)
		#expect(try JulianCalendar.ordinalDayFrom(year: 1901, month: 3, day: 1) == 60)
		#expect(try JulianCalendar.ordinalDayFrom(year: 1901, month: 3, day: 31) == 90)
		#expect(try JulianCalendar.ordinalDayFrom(year: 1901, month: 4, day: 1) == 91)
		#expect(try JulianCalendar.ordinalDayFrom(year: 1901, month: 4, day: 30) == 120)
		#expect(try JulianCalendar.ordinalDayFrom(year: 1901, month: 5, day: 1) == 121)
		#expect(try JulianCalendar.ordinalDayFrom(year: 1901, month: 5, day: 31) == 151)
		#expect(try JulianCalendar.ordinalDayFrom(year: 1901, month: 6, day: 1) == 152)
		#expect(try JulianCalendar.ordinalDayFrom(year: 1901, month: 6, day: 30) == 181)
		#expect(try JulianCalendar.ordinalDayFrom(year: 1901, month: 7, day: 1) == 182)
		#expect(try JulianCalendar.ordinalDayFrom(year: 1901, month: 7, day: 31) == 212)
		#expect(try JulianCalendar.ordinalDayFrom(year: 1901, month: 8, day: 1) == 213)
		#expect(try JulianCalendar.ordinalDayFrom(year: 1901, month: 8, day: 31) == 243)
		#expect(try JulianCalendar.ordinalDayFrom(year: 1901, month: 9, day: 1) == 244)
		#expect(try JulianCalendar.ordinalDayFrom(year: 1901, month: 9, day: 30) == 273)
		#expect(try JulianCalendar.ordinalDayFrom(year: 1901, month: 10, day: 1) == 274)
		#expect(try JulianCalendar.ordinalDayFrom(year: 1901, month: 10, day: 31) == 304)
		#expect(try JulianCalendar.ordinalDayFrom(year: 1901, month: 11, day: 1) == 305)
		#expect(try JulianCalendar.ordinalDayFrom(year: 1901, month: 11, day: 30) == 334)
		#expect(try JulianCalendar.ordinalDayFrom(year: 1901, month: 12, day: 1) == 335)
		#expect(try JulianCalendar.ordinalDayFrom(year: 1901, month: 12, day: 31) == 365)

		#expect(try JulianCalendar.dateFrom(year: 1901, ordinalDay: 1) == (1901, 1, 1))
		#expect(try JulianCalendar.dateFrom(year: 1901, ordinalDay: 31) == (1901, 1, 31))
		#expect(try JulianCalendar.dateFrom(year: 1901, ordinalDay: 32) == (1901, 2, 1))
		#expect(try JulianCalendar.dateFrom(year: 1901, ordinalDay: 59) == (1901, 2, 28))
		#expect(try JulianCalendar.dateFrom(year: 1901, ordinalDay: 60) == (1901, 3, 1))
		#expect(try JulianCalendar.dateFrom(year: 1901, ordinalDay: 90) == (1901, 3, 31))
		#expect(try JulianCalendar.dateFrom(year: 1901, ordinalDay: 91) == (1901, 4, 1))
		#expect(try JulianCalendar.dateFrom(year: 1901, ordinalDay: 120) == (1901, 4, 30))
		#expect(try JulianCalendar.dateFrom(year: 1901, ordinalDay: 121) == (1901, 5, 1))
		#expect(try JulianCalendar.dateFrom(year: 1901, ordinalDay: 151) == (1901, 5, 31))
		#expect(try JulianCalendar.dateFrom(year: 1901, ordinalDay: 152) == (1901, 6, 1))
		#expect(try JulianCalendar.dateFrom(year: 1901, ordinalDay: 181) == (1901, 6, 30))
		#expect(try JulianCalendar.dateFrom(year: 1901, ordinalDay: 182) == (1901, 7, 1))
		#expect(try JulianCalendar.dateFrom(year: 1901, ordinalDay: 212) == (1901, 7, 31))
		#expect(try JulianCalendar.dateFrom(year: 1901, ordinalDay: 213) == (1901, 8, 1))
		#expect(try JulianCalendar.dateFrom(year: 1901, ordinalDay: 243) == (1901, 8, 31))
		#expect(try JulianCalendar.dateFrom(year: 1901, ordinalDay: 244) == (1901, 9, 1))
		#expect(try JulianCalendar.dateFrom(year: 1901, ordinalDay: 273) == (1901, 9, 30))
		#expect(try JulianCalendar.dateFrom(year: 1901, ordinalDay: 274) == (1901, 10, 1))
		#expect(try JulianCalendar.dateFrom(year: 1901, ordinalDay: 304) == (1901, 10, 31))
		#expect(try JulianCalendar.dateFrom(year: 1901, ordinalDay: 305) == (1901, 11, 1))
		#expect(try JulianCalendar.dateFrom(year: 1901, ordinalDay: 334) == (1901, 11, 30))
		#expect(try JulianCalendar.dateFrom(year: 1901, ordinalDay: 335) == (1901, 12, 1))
		#expect(try JulianCalendar.dateFrom(year: 1901, ordinalDay: 365) == (1901, 12, 31))

		#expect(try JulianCalendar.ordinalDayFrom(year: 2000, month: 1, day: 1) == 1)
		#expect(try JulianCalendar.ordinalDayFrom(year: 2000, month: 1, day: 31) == 31)
		#expect(try JulianCalendar.ordinalDayFrom(year: 2000, month: 2, day: 1) == 32)
		#expect(try JulianCalendar.ordinalDayFrom(year: 2000, month: 2, day: 29) == 60)
		#expect(try JulianCalendar.ordinalDayFrom(year: 2000, month: 3, day: 1) == 61)
		#expect(try JulianCalendar.ordinalDayFrom(year: 2000, month: 3, day: 31) == 91)
		#expect(try JulianCalendar.ordinalDayFrom(year: 2000, month: 4, day: 1) == 92)
		#expect(try JulianCalendar.ordinalDayFrom(year: 2000, month: 4, day: 30) == 121)
		#expect(try JulianCalendar.ordinalDayFrom(year: 2000, month: 5, day: 1) == 122)
		#expect(try JulianCalendar.ordinalDayFrom(year: 2000, month: 5, day: 31) == 152)
		#expect(try JulianCalendar.ordinalDayFrom(year: 2000, month: 6, day: 1) == 153)
		#expect(try JulianCalendar.ordinalDayFrom(year: 2000, month: 6, day: 30) == 182)
		#expect(try JulianCalendar.ordinalDayFrom(year: 2000, month: 7, day: 1) == 183)
		#expect(try JulianCalendar.ordinalDayFrom(year: 2000, month: 7, day: 31) == 213)
		#expect(try JulianCalendar.ordinalDayFrom(year: 2000, month: 8, day: 1) == 214)
		#expect(try JulianCalendar.ordinalDayFrom(year: 2000, month: 8, day: 31) == 244)
		#expect(try JulianCalendar.ordinalDayFrom(year: 2000, month: 9, day: 1) == 245)
		#expect(try JulianCalendar.ordinalDayFrom(year: 2000, month: 9, day: 30) == 274)
		#expect(try JulianCalendar.ordinalDayFrom(year: 2000, month: 10, day: 1) == 275)
		#expect(try JulianCalendar.ordinalDayFrom(year: 2000, month: 10, day: 31) == 305)
		#expect(try JulianCalendar.ordinalDayFrom(year: 2000, month: 11, day: 1) == 306)
		#expect(try JulianCalendar.ordinalDayFrom(year: 2000, month: 11, day: 30) == 335)
		#expect(try JulianCalendar.ordinalDayFrom(year: 2000, month: 12, day: 1) == 336)
		#expect(try JulianCalendar.ordinalDayFrom(year: 2000, month: 12, day: 31) == 366)

		#expect(try JulianCalendar.dateFrom(year: 2000, ordinalDay: 1) == (2000, 1, 1))
		#expect(try JulianCalendar.dateFrom(year: 2000, ordinalDay: 31) == (2000, 1, 31))
		#expect(try JulianCalendar.dateFrom(year: 2000, ordinalDay: 32) == (2000, 2, 1))
		#expect(try JulianCalendar.dateFrom(year: 2000, ordinalDay: 60) == (2000, 2, 29))
		#expect(try JulianCalendar.dateFrom(year: 2000, ordinalDay: 61) == (2000, 3, 1))
		#expect(try JulianCalendar.dateFrom(year: 2000, ordinalDay: 91) == (2000, 3, 31))
		#expect(try JulianCalendar.dateFrom(year: 2000, ordinalDay: 92) == (2000, 4, 1))
		#expect(try JulianCalendar.dateFrom(year: 2000, ordinalDay: 121) == (2000, 4, 30))
		#expect(try JulianCalendar.dateFrom(year: 2000, ordinalDay: 122) == (2000, 5, 1))
		#expect(try JulianCalendar.dateFrom(year: 2000, ordinalDay: 152) == (2000, 5, 31))
		#expect(try JulianCalendar.dateFrom(year: 2000, ordinalDay: 153) == (2000, 6, 1))
		#expect(try JulianCalendar.dateFrom(year: 2000, ordinalDay: 182) == (2000, 6, 30))
		#expect(try JulianCalendar.dateFrom(year: 2000, ordinalDay: 183) == (2000, 7, 1))
		#expect(try JulianCalendar.dateFrom(year: 2000, ordinalDay: 213) == (2000, 7, 31))
		#expect(try JulianCalendar.dateFrom(year: 2000, ordinalDay: 214) == (2000, 8, 1))
		#expect(try JulianCalendar.dateFrom(year: 2000, ordinalDay: 244) == (2000, 8, 31))
		#expect(try JulianCalendar.dateFrom(year: 2000, ordinalDay: 245) == (2000, 9, 1))
		#expect(try JulianCalendar.dateFrom(year: 2000, ordinalDay: 274) == (2000, 9, 30))
		#expect(try JulianCalendar.dateFrom(year: 2000, ordinalDay: 275) == (2000, 10, 1))
		#expect(try JulianCalendar.dateFrom(year: 2000, ordinalDay: 305) == (2000, 10, 31))
		#expect(try JulianCalendar.dateFrom(year: 2000, ordinalDay: 306) == (2000, 11, 1))
		#expect(try JulianCalendar.dateFrom(year: 2000, ordinalDay: 335) == (2000, 11, 30))
		#expect(try JulianCalendar.dateFrom(year: 2000, ordinalDay: 336) == (2000, 12, 1))
		#expect(try JulianCalendar.dateFrom(year: 2000, ordinalDay: 366) == (2000, 12, 31))
	}

	@Test func dayOfWeek() throws {
		#expect(JulianCalendar.dayOfWeek(JulianCalendar.epoch) == 7)
		#expect(JulianCalendar.dayOfWeek(-9) == 7)
		#expect(JulianCalendar.dayOfWeek(-8) == 1)
		#expect(JulianCalendar.dayOfWeek(-7) == 2)
		#expect(JulianCalendar.dayOfWeek(-6) == 3)
		#expect(JulianCalendar.dayOfWeek(-5) == 4)
		#expect(JulianCalendar.dayOfWeek(-4) == 5)
		#expect(JulianCalendar.dayOfWeek(-3) == 6)
		#expect(JulianCalendar.dayOfWeek(-2) == 7)
		#expect(JulianCalendar.dayOfWeek(-1) == 1)
		#expect(JulianCalendar.dayOfWeek(0) == 2)
		#expect(JulianCalendar.dayOfWeek(1) == 3)
		#expect(JulianCalendar.dayOfWeek(2) == 4)
		#expect(JulianCalendar.dayOfWeek(3) == 5)
		#expect(JulianCalendar.dayOfWeek(4) == 6)
		#expect(JulianCalendar.dayOfWeek(5) == 7)
		#expect(JulianCalendar.dayOfWeek(6) == 1)

		#expect(try JulianCalendar.dayOfWeek(JulianCalendar.julianDayNumberFromDate((-10028, 3, 1))) == JulianCalendar.dayOfWeek(JulianCalendar.julianDayNumberFromDate((-10000, 3, 1))))
	}

	@Test func easter() {
		// Dates from Meeus (1998)
		#expect(JulianCalendar.easter(year: 179) == (4, 12))
		#expect(JulianCalendar.easter(year: 711) == (4, 12))
		#expect(JulianCalendar.easter(year: 1243) == (4, 12))
	}

	@Test func julianDayNumber() throws {
		#expect(try JulianCalendar.julianDayNumberFrom(year: -999999, month: 1, day: 1) == -363528576)
		#expect(try JulianCalendar.julianDayNumberFrom(year: -99999, month: 1, day: 1) == -34803576)
		#expect(try JulianCalendar.julianDayNumberFrom(year: -9999, month: 1, day: 1) == -1931076)
		#expect(try JulianCalendar.julianDayNumberFrom(year: 9999, month: 12, day: 31) == 5373557)
		#expect(try JulianCalendar.julianDayNumberFrom(year: 99999, month: 12, day: 31) == 38246057)
		#expect(try JulianCalendar.julianDayNumberFrom(year: 999999, month: 12, day: 31) == 366971057)
		#expect(try JulianCalendar.julianDayNumberFrom(year: -4713, month: 12, day: 31) == -1)
		#expect(try JulianCalendar.julianDayNumberFrom(year: -4712, month: 1, day: 1) == 0)
		#expect(try JulianCalendar.julianDayNumberFrom(year: -4712, month: 1, day: 2) == 1)
		#expect(try JulianCalendar.julianDayNumberFrom(year: 1582, month: 10, day: 4) == 2299160)
		#expect(try JulianCalendar.julianDayNumberFrom(year: 1582, month: 10, day: 15) == 2299171)
		#expect(try JulianCalendar.julianDayNumberFrom(year: 2000, month: 1, day: 1) == 2451558)
		#expect(try JulianCalendar.julianDayNumberFrom(year: -5000, month: 1, day: 1) == -105192)

		#expect(try JulianCalendar.dateFromJulianDayNumber(-363528576) == (-999999, 1, 1))
		#expect(try JulianCalendar.dateFromJulianDayNumber(-34803576) == (-99999, 1, 1))
		#expect(try JulianCalendar.dateFromJulianDayNumber(-1931076) == (-9999, 1, 1))
		#expect(try JulianCalendar.dateFromJulianDayNumber(5373557) == (9999, 12, 31))
		#expect(try JulianCalendar.dateFromJulianDayNumber(38246057) == (99999, 12, 31))
		#expect(try JulianCalendar.dateFromJulianDayNumber(366971057) == (999999, 12, 31))
		#expect(try JulianCalendar.dateFromJulianDayNumber(-1) == (-4713, 12, 31))
		#expect(try JulianCalendar.dateFromJulianDayNumber(0) == (-4712, 1, 1))
		#expect(try JulianCalendar.dateFromJulianDayNumber(1) == (-4712, 1, 2))
		#expect(try JulianCalendar.dateFromJulianDayNumber(2299160) == (1582, 10, 4))
		#expect(try JulianCalendar.dateFromJulianDayNumber(2299171) == (1582, 10, 15))
		#expect(try JulianCalendar.dateFromJulianDayNumber(2451558) == (2000, 1, 1))
		#expect(try JulianCalendar.dateFromJulianDayNumber(-105192) == (-5000, 1, 1))
	}

	@Test func limits() throws {
		#expect(try JulianCalendar.julianDateFrom(year: -999999, month: 1, day: 1) == -363528576.5)
		#expect(try JulianCalendar.julianDateFrom(year: -99999, month: 1, day: 1) == -34803576.5)
		#expect(try JulianCalendar.julianDateFrom(year: -9999, month: 1, day: 1) == -1931076.5)
		#expect(try JulianCalendar.julianDateFrom(year: 9999, month: 12, day: 31) == 5373556.5)
		#expect(try JulianCalendar.julianDateFrom(year: 99999, month: 12, day: 31) == 38246056.5)
		#expect(try JulianCalendar.julianDateFrom(year: 999999, month: 12, day: 31) == 366971056.5)

		#expect(try JulianCalendar.dateAndTimeFromJulianDate(-363528576.5) == (-999999, 1, 1, 0, 0, 0))
		#expect(try JulianCalendar.dateAndTimeFromJulianDate(-34803576.5) == (-99999, 1, 1, 0, 0, 0))
		#expect(try JulianCalendar.dateAndTimeFromJulianDate(-1931076.5) == (-9999, 1, 1, 0, 0, 0))
		#expect(try JulianCalendar.dateAndTimeFromJulianDate(5373556.5) == (9999, 12, 31, 0, 0, 0))
		#expect(try JulianCalendar.dateAndTimeFromJulianDate(38246056.5) == (99999, 12, 31, 0, 0, 0))
		#expect(try JulianCalendar.dateAndTimeFromJulianDate(366971056.5) == (999999, 12, 31, 0, 0, 0))
	}

	@Test func arithmeticLimits() throws {
		let minDate = try JulianCalendar.dateFromJulianDayNumber(.min)
		let minJ = try JulianCalendar.julianDayNumberFromDate(minDate)
		#expect(minJ == .min)

		let maxDate = try JulianCalendar.dateFromJulianDayNumber(.max)
		let maxJ = try JulianCalendar.julianDayNumberFromDate(maxDate)
		#expect(maxJ == .max)

		_ = JulianCalendar.isLeapYear(.min)
		_ = JulianCalendar.isLeapYear(.max)

		_ = JulianCalendar.dayOfWeek(.min)
		_ = JulianCalendar.dayOfWeek(.max)
	}
}
