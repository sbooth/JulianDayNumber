//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import XCTest
@testable import JulianDayNumber

final class FrenchRepublicanCalendarTests: XCTestCase {
	func testDateValidation() {
		XCTAssertTrue(FrenchRepublicanCalendar.isDateValid(year: 1, month: 1, day: 1))
		XCTAssertTrue(FrenchRepublicanCalendar.isDateValid(year: 3, month: 13, day: 6))
		XCTAssertFalse(FrenchRepublicanCalendar.isDateValid(year: 4, month: 13, day: 6))
	}

	func testLeapYear() {
		XCTAssertTrue(FrenchRepublicanCalendar.isLeapYear(3))
		XCTAssertTrue(FrenchRepublicanCalendar.isLeapYear(7))
		XCTAssertTrue(FrenchRepublicanCalendar.isLeapYear(11))
		XCTAssertTrue(FrenchRepublicanCalendar.isLeapYear(95))
		XCTAssertFalse(FrenchRepublicanCalendar.isLeapYear(99))
		XCTAssertTrue(FrenchRepublicanCalendar.isLeapYear(103))
		XCTAssertFalse(FrenchRepublicanCalendar.isLeapYear(2))
		XCTAssertFalse(FrenchRepublicanCalendar.isLeapYear(8))
		XCTAssertTrue(FrenchRepublicanCalendar.isLeapYear(-1))
		XCTAssertFalse(FrenchRepublicanCalendar.isLeapYear(-2))
		XCTAssertTrue(FrenchRepublicanCalendar.isLeapYear(-5))

		for y in -500...500 {
			let isLeap = FrenchRepublicanCalendar.isLeapYear(y)
			let j = FrenchRepublicanCalendar.julianDayNumberFrom(year: y, month: 13, day: isLeap ? 6 : 5)
			let d = FrenchRepublicanCalendar.dateFromJulianDayNumber(j)
			XCTAssertEqual(d.month, 13)
			XCTAssertEqual(d.day, isLeap ? 6 : 5)
		}
	}

	func testMonthCount() {
		XCTAssertEqual(FrenchRepublicanCalendar.monthsInYear, 13)
	}

	func testMonthLength() {
		XCTAssertEqual(FrenchRepublicanCalendar.daysInMonth(year: 1, month: 1), 30)
		XCTAssertEqual(FrenchRepublicanCalendar.daysInMonth(year: 1, month: 2), 30)
		XCTAssertEqual(FrenchRepublicanCalendar.daysInMonth(year: 2, month: 13), 5)
		XCTAssertEqual(FrenchRepublicanCalendar.daysInMonth(year: 3, month: 13), 6)
		XCTAssertEqual(FrenchRepublicanCalendar.daysInMonth(year: 4, month: 13), 5)
	}

	func testJulianDayNumber() {
		XCTAssertEqual(FrenchRepublicanCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1), 2375840)
	}

	func testLimits() {
		XCTAssertEqual(FrenchRepublicanCalendar.julianDateFrom(year: -999999, month: 1, day: 1), -362866660.5)
		XCTAssertEqual(FrenchRepublicanCalendar.julianDateFrom(year: -99999, month: 1, day: 1), -34148410.5)
		XCTAssertEqual(FrenchRepublicanCalendar.julianDateFrom(year: -9999, month: 1, day: 1), -1276585.5)
		XCTAssertEqual(FrenchRepublicanCalendar.julianDateFrom(year: 9999, month: 13, day: 6), 6027898.5)
		XCTAssertEqual(FrenchRepublicanCalendar.julianDateFrom(year: 99999, month: 13, day: 6), 38899723.5)
		XCTAssertEqual(FrenchRepublicanCalendar.julianDateFrom(year: 999999, month: 13, day: 6), 367617973.5)

		XCTAssertTrue(FrenchRepublicanCalendar.dateAndTimeFromJulianDate(-362866660.5) == (-999999, 1, 1, 0, 0, 0))
		XCTAssertTrue(FrenchRepublicanCalendar.dateAndTimeFromJulianDate(-34148410.5) == (-99999, 1, 1, 0, 0, 0))
		XCTAssertTrue(FrenchRepublicanCalendar.dateAndTimeFromJulianDate(-1276585.5) == (-9999, 1, 1, 0, 0, 0))
		XCTAssertTrue(FrenchRepublicanCalendar.dateAndTimeFromJulianDate(6027898.5) == (9999, 13, 6, 0, 0, 0))
		XCTAssertTrue(FrenchRepublicanCalendar.dateAndTimeFromJulianDate(38899723.5) == (99999, 13, 6, 0, 0, 0))
		XCTAssertTrue(FrenchRepublicanCalendar.dateAndTimeFromJulianDate(367617973.5) == (999999, 13, 6, 0, 0, 0))
	}

	func testArithmeticLimits() {
		var Y, M, D, h, m: Int
		var s: Double

		// Values smaller than this cause an arithmetic overflow in dateFromJulianDayNumber
		let smallestJDNForFrenchRepublicanCalendar = -9223372036854719351
		(Y, M, D) = FrenchRepublicanCalendar.dateFromJulianDayNumber(smallestJDNForFrenchRepublicanCalendar)
		var jdn = FrenchRepublicanCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		XCTAssertEqual(smallestJDNForFrenchRepublicanCalendar, jdn)

		// Values larger than this cause an arithmetic overflow in dateFromJulianDayNumber
		let largestJDNForFrenchRepublicanCalendar = 2305795661307960548
		(Y, M, D) = FrenchRepublicanCalendar.dateFromJulianDayNumber(largestJDNForFrenchRepublicanCalendar)
		jdn = FrenchRepublicanCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		XCTAssertEqual(largestJDNForFrenchRepublicanCalendar, jdn)

		// Values smaller than this cause an arithmetic overflow in dateAndTimeFromJulianDate
		let smallestJDForFrenchRepublicanCalendar = -0x1.fffffffffffc8p+62
		(Y, M, D, h, m, s) = FrenchRepublicanCalendar.dateAndTimeFromJulianDate(smallestJDForFrenchRepublicanCalendar)
		var jd = FrenchRepublicanCalendar.julianDateFrom(year: Y, month: M, day: D, hour: h, minute: m, second: s)
		XCTAssertEqual(smallestJDForFrenchRepublicanCalendar, jd)

		// Values larger than this cause an arithmetic overflow in dateAndTimeFromJulianDate
		let largestJDForFrenchRepublicanCalendar = 0x1.fffd4eff4e5dcp+60
		(Y, M, D, h, m, s) = FrenchRepublicanCalendar.dateAndTimeFromJulianDate(largestJDForFrenchRepublicanCalendar)
		jd = FrenchRepublicanCalendar.julianDateFrom(year: Y, month: M, day: D, hour: h, minute: m, second: s)
		XCTAssertEqual(largestJDForFrenchRepublicanCalendar, jd)
	}
}
