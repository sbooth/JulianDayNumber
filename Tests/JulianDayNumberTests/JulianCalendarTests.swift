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
		XCTAssertTrue(JulianCalendar.isLeapYear(900))
		XCTAssertTrue(JulianCalendar.isLeapYear(1236))
		XCTAssertFalse(JulianCalendar.isLeapYear(750))
		XCTAssertFalse(JulianCalendar.isLeapYear(1429))
	}

	func testMonthCount() {
		XCTAssertEqual(JulianCalendar.monthsInYear, 12)
	}

	func testMonthLength() {
		XCTAssertEqual(JulianCalendar.daysInMonth(year: 1600, month: 2), 29)
		XCTAssertEqual(JulianCalendar.daysInMonth(year: 1700, month: 2), 29)
	}

	func testEaster() {
		// Dates from Meeus (1998)
		XCTAssertTrue(JulianCalendar.easter(year: 179) == (4, 12))
		XCTAssertTrue(JulianCalendar.easter(year: 711) == (4, 12))
		XCTAssertTrue(JulianCalendar.easter(year: 1243) == (4, 12))
	}

	func testJulianDayNumber() {
		XCTAssertEqual(JulianCalendar.dateToJulianDayNumber(year: -999999, month: 1, day: 1), -363528576)
		XCTAssertEqual(JulianCalendar.dateToJulianDayNumber(year: -99999, month: 1, day: 1), -34803576)
		XCTAssertEqual(JulianCalendar.dateToJulianDayNumber(year: -9999, month: 1, day: 1), -1931076)
		XCTAssertEqual(JulianCalendar.dateToJulianDayNumber(year: 9999, month: 12, day: 31), 5373557)
		XCTAssertEqual(JulianCalendar.dateToJulianDayNumber(year: 99999, month: 12, day: 31), 38246057)
		XCTAssertEqual(JulianCalendar.dateToJulianDayNumber(year: 999999, month: 12, day: 31), 366971057)
		XCTAssertEqual(JulianCalendar.dateToJulianDayNumber(year: -4713, month: 12, day: 31), -1)
		XCTAssertEqual(JulianCalendar.dateToJulianDayNumber(year: -4712, month: 1, day: 1), 0)
		XCTAssertEqual(JulianCalendar.dateToJulianDayNumber(year: -4712, month: 1, day: 2), 1)
		XCTAssertEqual(JulianCalendar.dateToJulianDayNumber(year: 1582, month: 10, day: 4), 2299160)
		XCTAssertEqual(JulianCalendar.dateToJulianDayNumber(year: 1582, month: 10, day: 15), 2299171)
		XCTAssertEqual(JulianCalendar.dateToJulianDayNumber(year: 2000, month: 1, day: 1), 2451558)
		XCTAssertEqual(JulianCalendar.dateToJulianDayNumber(year: -5000, month: 1, day: 1), -105192)

		XCTAssertTrue(JulianCalendar.julianDayNumberToDate(-363528576) == (-999999, 1, 1))
		XCTAssertTrue(JulianCalendar.julianDayNumberToDate(-34803576) == (-99999, 1, 1))
		XCTAssertTrue(JulianCalendar.julianDayNumberToDate(-1931076) == (-9999, 1, 1))
		XCTAssertTrue(JulianCalendar.julianDayNumberToDate(5373557) == (9999, 12, 31))
		XCTAssertTrue(JulianCalendar.julianDayNumberToDate(38246057) == (99999, 12, 31))
		XCTAssertTrue(JulianCalendar.julianDayNumberToDate(366971057) == (999999, 12, 31))
		XCTAssertTrue(JulianCalendar.julianDayNumberToDate(-1) == (-4713, 12, 31))
		XCTAssertTrue(JulianCalendar.julianDayNumberToDate(0) == (-4712, 1, 1))
		XCTAssertTrue(JulianCalendar.julianDayNumberToDate(1) == (-4712, 1, 2))
		XCTAssertTrue(JulianCalendar.julianDayNumberToDate(2299160) == (1582, 10, 4))
		XCTAssertTrue(JulianCalendar.julianDayNumberToDate(2299171) == (1582, 10, 15))
		XCTAssertTrue(JulianCalendar.julianDayNumberToDate(2451558) == (2000, 1, 1))
		XCTAssertTrue(JulianCalendar.julianDayNumberToDate(-105192) == (-5000, 1, 1))
	}

	func testLimits() {
		XCTAssertEqual(JulianCalendar.dateToJulianDate(year: -999999, month: 1, day: 1), -363528576.5)
		XCTAssertEqual(JulianCalendar.dateToJulianDate(year: -99999, month: 1, day: 1), -34803576.5)
		XCTAssertEqual(JulianCalendar.dateToJulianDate(year: -9999, month: 1, day: 1), -1931076.5)
		XCTAssertEqual(JulianCalendar.dateToJulianDate(year: 9999, month: 12, day: 31), 5373556.5)
		XCTAssertEqual(JulianCalendar.dateToJulianDate(year: 99999, month: 12, day: 31), 38246056.5)
		XCTAssertEqual(JulianCalendar.dateToJulianDate(year: 999999, month: 12, day: 31), 366971056.5)

		XCTAssertTrue(JulianCalendar.julianDateToDate(-363528576.5) == (-999999, 1, 1, 0, 0, 0))
		XCTAssertTrue(JulianCalendar.julianDateToDate(-34803576.5) == (-99999, 1, 1, 0, 0, 0))
		XCTAssertTrue(JulianCalendar.julianDateToDate(-1931076.5) == (-9999, 1, 1, 0, 0, 0))
		XCTAssertTrue(JulianCalendar.julianDateToDate(5373556.5) == (9999, 12, 31, 0, 0, 0))
		XCTAssertTrue(JulianCalendar.julianDateToDate(38246056.5) == (99999, 12, 31, 0, 0, 0))
		XCTAssertTrue(JulianCalendar.julianDateToDate(366971056.5) == (999999, 12, 31, 0, 0, 0))
	}

	func testArithmeticLimits() {
		var Y, M, D, h, m: Int
		var s: Double

		// Values smaller than this cause an arithmetic overflow in julianDayNumberToDate
		let smallestJDNForJulianCalendar = -9223372036854775664
		(Y, M, D) = JulianCalendar.julianDayNumberToDate(smallestJDNForJulianCalendar)
		var jdn = JulianCalendar.dateToJulianDayNumber(year: Y, month: M, day: D)
		XCTAssertEqual(smallestJDNForJulianCalendar, jdn)

		// Values larger than this cause an arithmetic overflow in julianDayNumberToDate
		let largestJDNForJulianCalendar = 2305843009213692550
		(Y, M, D) = JulianCalendar.julianDayNumberToDate(largestJDNForJulianCalendar)
		jdn = JulianCalendar.dateToJulianDayNumber(year: Y, month: M, day: D)
		XCTAssertEqual(largestJDNForJulianCalendar, jdn)

		// Values smaller than this cause an arithmetic overflow in julianDateToDate
		let smallestJDForJulianCalendar = -0x1.fffffffffffffp+62
		(Y, M, D, h, m, s) = JulianCalendar.julianDateToDate(smallestJDForJulianCalendar)
		var jd = JulianCalendar.dateToJulianDate(year: Y, month: M, day: D, hour: h, minute: m, second: s)
		XCTAssertEqual(smallestJDForJulianCalendar, jd)

		// Values larger than this cause an arithmetic overflow in julianDateToDate
		let largestJDForJulianCalendar = 0x1.ffffffffffffap+60
		(Y, M, D, h, m, s) = JulianCalendar.julianDateToDate(largestJDForJulianCalendar)
		jd = JulianCalendar.dateToJulianDate(year: Y, month: M, day: D, hour: h, minute: m, second: s)
		XCTAssertEqual(largestJDForJulianCalendar, jd)
	}
}
