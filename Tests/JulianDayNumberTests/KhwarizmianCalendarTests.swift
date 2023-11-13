//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import XCTest
@testable import JulianDayNumber

final class KhwarizmianCalendarTests: XCTestCase {
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
}
