//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import XCTest
@testable import JulianDayNumber

final class LeapYearTests: XCTestCase {
	func testLeapYear() {
		XCTAssertTrue(isLeapYear(900))
	}

	func testJulianLeapYear() {
		XCTAssertTrue(isJulianCalendarLeapYear(900))
		XCTAssertTrue(isJulianCalendarLeapYear(1236))
		XCTAssertFalse(isJulianCalendarLeapYear(750))
		XCTAssertFalse(isJulianCalendarLeapYear(1429))
	}

	func testGregorianLeapYear() {
		XCTAssertTrue(isGregorianCalendarLeapYear(1600))
		XCTAssertTrue(isGregorianCalendarLeapYear(2000))
		XCTAssertTrue(isGregorianCalendarLeapYear(2400))
		XCTAssertFalse(isGregorianCalendarLeapYear(1700))
		XCTAssertFalse(isGregorianCalendarLeapYear(1800))
		XCTAssertFalse(isGregorianCalendarLeapYear(1900))
		XCTAssertFalse(isGregorianCalendarLeapYear(2100))
	}

	func testIslamicLeapYear() {
		XCTAssertFalse(isIslamicCalendarLeapYear(1))
		XCTAssertTrue(isIslamicCalendarLeapYear(2))
		XCTAssertFalse(isIslamicCalendarLeapYear(3))
		XCTAssertFalse(isIslamicCalendarLeapYear(4))
		XCTAssertTrue(isIslamicCalendarLeapYear(5))
		XCTAssertFalse(isIslamicCalendarLeapYear(6))
		XCTAssertTrue(isIslamicCalendarLeapYear(7))
		XCTAssertFalse(isIslamicCalendarLeapYear(8))
		XCTAssertFalse(isIslamicCalendarLeapYear(9))
		XCTAssertTrue(isIslamicCalendarLeapYear(10))
		XCTAssertFalse(isIslamicCalendarLeapYear(11))
		XCTAssertFalse(isIslamicCalendarLeapYear(12))
		XCTAssertTrue(isIslamicCalendarLeapYear(13))
		XCTAssertFalse(isIslamicCalendarLeapYear(14))
		XCTAssertFalse(isIslamicCalendarLeapYear(15))
		XCTAssertTrue(isIslamicCalendarLeapYear(16))
		XCTAssertFalse(isIslamicCalendarLeapYear(17))
		XCTAssertTrue(isIslamicCalendarLeapYear(18))
		XCTAssertFalse(isIslamicCalendarLeapYear(19))
		XCTAssertFalse(isIslamicCalendarLeapYear(20))
		XCTAssertTrue(isIslamicCalendarLeapYear(21))
		XCTAssertFalse(isIslamicCalendarLeapYear(22))
		XCTAssertFalse(isIslamicCalendarLeapYear(23))
		XCTAssertTrue(isIslamicCalendarLeapYear(24))
		XCTAssertFalse(isIslamicCalendarLeapYear(25))
		XCTAssertTrue(isIslamicCalendarLeapYear(26))
		XCTAssertFalse(isIslamicCalendarLeapYear(27))
		XCTAssertFalse(isIslamicCalendarLeapYear(28))
		XCTAssertTrue(isIslamicCalendarLeapYear(29))
		XCTAssertFalse(isIslamicCalendarLeapYear(30))
	}
}
