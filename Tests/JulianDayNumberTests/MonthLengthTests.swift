//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import XCTest
@testable import JulianDayNumber

final class MonthLengthTests: XCTestCase {
	func testJulianMonthLength() {
		XCTAssertEqual(JulianCalendar.daysInMonth(year: 1600, month: 2), 29)
		XCTAssertEqual(JulianCalendar.daysInMonth(year: 1700, month: 2), 29)
	}

	func testGregorianMonthLength() {
		XCTAssertEqual(GregorianCalendar.daysInMonth(year: 1600, month: 2), 29)
		XCTAssertEqual(GregorianCalendar.daysInMonth(year: 1700, month: 2), 28)
	}

	func testJulianGregorianMonthLength() {
		XCTAssertEqual(JulianGregorianCalendar.daysInMonth(year: 1900, month: 1), 31)
		XCTAssertEqual(JulianGregorianCalendar.daysInMonth(year: 1900, month: 2), 28)
		XCTAssertEqual(JulianGregorianCalendar.daysInMonth(year: 1900, month: 3), 31)
		XCTAssertEqual(JulianGregorianCalendar.daysInMonth(year: 1900, month: 4), 30)
		XCTAssertEqual(JulianGregorianCalendar.daysInMonth(year: 1900, month: 5), 31)
		XCTAssertEqual(JulianGregorianCalendar.daysInMonth(year: 1900, month: 6), 30)
		XCTAssertEqual(JulianGregorianCalendar.daysInMonth(year: 1900, month: 7), 31)
		XCTAssertEqual(JulianGregorianCalendar.daysInMonth(year: 1900, month: 8), 31)
		XCTAssertEqual(JulianGregorianCalendar.daysInMonth(year: 1900, month: 9), 30)
		XCTAssertEqual(JulianGregorianCalendar.daysInMonth(year: 1900, month: 10), 31)
		XCTAssertEqual(JulianGregorianCalendar.daysInMonth(year: 1900, month: 11), 30)
		XCTAssertEqual(JulianGregorianCalendar.daysInMonth(year: 1900, month: 12), 31)
		XCTAssertEqual(JulianGregorianCalendar.daysInMonth(year: 1600, month: 2), 29)
	}

	func testIslamicMonthLength() {
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
}
