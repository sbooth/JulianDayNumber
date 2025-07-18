//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import XCTest
@testable import JulianDayNumber

final class SakaCalendarTests: XCTestCase {
	func testDateValidation() {
		XCTAssertTrue(SakaCalendar.isDateValid(year: 1, month: 1, day: 1))
		XCTAssertFalse(SakaCalendar.isDateValid(year: 3, month: 1, day: 31))
		XCTAssertTrue(SakaCalendar.isDateValid(year: 2, month: 1, day: 31))
	}

	func testLeapYear() {
		XCTAssertTrue(SakaCalendar.isLeapYear(78))
		XCTAssertFalse(SakaCalendar.isLeapYear(4))
		XCTAssertFalse(SakaCalendar.isLeapYear(100))
		XCTAssertTrue(SakaCalendar.isLeapYear(750))
		XCTAssertFalse(SakaCalendar.isLeapYear(1429))
		XCTAssertFalse(SakaCalendar.isLeapYear(-3))
		XCTAssertTrue(SakaCalendar.isLeapYear(-78))

		for y in -500...500 {
			let isLeap = SakaCalendar.isLeapYear(y)
			let j = SakaCalendar.julianDayNumberFrom(year: y, month: 1, day: isLeap ? 31 : 30)
			let d = SakaCalendar.dateFromJulianDayNumber(j)
			XCTAssertEqual(d.month, 1)
			XCTAssertEqual(d.day, isLeap ? 31 : 30)
		}
	}

	func testMonthCount() {
		XCTAssertEqual(SakaCalendar.monthsInYear, 12)
	}

	func testMonthLength() {
		XCTAssertEqual(SakaCalendar.daysInMonth(year: 1, month: 1), 30)
		XCTAssertEqual(SakaCalendar.daysInMonth(year: 1, month: 2), 31)
		XCTAssertEqual(SakaCalendar.daysInMonth(year: 1, month: 3), 31)
		XCTAssertEqual(SakaCalendar.daysInMonth(year: 1, month: 4), 31)
		XCTAssertEqual(SakaCalendar.daysInMonth(year: 1, month: 5), 31)
		XCTAssertEqual(SakaCalendar.daysInMonth(year: 1, month: 6), 31)
		XCTAssertEqual(SakaCalendar.daysInMonth(year: 1, month: 7), 30)
		XCTAssertEqual(SakaCalendar.daysInMonth(year: 1, month: 8), 30)
		XCTAssertEqual(SakaCalendar.daysInMonth(year: 1, month: 9), 30)
		XCTAssertEqual(SakaCalendar.daysInMonth(year: 1, month: 10), 30)
		XCTAssertEqual(SakaCalendar.daysInMonth(year: 1, month: 11), 30)
		XCTAssertEqual(SakaCalendar.daysInMonth(year: 1, month: 12), 30)
	}

	func testJulianDayNumber() {
		XCTAssertEqual(SakaCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1), 1749995)
	}

	func testLimits() {
		XCTAssertEqual(SakaCalendar.julianDateFrom(year: -999999, month: 1, day: 1), -363492505.5)
		XCTAssertEqual(SakaCalendar.julianDateFrom(year: -99999, month: 1, day: 1), -34774255.5)
		XCTAssertEqual(SakaCalendar.julianDateFrom(year: -9999, month: 1, day: 1), -1902430.5)
		XCTAssertEqual(SakaCalendar.julianDateFrom(year: 9999, month: 12, day: 30), 5402053.5)
		XCTAssertEqual(SakaCalendar.julianDateFrom(year: 99999, month: 12, day: 30), 38273878.5)
		XCTAssertEqual(SakaCalendar.julianDateFrom(year: 999999, month: 12, day: 30), 366992128.5)

		XCTAssertTrue(SakaCalendar.dateAndTimeFromJulianDate(-363492505.5) == (-999999, 1, 1, 0, 0, 0))
		XCTAssertTrue(SakaCalendar.dateAndTimeFromJulianDate(-34774255.5) == (-99999, 1, 1, 0, 0, 0))
		XCTAssertTrue(SakaCalendar.dateAndTimeFromJulianDate(-1902430.5) == (-9999, 1, 1, 0, 0, 0))
		XCTAssertTrue(SakaCalendar.dateAndTimeFromJulianDate(5402053.5) == (9999, 12, 30, 0, 0, 0))
		XCTAssertTrue(SakaCalendar.dateAndTimeFromJulianDate(38273878.5) == (99999, 12, 30, 0, 0, 0))
		XCTAssertTrue(SakaCalendar.dateAndTimeFromJulianDate(366992128.5) == (999999, 12, 30, 0, 0, 0))
	}

	func testArithmeticLimits() {
		// Values smaller than this cause an arithmetic overflow in dateFromJulianDayNumber
		let smallestJDNForSakaCalendar: JulianDayNumber = .min + 56457
		var (Y, M, D) = SakaCalendar.dateFromJulianDayNumber(smallestJDNForSakaCalendar)
		var jdn = SakaCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		XCTAssertEqual(smallestJDNForSakaCalendar, jdn)

		// Values larger than this cause an arithmetic overflow in dateFromJulianDayNumber
		let largestJDNForSakaCalendar: JulianDayNumber = 2305795661307959298
		(Y, M, D) = SakaCalendar.dateFromJulianDayNumber(largestJDNForSakaCalendar)
		jdn = SakaCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		XCTAssertEqual(largestJDNForSakaCalendar, jdn)
	}
}
