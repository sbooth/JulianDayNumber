//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import XCTest
@testable import JulianDayNumber

final class JulianCalendarTests: XCTestCase {
	func testDateValidation() {
		XCTAssertTrue(JulianCalendar.isDateValid(year: 1600, month: 2, day: 29))
		XCTAssertTrue(JulianCalendar.isDateValid(year: 1700, month: 2, day: 29))
	}

	func testLeapYear() {
		XCTAssertFalse(JulianCalendar.isLeapYear(1))
		XCTAssertTrue(JulianCalendar.isLeapYear(4))
		XCTAssertTrue(JulianCalendar.isLeapYear(100))
		XCTAssertFalse(JulianCalendar.isLeapYear(750))
		XCTAssertTrue(JulianCalendar.isLeapYear(900))
		XCTAssertTrue(JulianCalendar.isLeapYear(1236))
		XCTAssertFalse(JulianCalendar.isLeapYear(1429))
		XCTAssertFalse(JulianCalendar.isLeapYear(-3))
		XCTAssertTrue(JulianCalendar.isLeapYear(-4))
		XCTAssertTrue(JulianCalendar.isLeapYear(-8))
		XCTAssertTrue(JulianCalendar.isLeapYear(-100))

		for y in -500...1752 {
			let isLeap = JulianCalendar.isLeapYear(y)
			let j = JulianCalendar.julianDayNumberFrom(year: y, month: 2, day: isLeap ? 29 : 28)
			let d = JulianCalendar.dateFromJulianDayNumber(j)
			XCTAssertEqual(d.month, 2)
			XCTAssertEqual(d.day, isLeap ? 29 : 28)
		}
	}

	func testMonthCount() {
		XCTAssertEqual(JulianCalendar.monthsInYear, 12)
	}

	func testMonthLength() {
		XCTAssertEqual(JulianCalendar.daysInMonth(year: 1600, month: 2), 29)
		XCTAssertEqual(JulianCalendar.daysInMonth(year: 1700, month: 2), 29)
	}

	func testDayOfYear() {
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 1901, month: 1, day: 1), 1)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 1901, month: 1, day: 31), 31)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 1901, month: 2, day: 1), 32)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 1901, month: 2, day: 28), 59)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 1901, month: 3, day: 1), 60)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 1901, month: 3, day: 31), 90)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 1901, month: 4, day: 1), 91)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 1901, month: 4, day: 30), 120)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 1901, month: 5, day: 1), 121)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 1901, month: 5, day: 31), 151)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 1901, month: 6, day: 1), 152)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 1901, month: 6, day: 30), 181)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 1901, month: 7, day: 1), 182)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 1901, month: 7, day: 31), 212)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 1901, month: 8, day: 1), 213)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 1901, month: 8, day: 31), 243)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 1901, month: 9, day: 1), 244)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 1901, month: 9, day: 30), 273)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 1901, month: 10, day: 1), 274)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 1901, month: 10, day: 31), 304)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 1901, month: 11, day: 1), 305)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 1901, month: 11, day: 30), 334)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 1901, month: 12, day: 1), 335)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 1901, month: 12, day: 31), 365)

		XCTAssertEqual(JulianCalendar.dayOfYear(year: 2000, month: 1, day: 1), 1)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 2000, month: 1, day: 31), 31)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 2000, month: 2, day: 1), 32)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 2000, month: 2, day: 29), 60)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 2000, month: 3, day: 1), 61)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 2000, month: 3, day: 31), 91)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 2000, month: 4, day: 1), 92)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 2000, month: 4, day: 30), 121)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 2000, month: 5, day: 1), 122)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 2000, month: 5, day: 31), 152)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 2000, month: 6, day: 1), 153)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 2000, month: 6, day: 30), 182)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 2000, month: 7, day: 1), 183)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 2000, month: 7, day: 31), 213)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 2000, month: 8, day: 1), 214)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 2000, month: 8, day: 31), 244)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 2000, month: 9, day: 1), 245)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 2000, month: 9, day: 30), 274)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 2000, month: 10, day: 1), 275)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 2000, month: 10, day: 31), 305)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 2000, month: 11, day: 1), 306)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 2000, month: 11, day: 30), 335)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 2000, month: 12, day: 1), 336)
		XCTAssertEqual(JulianCalendar.dayOfYear(year: 2000, month: 12, day: 31), 366)
	}

	func testEaster() {
		// Dates from Meeus (1998)
		XCTAssertTrue(JulianCalendar.easter(year: 179) == (4, 12))
		XCTAssertTrue(JulianCalendar.easter(year: 711) == (4, 12))
		XCTAssertTrue(JulianCalendar.easter(year: 1243) == (4, 12))
	}

	func testJulianDayNumber() {
		XCTAssertEqual(JulianCalendar.julianDayNumberFrom(year: -999999, month: 1, day: 1), -363528576)
		XCTAssertEqual(JulianCalendar.julianDayNumberFrom(year: -99999, month: 1, day: 1), -34803576)
		XCTAssertEqual(JulianCalendar.julianDayNumberFrom(year: -9999, month: 1, day: 1), -1931076)
		XCTAssertEqual(JulianCalendar.julianDayNumberFrom(year: 9999, month: 12, day: 31), 5373557)
		XCTAssertEqual(JulianCalendar.julianDayNumberFrom(year: 99999, month: 12, day: 31), 38246057)
		XCTAssertEqual(JulianCalendar.julianDayNumberFrom(year: 999999, month: 12, day: 31), 366971057)
		XCTAssertEqual(JulianCalendar.julianDayNumberFrom(year: -4713, month: 12, day: 31), -1)
		XCTAssertEqual(JulianCalendar.julianDayNumberFrom(year: -4712, month: 1, day: 1), 0)
		XCTAssertEqual(JulianCalendar.julianDayNumberFrom(year: -4712, month: 1, day: 2), 1)
		XCTAssertEqual(JulianCalendar.julianDayNumberFrom(year: 1582, month: 10, day: 4), 2299160)
		XCTAssertEqual(JulianCalendar.julianDayNumberFrom(year: 1582, month: 10, day: 15), 2299171)
		XCTAssertEqual(JulianCalendar.julianDayNumberFrom(year: 2000, month: 1, day: 1), 2451558)
		XCTAssertEqual(JulianCalendar.julianDayNumberFrom(year: -5000, month: 1, day: 1), -105192)

		XCTAssertTrue(JulianCalendar.dateFromJulianDayNumber(-363528576) == (-999999, 1, 1))
		XCTAssertTrue(JulianCalendar.dateFromJulianDayNumber(-34803576) == (-99999, 1, 1))
		XCTAssertTrue(JulianCalendar.dateFromJulianDayNumber(-1931076) == (-9999, 1, 1))
		XCTAssertTrue(JulianCalendar.dateFromJulianDayNumber(5373557) == (9999, 12, 31))
		XCTAssertTrue(JulianCalendar.dateFromJulianDayNumber(38246057) == (99999, 12, 31))
		XCTAssertTrue(JulianCalendar.dateFromJulianDayNumber(366971057) == (999999, 12, 31))
		XCTAssertTrue(JulianCalendar.dateFromJulianDayNumber(-1) == (-4713, 12, 31))
		XCTAssertTrue(JulianCalendar.dateFromJulianDayNumber(0) == (-4712, 1, 1))
		XCTAssertTrue(JulianCalendar.dateFromJulianDayNumber(1) == (-4712, 1, 2))
		XCTAssertTrue(JulianCalendar.dateFromJulianDayNumber(2299160) == (1582, 10, 4))
		XCTAssertTrue(JulianCalendar.dateFromJulianDayNumber(2299171) == (1582, 10, 15))
		XCTAssertTrue(JulianCalendar.dateFromJulianDayNumber(2451558) == (2000, 1, 1))
		XCTAssertTrue(JulianCalendar.dateFromJulianDayNumber(-105192) == (-5000, 1, 1))
	}

	func testLimits() {
		XCTAssertEqual(JulianCalendar.julianDateFrom(year: -999999, month: 1, day: 1), -363528576.5)
		XCTAssertEqual(JulianCalendar.julianDateFrom(year: -99999, month: 1, day: 1), -34803576.5)
		XCTAssertEqual(JulianCalendar.julianDateFrom(year: -9999, month: 1, day: 1), -1931076.5)
		XCTAssertEqual(JulianCalendar.julianDateFrom(year: 9999, month: 12, day: 31), 5373556.5)
		XCTAssertEqual(JulianCalendar.julianDateFrom(year: 99999, month: 12, day: 31), 38246056.5)
		XCTAssertEqual(JulianCalendar.julianDateFrom(year: 999999, month: 12, day: 31), 366971056.5)

		XCTAssertTrue(JulianCalendar.dateAndTimeFromJulianDate(-363528576.5) == (-999999, 1, 1, 0, 0, 0))
		XCTAssertTrue(JulianCalendar.dateAndTimeFromJulianDate(-34803576.5) == (-99999, 1, 1, 0, 0, 0))
		XCTAssertTrue(JulianCalendar.dateAndTimeFromJulianDate(-1931076.5) == (-9999, 1, 1, 0, 0, 0))
		XCTAssertTrue(JulianCalendar.dateAndTimeFromJulianDate(5373556.5) == (9999, 12, 31, 0, 0, 0))
		XCTAssertTrue(JulianCalendar.dateAndTimeFromJulianDate(38246056.5) == (99999, 12, 31, 0, 0, 0))
		XCTAssertTrue(JulianCalendar.dateAndTimeFromJulianDate(366971056.5) == (999999, 12, 31, 0, 0, 0))
	}

	func testArithmeticLimits() {
		// Values smaller than this cause an arithmetic overflow in dateFromJulianDayNumber
		let smallestJDNForJulianCalendar = Int.min + 144
		var (Y, M, D) = JulianCalendar.dateFromJulianDayNumber(smallestJDNForJulianCalendar)
		var jdn = JulianCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		XCTAssertEqual(smallestJDNForJulianCalendar, jdn)

		// Values larger than this cause an arithmetic overflow in dateFromJulianDayNumber
		let largestJDNForJulianCalendar = (Int.max - 3) / 4 - 1401
		(Y, M, D) = JulianCalendar.dateFromJulianDayNumber(largestJDNForJulianCalendar)
		jdn = JulianCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		XCTAssertEqual(largestJDNForJulianCalendar, jdn)
	}
}
