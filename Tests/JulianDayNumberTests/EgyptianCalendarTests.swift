//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import XCTest
@testable import JulianDayNumber

final class EgyptianCalendarTests: XCTestCase {
	func testDateValidation() {
		XCTAssertTrue(EgyptianCalendar.isDateValid(year: 1600, month: 2, day: 30))
	}

	func testMonthCount() {
		XCTAssertEqual(EgyptianCalendar.monthsInYear, 13)
	}

	func testMonthLength() {
		XCTAssertEqual(EgyptianCalendar.daysInMonth(month: 1), 30)
		XCTAssertEqual(EgyptianCalendar.daysInMonth(month: 2), 30)
		XCTAssertEqual(EgyptianCalendar.daysInMonth(month: 3), 30)
		XCTAssertEqual(EgyptianCalendar.daysInMonth(month: 4), 30)
		XCTAssertEqual(EgyptianCalendar.daysInMonth(month: 5), 30)
		XCTAssertEqual(EgyptianCalendar.daysInMonth(month: 6), 30)
		XCTAssertEqual(EgyptianCalendar.daysInMonth(month: 7), 30)
		XCTAssertEqual(EgyptianCalendar.daysInMonth(month: 8), 30)
		XCTAssertEqual(EgyptianCalendar.daysInMonth(month: 9), 30)
		XCTAssertEqual(EgyptianCalendar.daysInMonth(month: 10), 30)
		XCTAssertEqual(EgyptianCalendar.daysInMonth(month: 11), 30)
		XCTAssertEqual(EgyptianCalendar.daysInMonth(month: 12), 30)
		XCTAssertEqual(EgyptianCalendar.daysInMonth(month: 13), 5)
	}

	func testJulianDayNumber() {
		// From Richards
		XCTAssertEqual(EgyptianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1), 1448638)
	}

	func testLimits() {
		XCTAssertEqual(EgyptianCalendar.julianDateFrom(year: -999999, month: 1, day: 1), -363551362.5)
		XCTAssertEqual(EgyptianCalendar.julianDateFrom(year: -99999, month: 1, day: 1), -35051362.5)
		XCTAssertEqual(EgyptianCalendar.julianDateFrom(year: -9999, month: 1, day: 1), -2201362.5)
		XCTAssertEqual(EgyptianCalendar.julianDateFrom(year: 9999, month: 13, day: 5), 5098271.5)
		XCTAssertEqual(EgyptianCalendar.julianDateFrom(year: 99999, month: 13, day: 5), 37948271.5)
		XCTAssertEqual(EgyptianCalendar.julianDateFrom(year: 999999, month: 13, day: 5), 366448271.5)

		XCTAssertTrue(EgyptianCalendar.dateAndTimeFromJulianDate(-363551362.5) == (-999999, 1, 1, 0, 0, 0))
		XCTAssertTrue(EgyptianCalendar.dateAndTimeFromJulianDate(-35051362.5) == (-99999, 1, 1, 0, 0, 0))
		XCTAssertTrue(EgyptianCalendar.dateAndTimeFromJulianDate(-2201362.5) == (-9999, 1, 1, 0, 0, 0))
		XCTAssertTrue(EgyptianCalendar.dateAndTimeFromJulianDate(5098271.5) == (9999, 13, 5, 0, 0, 0))
		XCTAssertTrue(EgyptianCalendar.dateAndTimeFromJulianDate(37948271.5) == (99999, 13, 5, 0, 0, 0))
		XCTAssertTrue(EgyptianCalendar.dateAndTimeFromJulianDate(366448271.5) == (999999, 13, 5, 0, 0, 0))
	}

	func testArithmeticLimits() {
		// Values smaller than this cause an arithmetic overflow in dateFromJulianDayNumber
//		let smallestJDNForEgyptianCalendar = Int.min + 1448273
		// Values smaller than this cause an arithmetic overflow in julianDayNumberFrom
		let smallestJDNForEgyptianCalendar = Int.min + 1448566
		var (Y, M, D) = EgyptianCalendar.dateFromJulianDayNumber(smallestJDNForEgyptianCalendar)
		var jdn = EgyptianCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		XCTAssertEqual(smallestJDNForEgyptianCalendar, jdn)

		// Values larger than this cause an arithmetic overflow in dateFromJulianDayNumber
		let largestJDNForEgyptianCalendar = Int.max
		(Y, M, D) = EgyptianCalendar.dateFromJulianDayNumber(largestJDNForEgyptianCalendar)
		jdn = EgyptianCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		XCTAssertEqual(largestJDNForEgyptianCalendar, jdn)
	}
}
