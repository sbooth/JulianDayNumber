//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//
import XCTest
@testable import JulianDayNumber

final class MacedonianCalendarTests: XCTestCase {
	func testJulianDayNumber() {
		XCTAssertEqual(MacedonianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1), 1607709)
		XCTAssertTrue(MacedonianCalendar.dateFromJulianDayNumber(1607709) == (1, 1, 1))
	}

	func testLimits() {
		XCTAssertEqual(MacedonianCalendar.julianDateFrom(year: -999999, month: 1, day: 1), -363642291.5)
		XCTAssertEqual(MacedonianCalendar.julianDateFrom(year: -99999, month: 1, day: 1), -34917291.5)
		XCTAssertEqual(MacedonianCalendar.julianDateFrom(year: -9999, month: 1, day: 1), -2044791.5)
		XCTAssertEqual(MacedonianCalendar.julianDateFrom(year: 9999, month: 12, day: 31), 5259842.5)
		XCTAssertEqual(MacedonianCalendar.julianDateFrom(year: 99999, month: 12, day: 31), 38132342.5)
		XCTAssertEqual(MacedonianCalendar.julianDateFrom(year: 999999, month: 12, day: 31), 366857342.5)

		XCTAssertTrue(MacedonianCalendar.dateAndTimeFromJulianDate(-363642291.5) == (-999999, 1, 1, 0, 0, 0))
		XCTAssertTrue(MacedonianCalendar.dateAndTimeFromJulianDate(-34917291.5) == (-99999, 1, 1, 0, 0, 0))
		XCTAssertTrue(MacedonianCalendar.dateAndTimeFromJulianDate(-2044791.5) == (-9999, 1, 1, 0, 0, 0))
		XCTAssertTrue(MacedonianCalendar.dateAndTimeFromJulianDate(5259842.5) == (9999, 12, 31, 0, 0, 0))
		XCTAssertTrue(MacedonianCalendar.dateAndTimeFromJulianDate(38132342.5) == (99999, 12, 31, 0, 0, 0))
		XCTAssertTrue(MacedonianCalendar.dateAndTimeFromJulianDate(366857342.5) == (999999, 12, 31, 0, 0, 0))
	}
}
