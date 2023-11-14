//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import XCTest
@testable import JulianDayNumber

final class IndianCalendarTests: XCTestCase {
	func testDateValidation() {
		XCTAssertTrue(IndianCalendar.isDateValid(year: 1, month: 1, day: 1))
		XCTAssertFalse(IndianCalendar.isDateValid(year: 3, month: 1, day: 31))
		XCTAssertTrue(IndianCalendar.isDateValid(year: 2, month: 1, day: 31))
	}

	func testLeapYear() {
		XCTAssertTrue(IndianCalendar.isLeapYear(78))
		XCTAssertFalse(IndianCalendar.isLeapYear(4))
		XCTAssertFalse(IndianCalendar.isLeapYear(100))
		XCTAssertTrue(IndianCalendar.isLeapYear(750))
		XCTAssertFalse(IndianCalendar.isLeapYear(1429))
		XCTAssertFalse(IndianCalendar.isLeapYear(-3))
		XCTAssertTrue(IndianCalendar.isLeapYear(-78))

		for y in -500...500 {
			let isLeap = IndianCalendar.isLeapYear(y)
			let j = IndianCalendar.julianDayNumberFrom(year: y, month: 1, day: isLeap ? 31 : 30)
			let d = IndianCalendar.dateFromJulianDayNumber(j)
			XCTAssertEqual(d.month, 1)
			XCTAssertEqual(d.day, isLeap ? 31 : 30)
		}
	}

	func testMonthCount() {
		XCTAssertEqual(IndianCalendar.monthsInYear, 12)
	}

	func testMonthLength() {
		XCTAssertEqual(IndianCalendar.daysInMonth(year: 1, month: 1), 30)
		XCTAssertEqual(IndianCalendar.daysInMonth(year: 1, month: 2), 31)
		XCTAssertEqual(IndianCalendar.daysInMonth(year: 1, month: 3), 31)
		XCTAssertEqual(IndianCalendar.daysInMonth(year: 1, month: 4), 31)
		XCTAssertEqual(IndianCalendar.daysInMonth(year: 1, month: 5), 31)
		XCTAssertEqual(IndianCalendar.daysInMonth(year: 1, month: 6), 31)
		XCTAssertEqual(IndianCalendar.daysInMonth(year: 1, month: 7), 30)
		XCTAssertEqual(IndianCalendar.daysInMonth(year: 1, month: 8), 30)
		XCTAssertEqual(IndianCalendar.daysInMonth(year: 1, month: 9), 30)
		XCTAssertEqual(IndianCalendar.daysInMonth(year: 1, month: 10), 30)
		XCTAssertEqual(IndianCalendar.daysInMonth(year: 1, month: 11), 30)
		XCTAssertEqual(IndianCalendar.daysInMonth(year: 1, month: 12), 30)
	}

	func testJulianDayNumber() {
		XCTAssertEqual(IndianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1), 1749995)
	}

	func testLimits() {
		XCTAssertEqual(IndianCalendar.julianDateFrom(year: -999999, month: 1, day: 1), -363492505.5)
		XCTAssertEqual(IndianCalendar.julianDateFrom(year: -99999, month: 1, day: 1), -34774255.5)
		XCTAssertEqual(IndianCalendar.julianDateFrom(year: -9999, month: 1, day: 1), -1902430.5)
		XCTAssertEqual(IndianCalendar.julianDateFrom(year: 9999, month: 12, day: 30), 5402053.5)
		XCTAssertEqual(IndianCalendar.julianDateFrom(year: 99999, month: 12, day: 30), 38273878.5)
		XCTAssertEqual(IndianCalendar.julianDateFrom(year: 999999, month: 12, day: 30), 366992128.5)

		XCTAssertTrue(IndianCalendar.dateAndTimeFromJulianDate(-363492505.5) == (-999999, 1, 1, 0, 0, 0))
		XCTAssertTrue(IndianCalendar.dateAndTimeFromJulianDate(-34774255.5) == (-99999, 1, 1, 0, 0, 0))
		XCTAssertTrue(IndianCalendar.dateAndTimeFromJulianDate(-1902430.5) == (-9999, 1, 1, 0, 0, 0))
		XCTAssertTrue(IndianCalendar.dateAndTimeFromJulianDate(5402053.5) == (9999, 12, 30, 0, 0, 0))
		XCTAssertTrue(IndianCalendar.dateAndTimeFromJulianDate(38273878.5) == (99999, 12, 30, 0, 0, 0))
		XCTAssertTrue(IndianCalendar.dateAndTimeFromJulianDate(366992128.5) == (999999, 12, 30, 0, 0, 0))
	}

	func testArithmeticLimits() {
		var Y, M, D, h, m: Int
		var s: Double

		// Values smaller than this cause an arithmetic overflow in dateFromJulianDayNumber
		let smallestJDNForIndianCalendar = -9223372036854719351
		(Y, M, D) = IndianCalendar.dateFromJulianDayNumber(smallestJDNForIndianCalendar)
		var jdn = IndianCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		XCTAssertEqual(smallestJDNForIndianCalendar, jdn)

		// Values larger than this cause an arithmetic overflow in dateFromJulianDayNumber
		let largestJDNForIndianCalendar = 2305795661307959298
		(Y, M, D) = IndianCalendar.dateFromJulianDayNumber(largestJDNForIndianCalendar)
		jdn = IndianCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		XCTAssertEqual(largestJDNForIndianCalendar, jdn)

		// Values smaller than this cause an arithmetic overflow in dateAndTimeFromJulianDate
		let smallestJDForIndianCalendar = -0x1.fffffffffffc8p+62
		(Y, M, D, h, m, s) = IndianCalendar.dateAndTimeFromJulianDate(smallestJDForIndianCalendar)
		var jd = IndianCalendar.julianDateFrom(year: Y, month: M, day: D, hour: h, minute: m, second: s)
		XCTAssertEqual(smallestJDForIndianCalendar, jd)

		// Values larger than this cause an arithmetic overflow in dateAndTimeFromJulianDate
		let largestJDForIndianCalendar = 0x1.fffd4eff4e5d8p+60
		(Y, M, D, h, m, s) = IndianCalendar.dateAndTimeFromJulianDate(largestJDForIndianCalendar)
		jd = IndianCalendar.julianDateFrom(year: Y, month: M, day: D, hour: h, minute: m, second: s)
		XCTAssertEqual(largestJDForIndianCalendar, jd)
	}
}
