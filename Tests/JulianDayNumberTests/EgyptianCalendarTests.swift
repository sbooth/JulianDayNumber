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
		XCTAssertEqual(EgyptianCalendar.dateToJulianDayNumber(year: 1, month: 1, day: 1), 1448638)
	}

	func testLimits() {
		XCTAssertEqual(EgyptianCalendar.dateToJulianDate(year: -999999, month: 1, day: 1), -363551362.5)
		XCTAssertEqual(EgyptianCalendar.dateToJulianDate(year: -99999, month: 1, day: 1), -35051362.5)
		XCTAssertEqual(EgyptianCalendar.dateToJulianDate(year: -9999, month: 1, day: 1), -2201362.5)
		XCTAssertEqual(EgyptianCalendar.dateToJulianDate(year: 9999, month: 13, day: 5), 5098271.5)
		XCTAssertEqual(EgyptianCalendar.dateToJulianDate(year: 99999, month: 13, day: 5), 37948271.5)
		XCTAssertEqual(EgyptianCalendar.dateToJulianDate(year: 999999, month: 13, day: 5), 366448271.5)

		XCTAssertTrue(EgyptianCalendar.julianDateToDate(-363551362.5) == (-999999, 1, 1, 0, 0, 0))
		XCTAssertTrue(EgyptianCalendar.julianDateToDate(-35051362.5) == (-99999, 1, 1, 0, 0, 0))
		XCTAssertTrue(EgyptianCalendar.julianDateToDate(-2201362.5) == (-9999, 1, 1, 0, 0, 0))
		XCTAssertTrue(EgyptianCalendar.julianDateToDate(5098271.5) == (9999, 13, 5, 0, 0, 0))
		XCTAssertTrue(EgyptianCalendar.julianDateToDate(37948271.5) == (99999, 13, 5, 0, 0, 0))
		XCTAssertTrue(EgyptianCalendar.julianDateToDate(366448271.5) == (999999, 13, 5, 0, 0, 0))
	}

	func testArithmeticLimits() {
		var Y, M, D, h, m: Int
		var s: Double

		// Values smaller than this cause an arithmetic overflow in julianDayNumberToDate
		let smallestJDNForEgyptianCalendar = -9223372036854775514
		(Y, M, D) = EgyptianCalendar.julianDayNumberToDate(smallestJDNForEgyptianCalendar)
		var jdn = EgyptianCalendar.dateToJulianDayNumber(year: Y, month: M, day: D)
		XCTAssertEqual(smallestJDNForEgyptianCalendar, jdn)

		// Values larger than this cause an arithmetic overflow in julianDayNumberToDate
		let largestJDNForEgyptianCalendar = 9223372036854775760
		(Y, M, D) = EgyptianCalendar.julianDayNumberToDate(largestJDNForEgyptianCalendar)
		jdn = EgyptianCalendar.dateToJulianDayNumber(year: Y, month: M, day: D)
		XCTAssertEqual(largestJDNForEgyptianCalendar, jdn)

		// Values smaller than this cause an arithmetic overflow in julianDateToDate
		let smallestJDForEgyptianCalendar = -0x1.fffffffffffffp+62
		(Y, M, D, h, m, s) = EgyptianCalendar.julianDateToDate(smallestJDForEgyptianCalendar)
		var jd = EgyptianCalendar.dateToJulianDate(year: Y, month: M, day: D, hour: h, minute: m, second: s)
		XCTAssertEqual(smallestJDForEgyptianCalendar, jd)

		// Values larger than this cause an arithmetic overflow in julianDateToDate
		let largestJDForEgyptianCalendar = 0x1.fffffffffffffp+62
		(Y, M, D, h, m, s) = EgyptianCalendar.julianDateToDate(largestJDForEgyptianCalendar)
		jd = EgyptianCalendar.dateToJulianDate(year: Y, month: M, day: D, hour: h, minute: m, second: s)
		XCTAssertEqual(largestJDForEgyptianCalendar, jd)
	}
}
