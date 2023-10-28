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
}
