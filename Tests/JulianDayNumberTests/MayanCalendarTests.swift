//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import XCTest
@testable import JulianDayNumber

final class MayanCalendarTests: XCTestCase {
	func testLongCount() {
		XCTAssertTrue(MayanCalendar.longCountFromJulianDayNumber(584286) == (0, 0, 0, 0, 3))
		XCTAssertTrue(MayanCalendar.longCountFromJulianDayNumber(584285) == (0, 0, 0, 0, 2))
		XCTAssertTrue(MayanCalendar.longCountFromJulianDayNumber(584284) == (0, 0, 0, 0, 1))
		XCTAssertTrue(MayanCalendar.longCountFromJulianDayNumber(584283) == (0, 0, 0, 0, 0))
		XCTAssertTrue(MayanCalendar.longCountFromJulianDayNumber(584282) == (-1, 19, 19, 17, 19))
		XCTAssertTrue(MayanCalendar.longCountFromJulianDayNumber(584281) == (-1, 19, 19, 17, 18))
		XCTAssertTrue(MayanCalendar.longCountFromJulianDayNumber(584280) == (-1, 19, 19, 17, 17))

		XCTAssertTrue(MayanCalendar.longCountFromJulianDayNumber(300) == (-5, 18, 17, 14, 17))
		XCTAssertTrue(MayanCalendar.longCountFromJulianDayNumber(3) == (-5, 18, 17, 0, 0))
		XCTAssertTrue(MayanCalendar.longCountFromJulianDayNumber(2) == (-5, 18, 16, 17, 19))
		XCTAssertTrue(MayanCalendar.longCountFromJulianDayNumber(1) == (-5, 18, 16, 17, 18))
		XCTAssertTrue(MayanCalendar.longCountFromJulianDayNumber(0) == (-5, 18, 16, 17, 17))
		XCTAssertTrue(MayanCalendar.longCountFromJulianDayNumber(-1) == (-5, 18, 16, 17, 16))
		XCTAssertTrue(MayanCalendar.longCountFromJulianDayNumber(-2) == (-5, 18, 16, 17, 15))
		XCTAssertTrue(MayanCalendar.longCountFromJulianDayNumber(-3) == (-5, 18, 16, 17, 14))
		XCTAssertTrue(MayanCalendar.longCountFromJulianDayNumber(-300) == (-5, 18, 16, 2, 17))

		XCTAssertEqual(MayanCalendar.julianDayNumberFromLongCount(baktun: 0, katun: 0, tun: 0, uinal: 0, kin: 0), 584283)

		XCTAssertEqual(MayanCalendar.julianDayNumberFromLongCount(baktun: 0, katun: 0, tun: 0, uinal: -1, kin: 19), MayanCalendar.julianDayNumberFromLongCount(baktun: 0, katun: 0, tun: -1, uinal: 17, kin: 19))
	}

	func testRoundDate() {
		XCTAssertTrue(MayanCalendar.calendarRoundFromJulianDayNumber(MayanCalendar.longCountEpochJulianDayNumber) == (4, .ahau, 8, .cumku))
		XCTAssertTrue(MayanCalendar.calendarRoundFromJulianDayNumber(2460260) == (3, .caban, 5, .ceh))
	}
}
