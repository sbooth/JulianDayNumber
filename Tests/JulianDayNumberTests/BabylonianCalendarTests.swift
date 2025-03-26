//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import XCTest
@testable import JulianDayNumber

final class BabylonianCalendarTests: XCTestCase {
	func testJulianDayNumber() {
		XCTAssertTrue(BabylonianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == 1607558)
		XCTAssertTrue(BabylonianCalendar.julianDayNumberFrom(year: 3, month: 9, day: 27) == 1608529)
		XCTAssertTrue(BabylonianCalendar.dateFromJulianDayNumber(1607558) == (1, 1, 1))
		XCTAssertTrue(BabylonianCalendar.dateFromJulianDayNumber(1608529) == (3, 9, 27))
	}
}
