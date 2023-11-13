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

	func testLimits() {
		XCTAssertEqual(ArmenianCalendar.julianDateFrom(year: -999999, month: 1, day: 1), -363077132.5)
		XCTAssertEqual(ArmenianCalendar.julianDateFrom(year: -99999, month: 1, day: 1), -34577132.5)
		XCTAssertEqual(ArmenianCalendar.julianDateFrom(year: -9999, month: 1, day: 1), -1727132.5)
		XCTAssertEqual(ArmenianCalendar.julianDateFrom(year: 9999, month: 13, day: 5), 5572501.5)
		XCTAssertEqual(ArmenianCalendar.julianDateFrom(year: 99999, month: 13, day: 5), 38422501.5)
		XCTAssertEqual(ArmenianCalendar.julianDateFrom(year: 999999, month: 13, day: 5), 366922501.5)

		XCTAssertTrue(ArmenianCalendar.dateAndTimeFromJulianDate(-363077132.5) == (-999999, 1, 1, 0, 0, 0))
		XCTAssertTrue(ArmenianCalendar.dateAndTimeFromJulianDate(-34577132.5) == (-99999, 1, 1, 0, 0, 0))
		XCTAssertTrue(ArmenianCalendar.dateAndTimeFromJulianDate(-1727132.5) == (-9999, 1, 1, 0, 0, 0))
		XCTAssertTrue(ArmenianCalendar.dateAndTimeFromJulianDate(5572501.5) == (9999, 13, 5, 0, 0, 0))
		XCTAssertTrue(ArmenianCalendar.dateAndTimeFromJulianDate(38422501.5) == (99999, 13, 5, 0, 0, 0))
		XCTAssertTrue(ArmenianCalendar.dateAndTimeFromJulianDate(366922501.5) == (999999, 13, 5, 0, 0, 0))
	}
}
