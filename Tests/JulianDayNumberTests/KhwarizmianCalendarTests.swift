//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import XCTest
@testable import JulianDayNumber

final class KhwarizmianCalendarTests: XCTestCase {
	func testMonthLength() {
		XCTAssertEqual(KhwarizmianCalendar.daysInMonth(1), 30)
		XCTAssertEqual(KhwarizmianCalendar.daysInMonth(2), 30)
		XCTAssertEqual(KhwarizmianCalendar.daysInMonth(3), 30)
		XCTAssertEqual(KhwarizmianCalendar.daysInMonth(4), 30)
		XCTAssertEqual(KhwarizmianCalendar.daysInMonth(5), 30)
		XCTAssertEqual(KhwarizmianCalendar.daysInMonth(6), 30)
		XCTAssertEqual(KhwarizmianCalendar.daysInMonth(7), 30)
		XCTAssertEqual(KhwarizmianCalendar.daysInMonth(8), 30)
		XCTAssertEqual(KhwarizmianCalendar.daysInMonth(9), 30)
		XCTAssertEqual(KhwarizmianCalendar.daysInMonth(10), 30)
		XCTAssertEqual(KhwarizmianCalendar.daysInMonth(11), 30)
		XCTAssertEqual(KhwarizmianCalendar.daysInMonth(12), 30)
		XCTAssertEqual(KhwarizmianCalendar.daysInMonth(13), 5)
	}

	func testJulianDayNumber() {
		XCTAssertEqual(KhwarizmianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1), 1952068)
		XCTAssertTrue(KhwarizmianCalendar.dateFromJulianDayNumber(1952068) == (1, 1, 1))
	}

	func testLimits() {
		XCTAssertEqual(KhwarizmianCalendar.julianDateFrom(year: -999999, month: 1, day: 1), -363047932.5)
		XCTAssertEqual(KhwarizmianCalendar.julianDateFrom(year: -99999, month: 1, day: 1), -34547932.5)
		XCTAssertEqual(KhwarizmianCalendar.julianDateFrom(year: -9999, month: 1, day: 1), -1697932.5)
		XCTAssertEqual(KhwarizmianCalendar.julianDateFrom(year: 9999, month: 13, day: 5), 5601701.5)
		XCTAssertEqual(KhwarizmianCalendar.julianDateFrom(year: 99999, month: 13, day: 5), 38451701.5)
		XCTAssertEqual(KhwarizmianCalendar.julianDateFrom(year: 999999, month: 13, day: 5), 366951701.5)

		XCTAssertTrue(KhwarizmianCalendar.dateAndTimeFromJulianDate(-363047932.5) == (-999999, 1, 1, 0, 0, 0))
		XCTAssertTrue(KhwarizmianCalendar.dateAndTimeFromJulianDate(-34547932.5) == (-99999, 1, 1, 0, 0, 0))
		XCTAssertTrue(KhwarizmianCalendar.dateAndTimeFromJulianDate(-1697932.5) == (-9999, 1, 1, 0, 0, 0))
		XCTAssertTrue(KhwarizmianCalendar.dateAndTimeFromJulianDate(5601701.5) == (9999, 13, 5, 0, 0, 0))
		XCTAssertTrue(KhwarizmianCalendar.dateAndTimeFromJulianDate(38451701.5) == (99999, 13, 5, 0, 0, 0))
		XCTAssertTrue(KhwarizmianCalendar.dateAndTimeFromJulianDate(366951701.5) == (999999, 13, 5, 0, 0, 0))
	}

	func testArithmeticLimits() {
		var Y, M, D, h, m: Int
		var s: Double

		// Values smaller than this cause an arithmetic overflow in dateFromJulianDayNumber
		let smallestJDNForKhwarizmianCalendar = -9223372036854775514
		(Y, M, D) = KhwarizmianCalendar.dateFromJulianDayNumber(smallestJDNForKhwarizmianCalendar)
		var jdn = KhwarizmianCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		XCTAssertEqual(smallestJDNForKhwarizmianCalendar, jdn)

		// Values larger than this cause an arithmetic overflow in dateFromJulianDayNumber
		let largestJDNForKhwarizmianCalendar = 9223372036854775490
		(Y, M, D) = KhwarizmianCalendar.dateFromJulianDayNumber(largestJDNForKhwarizmianCalendar)
		jdn = KhwarizmianCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		XCTAssertEqual(largestJDNForKhwarizmianCalendar, jdn)

		// Values smaller than this cause an arithmetic overflow in dateAndTimeFromJulianDate
		let smallestJDForKhwarizmianCalendar = -0x1.fffffffffffffp+62
		(Y, M, D, h, m, s) = KhwarizmianCalendar.dateAndTimeFromJulianDate(smallestJDForKhwarizmianCalendar)
		var jd = KhwarizmianCalendar.julianDateFrom(year: Y, month: M, day: D, hour: h, minute: m, second: s)
		XCTAssertEqual(smallestJDForKhwarizmianCalendar, jd)

		// Values larger than this cause an arithmetic overflow in dateAndTimeFromJulianDate
		let largestJDForKhwarizmianCalendar = 0x1.fffffffffffffp+62
		(Y, M, D, h, m, s) = KhwarizmianCalendar.dateAndTimeFromJulianDate(largestJDForKhwarizmianCalendar)
		jd = KhwarizmianCalendar.julianDateFrom(year: Y, month: M, day: D, hour: h, minute: m, second: s)
		XCTAssertEqual(largestJDForKhwarizmianCalendar, jd)
	}
}
