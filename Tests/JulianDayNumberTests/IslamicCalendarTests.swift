//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import XCTest
@testable import JulianDayNumber

final class IslamicCalendarTests: XCTestCase {
	func testDateValidation() {
		XCTAssertTrue(IslamicCalendar.isDateValid(year: 7, month: 12, day: 30))
		XCTAssertFalse(IslamicCalendar.isDateValid(year: 7, month: 12, day: 31))
		XCTAssertFalse(IslamicCalendar.isDateValid(year: 38, month: 12, day: 30))
	}

	func testLeapYear() {
		XCTAssertFalse(IslamicCalendar.isLeapYear(1))
		XCTAssertTrue(IslamicCalendar.isLeapYear(2))
		XCTAssertFalse(IslamicCalendar.isLeapYear(3))
		XCTAssertFalse(IslamicCalendar.isLeapYear(4))
		XCTAssertTrue(IslamicCalendar.isLeapYear(5))
		XCTAssertFalse(IslamicCalendar.isLeapYear(6))
		XCTAssertTrue(IslamicCalendar.isLeapYear(7))
		XCTAssertFalse(IslamicCalendar.isLeapYear(8))
		XCTAssertFalse(IslamicCalendar.isLeapYear(9))
		XCTAssertTrue(IslamicCalendar.isLeapYear(10))
		XCTAssertFalse(IslamicCalendar.isLeapYear(11))
		XCTAssertFalse(IslamicCalendar.isLeapYear(12))
		XCTAssertTrue(IslamicCalendar.isLeapYear(13))
		XCTAssertFalse(IslamicCalendar.isLeapYear(14))
		XCTAssertFalse(IslamicCalendar.isLeapYear(15))
		XCTAssertTrue(IslamicCalendar.isLeapYear(16))
		XCTAssertFalse(IslamicCalendar.isLeapYear(17))
		XCTAssertTrue(IslamicCalendar.isLeapYear(18))
		XCTAssertFalse(IslamicCalendar.isLeapYear(19))
		XCTAssertFalse(IslamicCalendar.isLeapYear(20))
		XCTAssertTrue(IslamicCalendar.isLeapYear(21))
		XCTAssertFalse(IslamicCalendar.isLeapYear(22))
		XCTAssertFalse(IslamicCalendar.isLeapYear(23))
		XCTAssertTrue(IslamicCalendar.isLeapYear(24))
		XCTAssertFalse(IslamicCalendar.isLeapYear(25))
		XCTAssertTrue(IslamicCalendar.isLeapYear(26))
		XCTAssertFalse(IslamicCalendar.isLeapYear(27))
		XCTAssertFalse(IslamicCalendar.isLeapYear(28))
		XCTAssertTrue(IslamicCalendar.isLeapYear(29))
		XCTAssertFalse(IslamicCalendar.isLeapYear(30))
	}

	func testMonthLength() {
		XCTAssertEqual(IslamicCalendar.daysInMonth(year: 1, month: 1), 30)
		XCTAssertEqual(IslamicCalendar.daysInMonth(year: 1, month: 2), 29)
		XCTAssertEqual(IslamicCalendar.daysInMonth(year: 1, month: 3), 30)
		XCTAssertEqual(IslamicCalendar.daysInMonth(year: 1, month: 4), 29)
		XCTAssertEqual(IslamicCalendar.daysInMonth(year: 1, month: 5), 30)
		XCTAssertEqual(IslamicCalendar.daysInMonth(year: 1, month: 6), 29)
		XCTAssertEqual(IslamicCalendar.daysInMonth(year: 1, month: 7), 30)
		XCTAssertEqual(IslamicCalendar.daysInMonth(year: 1, month: 8), 29)
		XCTAssertEqual(IslamicCalendar.daysInMonth(year: 1, month: 9), 30)
		XCTAssertEqual(IslamicCalendar.daysInMonth(year: 1, month: 10), 29)
		XCTAssertEqual(IslamicCalendar.daysInMonth(year: 1, month: 11), 30)
		XCTAssertEqual(IslamicCalendar.daysInMonth(year: 1, month: 12), 29)
		XCTAssertEqual(IslamicCalendar.daysInMonth(year: 2, month: 12), 30)
		XCTAssertEqual(IslamicCalendar.daysInMonth(year: 4, month: 12), 29)
		XCTAssertEqual(IslamicCalendar.daysInMonth(year: 7, month: 12), 30)
	}

	func testJulianDayNumber() {
		// From Richards
		XCTAssertEqual(IslamicCalendar.dateToJulianDayNumber(year: 1, month: 1, day: 1), 1948440)
		// From Meeus
		XCTAssertEqual(IslamicCalendar.dateToJulianDayNumber(year: 1421, month: 1, day: 1), 2451641)
	}

	func testLimits() {
		XCTAssertEqual(IslamicCalendar.dateToJulianDate(year: -999999, month: 1, day: 1), -352418227.5)
		XCTAssertEqual(IslamicCalendar.dateToJulianDate(year: -99999, month: 1, day: 1), -33488227.5)
		XCTAssertEqual(IslamicCalendar.dateToJulianDate(year: -9999, month: 1, day: 1), -1595227.5)
		XCTAssertEqual(IslamicCalendar.dateToJulianDate(year: 9999, month: 12, day: 29), 5491750.5)
		XCTAssertEqual(IslamicCalendar.dateToJulianDate(year: 99999, month: 12, day: 29), 37384750.5)
		XCTAssertEqual(IslamicCalendar.dateToJulianDate(year: 999999, month: 12, day: 29), 356314750.5)

		XCTAssertTrue(IslamicCalendar.julianDateToDate(-352418227.5) == (-999999, 1, 1, 0, 0, 0))
		XCTAssertTrue(IslamicCalendar.julianDateToDate(-33488227.5) == (-99999, 1, 1, 0, 0, 0))
		XCTAssertTrue(IslamicCalendar.julianDateToDate(-1595227.5) == (-9999, 1, 1, 0, 0, 0))
		XCTAssertTrue(IslamicCalendar.julianDateToDate(5491750.5) == (9999, 12, 29, 0, 0, 0))
		XCTAssertTrue(IslamicCalendar.julianDateToDate(37384750.5) == (99999, 12, 29, 0, 0, 0))
		XCTAssertTrue(IslamicCalendar.julianDateToDate(356314750.5) == (999999, 12, 29, 0, 0, 0))
	}

	func testArithmeticLimits() {
		var Y, M, D, h, m: Int
		var s: Double

		// Values smaller than this cause an arithmetic overflow in IslamicCalendar.julianDayNumberToDate
		let smallestJDNForIslamicCalendar = -9223372036854775352
		(Y, M, D) = IslamicCalendar.julianDayNumberToDate(smallestJDNForIslamicCalendar)
		var jdn = IslamicCalendar.dateToJulianDayNumber(year: Y, month: M, day: D)
		XCTAssertEqual(smallestJDNForIslamicCalendar, jdn)

		// Values larger than this cause an arithmetic overflow in IslamicCalendar.julianDayNumberToDate
		let largestJDNForIslamicCalendar = 307445734561818195
		(Y, M, D) = IslamicCalendar.julianDayNumberToDate(largestJDNForIslamicCalendar)
		jdn = IslamicCalendar.dateToJulianDayNumber(year: Y, month: M, day: D)
		XCTAssertEqual(largestJDNForIslamicCalendar, jdn)

		// Values smaller than this cause an arithmetic overflow in IslamicCalendar.julianDateToDate
		let smallestJDForIslamicCalendar = -0x1.fffffffffffffp+62
		(Y, M, D, h, m, s) = IslamicCalendar.julianDateToDate(smallestJDForIslamicCalendar)
		var jd = IslamicCalendar.dateToJulianDate(year: Y, month: M, day: D, hour: h, minute: m, second: s)
		XCTAssertEqual(smallestJDForIslamicCalendar, jd)

		// Values larger than this cause an arithmetic overflow in IslamicCalendar.julianDateToDate
		let largestJDForIslamicCalendar = 0x1.1111111111099p+58
		(Y, M, D, h, m, s) = IslamicCalendar.julianDateToDate(largestJDForIslamicCalendar)
		jd = IslamicCalendar.dateToJulianDate(year: Y, month: M, day: D, hour: h, minute: m, second: s)
		XCTAssertEqual(largestJDForIslamicCalendar, jd)
	}
}