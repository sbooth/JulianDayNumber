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
		XCTAssertFalse(CopticCalendar.isLeapYear(1))
		XCTAssertTrue(CopticCalendar.isLeapYear(3))
		XCTAssertTrue(CopticCalendar.isLeapYear(7))
		XCTAssertTrue(CopticCalendar.isLeapYear(1739))
		XCTAssertFalse(CopticCalendar.isLeapYear(1740))
		XCTAssertTrue(CopticCalendar.isLeapYear(-1))
		XCTAssertFalse(CopticCalendar.isLeapYear(-2))

		for y in -500...500 {
			let isLeap = CopticCalendar.isLeapYear(y)
			let j = CopticCalendar.julianDayNumberFrom(year: y, month: 13, day: isLeap ? 6 : 5)
			let d = CopticCalendar.dateFromJulianDayNumber(j)
			XCTAssertEqual(d.month, 13)
			XCTAssertEqual(d.day, isLeap ? 6 : 5)
		}
	}

	func testMonthCount() {
		XCTAssertEqual(CopticCalendar.monthsInYear, 13)
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
		XCTAssertEqual(CopticCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1), 1825030)
		XCTAssertTrue(CopticCalendar.dateFromJulianDayNumber(1825030) == (1, 1, 1))
	}

	func testLimits() {
		XCTAssertEqual(CopticCalendar.julianDateFrom(year: -999999, month: 1, day: 1), -363424970.5)
		XCTAssertEqual(CopticCalendar.julianDateFrom(year: -99999, month: 1, day: 1), -34699970.5)
		XCTAssertEqual(CopticCalendar.julianDateFrom(year: -9999, month: 1, day: 1), -1827470.5)
		XCTAssertEqual(CopticCalendar.julianDateFrom(year: 9999, month: 13, day: 5), 5477162.5)
		XCTAssertEqual(CopticCalendar.julianDateFrom(year: 99999, month: 13, day: 5), 38349662.5)
		XCTAssertEqual(CopticCalendar.julianDateFrom(year: 999999, month: 13, day: 5), 367074662.5)

		XCTAssertTrue(CopticCalendar.dateAndTimeFromJulianDate(-363424970.5) == (-999999, 1, 1, 0, 0, 0))
		XCTAssertTrue(CopticCalendar.dateAndTimeFromJulianDate(-34699970.5) == (-99999, 1, 1, 0, 0, 0))
		XCTAssertTrue(CopticCalendar.dateAndTimeFromJulianDate(-1827470.5) == (-9999, 1, 1, 0, 0, 0))
		XCTAssertTrue(CopticCalendar.dateAndTimeFromJulianDate(5477162.5) == (9999, 13, 5, 0, 0, 0))
		XCTAssertTrue(CopticCalendar.dateAndTimeFromJulianDate(38349662.5) == (99999, 13, 5, 0, 0, 0))
		XCTAssertTrue(CopticCalendar.dateAndTimeFromJulianDate(367074662.5) == (999999, 13, 5, 0, 0, 0))
	}

	func testArithmeticLimits() {
		// Values smaller than this cause an arithmetic overflow in dateFromJulianDayNumber
//		let smallestJDNForCopticCalendar = Int.min + 144
		// Values smaller than this cause an arithmetic overflow in julianDayNumberFrom
		let smallestJDNForCopticCalendar = Int.min + 384
		var (Y, M, D) = CopticCalendar.dateFromJulianDayNumber(smallestJDNForCopticCalendar)
		var jdn = CopticCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		XCTAssertEqual(smallestJDNForCopticCalendar, jdn)

		// Values larger than this cause an arithmetic overflow in dateFromJulianDayNumber
		let largestJDNForCopticCalendar = (Int.max - 3) / 4 - 124
		(Y, M, D) = CopticCalendar.dateFromJulianDayNumber(largestJDNForCopticCalendar)
		jdn = CopticCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		XCTAssertEqual(largestJDNForCopticCalendar, jdn)
	}
}
