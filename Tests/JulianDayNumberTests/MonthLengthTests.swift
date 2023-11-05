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

	func testAstronomicalMonthLength() {
		XCTAssertEqual(AstronomicalCalendar.daysInMonth(year: 1900, month: 1), 31)
		XCTAssertEqual(AstronomicalCalendar.daysInMonth(year: 1900, month: 2), 28)
		XCTAssertEqual(AstronomicalCalendar.daysInMonth(year: 1900, month: 3), 31)
		XCTAssertEqual(AstronomicalCalendar.daysInMonth(year: 1900, month: 4), 30)
		XCTAssertEqual(AstronomicalCalendar.daysInMonth(year: 1900, month: 5), 31)
		XCTAssertEqual(AstronomicalCalendar.daysInMonth(year: 1900, month: 6), 30)
		XCTAssertEqual(AstronomicalCalendar.daysInMonth(year: 1900, month: 7), 31)
		XCTAssertEqual(AstronomicalCalendar.daysInMonth(year: 1900, month: 8), 31)
		XCTAssertEqual(AstronomicalCalendar.daysInMonth(year: 1900, month: 9), 30)
		XCTAssertEqual(AstronomicalCalendar.daysInMonth(year: 1900, month: 10), 31)
		XCTAssertEqual(AstronomicalCalendar.daysInMonth(year: 1900, month: 11), 30)
		XCTAssertEqual(AstronomicalCalendar.daysInMonth(year: 1900, month: 12), 31)
		XCTAssertEqual(AstronomicalCalendar.daysInMonth(year: 1600, month: 2), 29)
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

	func testCopticMonthLength() {
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

	func testEthiopianMonthLength() {
		XCTAssertEqual(EthiopianCalendar.daysInMonth(year: 1, month: 1), 30)
		XCTAssertEqual(EthiopianCalendar.daysInMonth(year: 1, month: 2), 30)
		XCTAssertEqual(EthiopianCalendar.daysInMonth(year: 1, month: 3), 30)
		XCTAssertEqual(EthiopianCalendar.daysInMonth(year: 1, month: 4), 30)
		XCTAssertEqual(EthiopianCalendar.daysInMonth(year: 1, month: 5), 30)
		XCTAssertEqual(EthiopianCalendar.daysInMonth(year: 1, month: 6), 30)
		XCTAssertEqual(EthiopianCalendar.daysInMonth(year: 1, month: 7), 30)
		XCTAssertEqual(EthiopianCalendar.daysInMonth(year: 1, month: 8), 30)
		XCTAssertEqual(EthiopianCalendar.daysInMonth(year: 1, month: 9), 30)
		XCTAssertEqual(EthiopianCalendar.daysInMonth(year: 1, month: 10), 30)
		XCTAssertEqual(EthiopianCalendar.daysInMonth(year: 1, month: 11), 30)
		XCTAssertEqual(EthiopianCalendar.daysInMonth(year: 1, month: 12), 30)
		XCTAssertEqual(EthiopianCalendar.daysInMonth(year: 1, month: 13), 5)
		XCTAssertEqual(EthiopianCalendar.daysInMonth(year: 3, month: 13), 6)
	}

	func testEgyptianMonthLength() {
		XCTAssertEqual(EgyptianCalendar.daysInMonth(month: 1), 30)
		XCTAssertEqual(EgyptianCalendar.daysInMonth(month: 2), 30)
		XCTAssertEqual(EgyptianCalendar.daysInMonth(month: 3), 30)
		XCTAssertEqual(EgyptianCalendar.daysInMonth(month: 4), 30)
		XCTAssertEqual(EgyptianCalendar.daysInMonth(month: 5), 30)
		XCTAssertEqual(EgyptianCalendar.daysInMonth(month: 6), 30)
		XCTAssertEqual(EgyptianCalendar.daysInMonth(month: 7), 30)
		XCTAssertEqual(EgyptianCalendar.daysInMonth(month: 8), 30)
		XCTAssertEqual(EgyptianCalendar.daysInMonth(month: 9), 30)
		XCTAssertEqual(EgyptianCalendar.daysInMonth(month: 10), 30)
		XCTAssertEqual(EgyptianCalendar.daysInMonth(month: 11), 30)
		XCTAssertEqual(EgyptianCalendar.daysInMonth(month: 12), 30)
		XCTAssertEqual(EgyptianCalendar.daysInMonth(month: 13), 5)
	}
}
