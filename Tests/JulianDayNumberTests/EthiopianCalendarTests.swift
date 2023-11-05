//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import XCTest
@testable import JulianDayNumber

final class EthiopianCalendarTests: XCTestCase {
	func testDateValidation() {
		XCTAssertTrue(EthiopianCalendar.isDateValid(year: 2015, month: 13, day: 6))
		XCTAssertFalse(EthiopianCalendar.isDateValid(year: 2016, month: 13, day: 6))
	}

	func testLeapYear() {
		XCTAssertTrue(EthiopianCalendar.isLeapYear(2015))
		XCTAssertFalse(EthiopianCalendar.isLeapYear(2016))
	}

	func testMonthCount() {
		XCTAssertEqual(EthiopianCalendar.monthsInYear, 13)
	}

	func testMonthLength() {
		XCTAssertEqual(EthiopianCalendar.daysInMonth(year: 1, month: 1), 30)
		XCTAssertEqual(EthiopianCalendar.daysInMonth(year: 1, month: 2), 30)
		XCTAssertEqual(EthiopianCalendar.daysInMonth(year: 1, month: 3), 30)
		XCTAssertEqual(EthiopianCalendar.daysInMonth(year: 1, month: 4), 30)
		XCTAssertEqual(EthiopianCalendar.daysInMonth(year: 1, month: 5), 30)
		XCTAssertEqual(EthiopianCalendar.daysInMonth(year: 1, month: 6), 30)
		XCTAssertEqual(EthiopianCalendar.daysInMonth(year: 1, month: 7), 30)
		XCTAssertEqual(EthiopianCalendar.daysInMonth(year: 1, month: 8), 30)
		XCTAssertEqual(EthiopianCalendar.daysInMonth(year: 1, month: 9), 30)
		XCTAssertEqual(EthiopianCalendar.daysInMonth(year: 1, month: 10), 30)
		XCTAssertEqual(EthiopianCalendar.daysInMonth(year: 1, month: 11), 30)
		XCTAssertEqual(EthiopianCalendar.daysInMonth(year: 1, month: 12), 30)
		XCTAssertEqual(EthiopianCalendar.daysInMonth(year: 1, month: 13), 5)
		XCTAssertEqual(EthiopianCalendar.daysInMonth(year: 3, month: 13), 6)
	}

	func testJulianDayNumber() {
		XCTAssertEqual(EthiopianCalendar.dateToJulianDayNumber(year: 1, month: 1, day: 1), 1724221)
		XCTAssertTrue(EthiopianCalendar.julianDayNumberToDate(1724221) == (1, 1, 1))
		XCTAssertEqual(EthiopianCalendar.dateToJulianDayNumber(year: 2000, month: 1, day: 1), 2454356)
	}

	func testLimits() {
		XCTAssertEqual(EthiopianCalendar.dateToJulianDate(year: -999999, month: 1, day: 1), -363525779.5)
		XCTAssertEqual(EthiopianCalendar.dateToJulianDate(year: -99999, month: 1, day: 1), -34800779.5)
		XCTAssertEqual(EthiopianCalendar.dateToJulianDate(year: -9999, month: 1, day: 1), -1928279.5)
		XCTAssertEqual(EthiopianCalendar.dateToJulianDate(year: 9999, month: 13, day: 5), 5376353.5)
		XCTAssertEqual(EthiopianCalendar.dateToJulianDate(year: 99999, month: 13, day: 5), 38248853.5)
		XCTAssertEqual(EthiopianCalendar.dateToJulianDate(year: 999999, month: 13, day: 5), 366973853.5)

		XCTAssertTrue(EthiopianCalendar.julianDateToDate(-363525779.5) == (-999999, 1, 1, 0, 0, 0))
		XCTAssertTrue(EthiopianCalendar.julianDateToDate(-34800779.5) == (-99999, 1, 1, 0, 0, 0))
		XCTAssertTrue(EthiopianCalendar.julianDateToDate(-1928279.5) == (-9999, 1, 1, 0, 0, 0))
		XCTAssertTrue(EthiopianCalendar.julianDateToDate(5376353.5) == (9999, 13, 5, 0, 0, 0))
		XCTAssertTrue(EthiopianCalendar.julianDateToDate(38248853.5) == (99999, 13, 5, 0, 0, 0))
		XCTAssertTrue(EthiopianCalendar.julianDateToDate(366973853.5) == (999999, 13, 5, 0, 0, 0))
	}

	func testArithmeticLimits() {
		var Y, M, D, h, m: Int
		var s: Double

		// Values smaller than this cause an arithmetic overflow in julianDayNumberToDate
		let smallestJDNForEthiopianCalendar = -9223372036854775664
		(Y, M, D) = EthiopianCalendar.julianDayNumberToDate(smallestJDNForEthiopianCalendar)
		var jdn = EthiopianCalendar.dateToJulianDayNumber(year: Y, month: M, day: D)
		XCTAssertEqual(smallestJDNForEthiopianCalendar, jdn)

		// Values larger than this cause an arithmetic overflow in julianDayNumberToDate
		let largestJDNForEthiopianCalendar = 2305843009213693827
		(Y, M, D) = EthiopianCalendar.julianDayNumberToDate(largestJDNForEthiopianCalendar)
		jdn = EthiopianCalendar.dateToJulianDayNumber(year: Y, month: M, day: D)
		XCTAssertEqual(largestJDNForEthiopianCalendar, jdn)

		// Values smaller than this cause an arithmetic overflow in julianDateToDate
		let smallestJDForEthiopianCalendar = -0x1.fffffffffffffp+62
		(Y, M, D, h, m, s) = EthiopianCalendar.julianDateToDate(smallestJDForEthiopianCalendar)
		var jd = EthiopianCalendar.dateToJulianDate(year: Y, month: M, day: D, hour: h, minute: m, second: s)
		XCTAssertEqual(smallestJDForEthiopianCalendar, jd)

		// Values larger than this cause an arithmetic overflow in julianDateToDate
		let largestJDForEthiopianCalendar = 0x1.fffffffffffffp+60
		(Y, M, D, h, m, s) = EthiopianCalendar.julianDateToDate(largestJDForEthiopianCalendar)
		jd = EthiopianCalendar.dateToJulianDate(year: Y, month: M, day: D, hour: h, minute: m, second: s)
		XCTAssertEqual(largestJDForEthiopianCalendar, jd)
	}
}
