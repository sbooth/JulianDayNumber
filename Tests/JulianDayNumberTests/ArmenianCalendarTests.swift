//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import XCTest
@testable import JulianDayNumber

final class ArmenianCalendarTests: XCTestCase {
	func testJulianDayNumber() {
		XCTAssertEqual(ArmenianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1), 1922868)
		XCTAssertEqual(ArmenianCalendar.julianDayNumberFrom(year: 1473, month: 4, day: 24), 2460261)
		XCTAssertTrue(ArmenianCalendar.dateFromJulianDayNumber(1922868) == (1, 1, 1))
		XCTAssertTrue(ArmenianCalendar.dateFromJulianDayNumber(2460261) == (1473, 4, 24))
	}
}
