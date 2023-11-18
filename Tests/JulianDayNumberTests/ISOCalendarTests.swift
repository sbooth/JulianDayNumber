//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import XCTest
@testable import JulianDayNumber

final class ISOCalendarTests: XCTestCase {
	func testWeeksInYear() {
		XCTAssertEqual(ISOCalendar.isoWeeksInYear(2023), 52)
		XCTAssertEqual(ISOCalendar.isoWeeksInYear(2020), 53)
		XCTAssertEqual(ISOCalendar.isoWeeksInYear(2026), 53)
	}

	func testDayOfWeek() {
		XCTAssertEqual(ISOCalendar.isoWeekdayFrom(year: 2023, month: 11, day: 13), 1)
		XCTAssertEqual(ISOCalendar.isoWeekdayFrom(year: 2023, month: 11, day: 14), 2)
		XCTAssertEqual(ISOCalendar.isoWeekdayFrom(year: 2023, month: 11, day: 15), 3)
		XCTAssertEqual(ISOCalendar.isoWeekdayFrom(year: 2023, month: 11, day: 16), 4)
		XCTAssertEqual(ISOCalendar.isoWeekdayFrom(year: 2023, month: 11, day: 17), 5)
		XCTAssertEqual(ISOCalendar.isoWeekdayFrom(year: 2023, month: 11, day: 18), 6)
		XCTAssertEqual(ISOCalendar.isoWeekdayFrom(year: 2023, month: 11, day: 19), 7)
	}

	func testDateFrom() {
		XCTAssertTrue(ISOCalendar.isoDateFrom(year: 2023, month: 11, day: 16) == (2023, 46, 4))
		XCTAssertTrue(ISOCalendar.dateFromISO(year: 2023, week: 46, weekday: 4) == (2023, 11, 16))
	}

	func testJulianDayNumber() {
		XCTAssertEqual(ISOCalendar.julianDayNumberFromDate((2023, 46, 4)), 2460265)
		XCTAssertTrue(ISOCalendar.dateFromJulianDayNumber(2460265) == (2023, 46, 4))
	}
}
