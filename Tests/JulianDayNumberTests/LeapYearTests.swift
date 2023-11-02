//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import XCTest
@testable import JulianDayNumber

final class LeapYearTests: XCTestCase {
	func testJulianLeapYear() {
		XCTAssertTrue(JulianCalendar.isLeapYear(900))
		XCTAssertTrue(JulianCalendar.isLeapYear(1236))
		XCTAssertFalse(JulianCalendar.isLeapYear(750))
		XCTAssertFalse(JulianCalendar.isLeapYear(1429))
	}

	func testGregorianLeapYear() {
		XCTAssertTrue(GregorianCalendar.isLeapYear(1600))
		XCTAssertTrue(GregorianCalendar.isLeapYear(2000))
		XCTAssertTrue(GregorianCalendar.isLeapYear(2400))
		XCTAssertFalse(GregorianCalendar.isLeapYear(1700))
		XCTAssertFalse(GregorianCalendar.isLeapYear(1800))
		XCTAssertFalse(GregorianCalendar.isLeapYear(1900))
		XCTAssertFalse(GregorianCalendar.isLeapYear(2100))
	}

	func testJulianGregorianLeapYear() {
		XCTAssertTrue(JulianGregorianCalendar.isLeapYear(900))
	}

	func testIslamicLeapYear() {
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
}
