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
		XCTAssertFalse(EthiopianCalendar.isLeapYear(1))
		XCTAssertTrue(EthiopianCalendar.isLeapYear(3))
		XCTAssertTrue(EthiopianCalendar.isLeapYear(7))
		XCTAssertTrue(EthiopianCalendar.isLeapYear(1739))
		XCTAssertFalse(EthiopianCalendar.isLeapYear(1740))
		XCTAssertTrue(EthiopianCalendar.isLeapYear(-1))
		XCTAssertFalse(EthiopianCalendar.isLeapYear(-2))
		XCTAssertTrue(EthiopianCalendar.isLeapYear(2015))
		XCTAssertFalse(EthiopianCalendar.isLeapYear(2016))

		for y in -500...500 {
			let isLeap = EthiopianCalendar.isLeapYear(y)
			let j = EthiopianCalendar.julianDayNumberFrom(year: y, month: 13, day: isLeap ? 6 : 5)
			let d = EthiopianCalendar.dateFromJulianDayNumber(j)
			XCTAssertEqual(d.month, 13)
			XCTAssertEqual(d.day, isLeap ? 6 : 5)
		}
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
		XCTAssertEqual(EthiopianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1), 1724221)
		XCTAssertTrue(EthiopianCalendar.dateFromJulianDayNumber(1724221) == (1, 1, 1))
		XCTAssertEqual(EthiopianCalendar.julianDayNumberFrom(year: 2000, month: 1, day: 1), 2454356)
	}

	func testLimits() {
		XCTAssertEqual(EthiopianCalendar.julianDateFrom(year: -999999, month: 1, day: 1), -363525779.5)
		XCTAssertEqual(EthiopianCalendar.julianDateFrom(year: -99999, month: 1, day: 1), -34800779.5)
		XCTAssertEqual(EthiopianCalendar.julianDateFrom(year: -9999, month: 1, day: 1), -1928279.5)
		XCTAssertEqual(EthiopianCalendar.julianDateFrom(year: 9999, month: 13, day: 5), 5376353.5)
		XCTAssertEqual(EthiopianCalendar.julianDateFrom(year: 99999, month: 13, day: 5), 38248853.5)
		XCTAssertEqual(EthiopianCalendar.julianDateFrom(year: 999999, month: 13, day: 5), 366973853.5)

		XCTAssertTrue(EthiopianCalendar.dateAndTimeFromJulianDate(-363525779.5) == (-999999, 1, 1, 0, 0, 0))
		XCTAssertTrue(EthiopianCalendar.dateAndTimeFromJulianDate(-34800779.5) == (-99999, 1, 1, 0, 0, 0))
		XCTAssertTrue(EthiopianCalendar.dateAndTimeFromJulianDate(-1928279.5) == (-9999, 1, 1, 0, 0, 0))
		XCTAssertTrue(EthiopianCalendar.dateAndTimeFromJulianDate(5376353.5) == (9999, 13, 5, 0, 0, 0))
		XCTAssertTrue(EthiopianCalendar.dateAndTimeFromJulianDate(38248853.5) == (99999, 13, 5, 0, 0, 0))
		XCTAssertTrue(EthiopianCalendar.dateAndTimeFromJulianDate(366973853.5) == (999999, 13, 5, 0, 0, 0))
	}

	func testArithmeticLimits() {
		// Values smaller than this cause an arithmetic overflow in dateFromJulianDayNumber
//		let smallestJDNForEthiopianCalendar = Int.min + 144
		// Values smaller than this cause an arithmetic overflow in julianDayNumberFrom
		let smallestJDNForEthiopianCalendar = Int.min + 384
		var (Y, M, D) = EthiopianCalendar.dateFromJulianDayNumber(smallestJDNForEthiopianCalendar)
		var jdn = EthiopianCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		XCTAssertEqual(smallestJDNForEthiopianCalendar, jdn)

		// Values larger than this cause an arithmetic overflow in dateFromJulianDayNumber
		let largestJDNForEthiopianCalendar = 2305843009213693827
		(Y, M, D) = EthiopianCalendar.dateFromJulianDayNumber(largestJDNForEthiopianCalendar)
		jdn = EthiopianCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		XCTAssertEqual(largestJDNForEthiopianCalendar, jdn)
	}
}
