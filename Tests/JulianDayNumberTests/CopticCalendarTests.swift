//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import XCTest
@testable import JulianDayNumber

final class CopticCalendarTests: XCTestCase {
	func testDateValidation() {
		XCTAssertTrue(CopticCalendar.isDateValid(year: 1739, month: 13, day: 6))
		XCTAssertFalse(CopticCalendar.isDateValid(year: 1740, month: 13, day: 6))
	}

	func testLeapYear() {
		XCTAssertTrue(CopticCalendar.isLeapYear(1739))
		XCTAssertFalse(CopticCalendar.isLeapYear(1740))
	}

	func testMonthLength() {
		XCTAssertEqual(CopticCalendar.daysInMonth(year: 1, month: 1), 30)
		XCTAssertEqual(CopticCalendar.daysInMonth(year: 1, month: 2), 30)
		XCTAssertEqual(CopticCalendar.daysInMonth(year: 1, month: 3), 30)
		XCTAssertEqual(CopticCalendar.daysInMonth(year: 1, month: 4), 30)
		XCTAssertEqual(CopticCalendar.daysInMonth(year: 1, month: 5), 30)
		XCTAssertEqual(CopticCalendar.daysInMonth(year: 1, month: 6), 30)
		XCTAssertEqual(CopticCalendar.daysInMonth(year: 1, month: 7), 30)
		XCTAssertEqual(CopticCalendar.daysInMonth(year: 1, month: 8), 30)
		XCTAssertEqual(CopticCalendar.daysInMonth(year: 1, month: 9), 30)
		XCTAssertEqual(CopticCalendar.daysInMonth(year: 1, month: 10), 30)
		XCTAssertEqual(CopticCalendar.daysInMonth(year: 1, month: 11), 30)
		XCTAssertEqual(CopticCalendar.daysInMonth(year: 1, month: 12), 30)
		XCTAssertEqual(CopticCalendar.daysInMonth(year: 1, month: 13), 5)
		XCTAssertEqual(CopticCalendar.daysInMonth(year: 3, month: 13), 6)
	}

	func testJulianDayNumber() {
		XCTAssertEqual(CopticCalendar.dateToJulianDayNumber(year: 1, month: 1, day: 1), 1825030)
		XCTAssertTrue(CopticCalendar.julianDayNumberToDate(1825030) == (1, 1, 1))
	}

	func testLimits() {
		XCTAssertEqual(CopticCalendar.dateToJulianDate(year: -999999, month: 1, day: 1), -363424970.5)
		XCTAssertEqual(CopticCalendar.dateToJulianDate(year: -99999, month: 1, day: 1), -34699970.5)
		XCTAssertEqual(CopticCalendar.dateToJulianDate(year: -9999, month: 1, day: 1), -1827470.5)
		XCTAssertEqual(CopticCalendar.dateToJulianDate(year: 9999, month: 13, day: 5), 5477162.5)
		XCTAssertEqual(CopticCalendar.dateToJulianDate(year: 99999, month: 13, day: 5), 38349662.5)
		XCTAssertEqual(CopticCalendar.dateToJulianDate(year: 999999, month: 13, day: 5), 367074662.5)

		XCTAssertTrue(CopticCalendar.julianDateToDate(-363424970.5) == (-999999, 1, 1, 0, 0, 0))
		XCTAssertTrue(CopticCalendar.julianDateToDate(-34699970.5) == (-99999, 1, 1, 0, 0, 0))
		XCTAssertTrue(CopticCalendar.julianDateToDate(-1827470.5) == (-9999, 1, 1, 0, 0, 0))
		XCTAssertTrue(CopticCalendar.julianDateToDate(5477162.5) == (9999, 13, 5, 0, 0, 0))
		XCTAssertTrue(CopticCalendar.julianDateToDate(38349662.5) == (99999, 13, 5, 0, 0, 0))
		XCTAssertTrue(CopticCalendar.julianDateToDate(367074662.5) == (999999, 13, 5, 0, 0, 0))
	}

	func testArithmeticLimits() {
		var Y, M, D, h, m: Int
		var s: Double

		// Values smaller than this cause an arithmetic overflow in julianDayNumberToDate
		let smallestJDNForCopticCalendar = -9223372036854775664
		(Y, M, D) = CopticCalendar.julianDayNumberToDate(smallestJDNForCopticCalendar)
		var jdn = CopticCalendar.dateToJulianDayNumber(year: Y, month: M, day: D)
		XCTAssertEqual(smallestJDNForCopticCalendar, jdn)

		// Values larger than this cause an arithmetic overflow in julianDayNumberToDate
		let largestJDNForCopticCalendar = 2305843009213693827
		(Y, M, D) = CopticCalendar.julianDayNumberToDate(largestJDNForCopticCalendar)
		jdn = CopticCalendar.dateToJulianDayNumber(year: Y, month: M, day: D)
		XCTAssertEqual(largestJDNForCopticCalendar, jdn)

		// Values smaller than this cause an arithmetic overflow in julianDateToDate
		let smallestJDForCopticCalendar = -0x1.fffffffffffffp+62
		(Y, M, D, h, m, s) = CopticCalendar.julianDateToDate(smallestJDForCopticCalendar)
		var jd = CopticCalendar.dateToJulianDate(year: Y, month: M, day: D, hour: h, minute: m, second: s)
		XCTAssertEqual(smallestJDForCopticCalendar, jd)

		// Values larger than this cause an arithmetic overflow in julianDateToDate
		let largestJDForCopticCalendar = 0x1.fffffffffffffp+60
		(Y, M, D, h, m, s) = CopticCalendar.julianDateToDate(largestJDForCopticCalendar)
		jd = CopticCalendar.dateToJulianDate(year: Y, month: M, day: D, hour: h, minute: m, second: s)
		XCTAssertEqual(largestJDForCopticCalendar, jd)
	}
}
