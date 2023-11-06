//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import XCTest
@testable import JulianDayNumber

final class BahaiCalendarTests: XCTestCase {
	func testDateValidation() {
		XCTAssertTrue(BahaiCalendar.isDateValid(year: 1, month: 1, day: 1))
		XCTAssertFalse(BahaiCalendar.isDateValid(year: 3, month: 19, day: 5))
		XCTAssertTrue(BahaiCalendar.isDateValid(year: 4, month: 19, day: 5))
	}

	func testLeapYear() {
		XCTAssertFalse(BahaiCalendar.isLeapYear(1))
		XCTAssertTrue(BahaiCalendar.isLeapYear(4))
		XCTAssertTrue(BahaiCalendar.isLeapYear(100))
		XCTAssertFalse(BahaiCalendar.isLeapYear(750))
		XCTAssertTrue(BahaiCalendar.isLeapYear(900))
		XCTAssertTrue(BahaiCalendar.isLeapYear(1236))
		XCTAssertFalse(BahaiCalendar.isLeapYear(1429))
		XCTAssertFalse(BahaiCalendar.isLeapYear(-3))
		XCTAssertTrue(BahaiCalendar.isLeapYear(-4))
		XCTAssertTrue(BahaiCalendar.isLeapYear(-8))
		XCTAssertTrue(BahaiCalendar.isLeapYear(-100))

		for y in -500...500 {
			let isLeap = BahaiCalendar.isLeapYear(y)
			let j = BahaiCalendar.dateToJulianDayNumber(year: y, month: 19, day: isLeap ? 5 : 4)
			let d = BahaiCalendar.julianDayNumberToDate(j)
			XCTAssertEqual(d.month, 19)
			XCTAssertEqual(d.day, isLeap ? 5 : 4)
		}
	}

	func testMonthCount() {
		XCTAssertEqual(BahaiCalendar.monthsInYear, 20)
	}

	func testMonthLength() {
		XCTAssertEqual(BahaiCalendar.daysInMonth(year: 1, month: 1), 19)
		XCTAssertEqual(BahaiCalendar.daysInMonth(year: 1, month: 2), 19)
		XCTAssertEqual(BahaiCalendar.daysInMonth(year: 1, month: 3), 19)
		XCTAssertEqual(BahaiCalendar.daysInMonth(year: 1, month: 4), 19)
		XCTAssertEqual(BahaiCalendar.daysInMonth(year: 1, month: 5), 19)
		XCTAssertEqual(BahaiCalendar.daysInMonth(year: 1, month: 6), 19)
		XCTAssertEqual(BahaiCalendar.daysInMonth(year: 1, month: 7), 19)
		XCTAssertEqual(BahaiCalendar.daysInMonth(year: 1, month: 8), 19)
		XCTAssertEqual(BahaiCalendar.daysInMonth(year: 1, month: 9), 19)
		XCTAssertEqual(BahaiCalendar.daysInMonth(year: 1, month: 10), 19)
		XCTAssertEqual(BahaiCalendar.daysInMonth(year: 1, month: 11), 19)
		XCTAssertEqual(BahaiCalendar.daysInMonth(year: 1, month: 12), 19)
		XCTAssertEqual(BahaiCalendar.daysInMonth(year: 1, month: 13), 19)
		XCTAssertEqual(BahaiCalendar.daysInMonth(year: 1, month: 14), 19)
		XCTAssertEqual(BahaiCalendar.daysInMonth(year: 1, month: 15), 19)
		XCTAssertEqual(BahaiCalendar.daysInMonth(year: 1, month: 16), 19)
		XCTAssertEqual(BahaiCalendar.daysInMonth(year: 1, month: 17), 19)
		XCTAssertEqual(BahaiCalendar.daysInMonth(year: 1, month: 18), 19)
		XCTAssertEqual(BahaiCalendar.daysInMonth(year: 1, month: 20), 19)
		XCTAssertEqual(BahaiCalendar.daysInMonth(year: 2, month: 19), 4)
		XCTAssertEqual(BahaiCalendar.daysInMonth(year: 3, month: 19), 4)
		XCTAssertEqual(BahaiCalendar.daysInMonth(year: 4, month: 19), 5)
	}

	func testJulianDayNumber() {
		XCTAssertEqual(BahaiCalendar.dateToJulianDayNumber(year: 1, month: 1, day: 1), 2394647)
	}

	func testLimits() {
		XCTAssertEqual(BahaiCalendar.dateToJulianDate(year: -999999, month: 1, day: 1), -362855303.5)
		XCTAssertEqual(BahaiCalendar.dateToJulianDate(year: -99999, month: 1, day: 1), -34130303.5)
		XCTAssertEqual(BahaiCalendar.dateToJulianDate(year: -9999, month: 1, day: 1), -1257803.5)
		XCTAssertEqual(BahaiCalendar.dateToJulianDate(year: 9999, month: 20, day: 19), 6046704.5)
		XCTAssertEqual(BahaiCalendar.dateToJulianDate(year: 99999, month: 20, day: 19), 38918529.5)
		XCTAssertEqual(BahaiCalendar.dateToJulianDate(year: 999999, month: 20, day: 19), 367636779.5)

		XCTAssertTrue(BahaiCalendar.julianDateToDate(-362855303.5) == (-999999, 1, 1, 0, 0, 0))
		XCTAssertTrue(BahaiCalendar.julianDateToDate(-34130303.5) == (-99999, 1, 1, 0, 0, 0))
		XCTAssertTrue(BahaiCalendar.julianDateToDate(-1257803.5) == (-9999, 1, 1, 0, 0, 0))
		XCTAssertTrue(BahaiCalendar.julianDateToDate(6046704.5) == (9999, 20, 19, 0, 0, 0))
		XCTAssertTrue(BahaiCalendar.julianDateToDate(38918529.5) == (99999, 20, 19, 0, 0, 0))
		XCTAssertTrue(BahaiCalendar.julianDateToDate(367636779.5) == (999999, 20, 19, 0, 0, 0))
	}

	func testArithmeticLimits() {
		var Y, M, D, h, m: Int
		var s: Double

		// Values smaller than this cause an arithmetic overflow in julianDayNumberToDate
		let smallestJDNForBahaiCalendar = -9223372036854775664
		(Y, M, D) = BahaiCalendar.julianDayNumberToDate(smallestJDNForBahaiCalendar)
		var jdn = BahaiCalendar.dateToJulianDayNumber(year: Y, month: M, day: D)
		XCTAssertEqual(smallestJDNForBahaiCalendar, jdn)

		// Values larger than this cause an arithmetic overflow in julianDayNumberToDate
		let largestJDNForBahaiCalendar = 2305795661307959248
		(Y, M, D) = BahaiCalendar.julianDayNumberToDate(largestJDNForBahaiCalendar)
		jdn = BahaiCalendar.dateToJulianDayNumber(year: Y, month: M, day: D)
		XCTAssertEqual(largestJDNForBahaiCalendar, jdn)

		// Values smaller than this cause an arithmetic overflow in julianDateToDate
		let smallestJDForBahaiCalendar = -0x1.fffffffffffffp+62
		(Y, M, D, h, m, s) = BahaiCalendar.julianDateToDate(smallestJDForBahaiCalendar)
		var jd = BahaiCalendar.dateToJulianDate(year: Y, month: M, day: D, hour: h, minute: m, second: s)
		XCTAssertEqual(smallestJDForBahaiCalendar, jd)

		// Values larger than this cause an arithmetic overflow in julianDateToDate
		let largestJDForBahaiCalendar = 0x1.fffd4eff4e5d7p+60
		(Y, M, D, h, m, s) = BahaiCalendar.julianDateToDate(largestJDForBahaiCalendar)
		jd = BahaiCalendar.dateToJulianDate(year: Y, month: M, day: D, hour: h, minute: m, second: s)
		XCTAssertEqual(largestJDForBahaiCalendar, jd)
	}
}