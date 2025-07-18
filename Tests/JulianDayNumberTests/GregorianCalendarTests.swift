//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import XCTest
@testable import JulianDayNumber

final class GregorianCalendarTests: XCTestCase {
	func testDateValidation() {
		XCTAssertTrue(GregorianCalendar.isDateValid(year: 1600, month: 2, day: 29))
		XCTAssertFalse(GregorianCalendar.isDateValid(year: 1700, month: 2, day: 29))
	}

	func testLeapYear() {
		XCTAssertTrue(GregorianCalendar.isLeapYear(4))
		XCTAssertFalse(GregorianCalendar.isLeapYear(100))
		XCTAssertTrue(GregorianCalendar.isLeapYear(1600))
		XCTAssertFalse(GregorianCalendar.isLeapYear(1700))
		XCTAssertFalse(GregorianCalendar.isLeapYear(1800))
		XCTAssertFalse(GregorianCalendar.isLeapYear(1900))
		XCTAssertTrue(GregorianCalendar.isLeapYear(2000))
		XCTAssertFalse(GregorianCalendar.isLeapYear(2100))
		XCTAssertTrue(GregorianCalendar.isLeapYear(2400))
		XCTAssertFalse(GregorianCalendar.isLeapYear(-3))
		XCTAssertTrue(GregorianCalendar.isLeapYear(-4))
		XCTAssertTrue(GregorianCalendar.isLeapYear(-8))
		XCTAssertFalse(GregorianCalendar.isLeapYear(-100))

		for y in 1583...2500 {
			let isLeap = GregorianCalendar.isLeapYear(y)
			let j = GregorianCalendar.julianDayNumberFrom(year: y, month: 2, day: isLeap ? 29 : 28)
			let d = GregorianCalendar.dateFromJulianDayNumber(j)
			XCTAssertEqual(d.month, 2)
			XCTAssertEqual(d.day, isLeap ? 29 : 28)
		}
	}

	func testMonthCount() {
		XCTAssertEqual(GregorianCalendar.monthsInYear, 12)
	}

	func testMonthLength() {
		XCTAssertEqual(GregorianCalendar.daysInMonth(year: 1600, month: 2), 29)
		XCTAssertEqual(GregorianCalendar.daysInMonth(year: 1700, month: 2), 28)
	}

	func testEaster() {
		// Dates from Meeus (1998)
		XCTAssertTrue(GregorianCalendar.easter(year: 1991) == (3, 31))
		XCTAssertTrue(GregorianCalendar.easter(year: 1992) == (4, 19))
		XCTAssertTrue(GregorianCalendar.easter(year: 1993) == (4, 11))
		XCTAssertTrue(GregorianCalendar.easter(year: 1954) == (4, 18))
		XCTAssertTrue(GregorianCalendar.easter(year: 2000) == (4, 23))
		XCTAssertTrue(GregorianCalendar.easter(year: 1818) == (3, 22))
	}

	func testJulianDayNumber() {
		XCTAssertEqual(GregorianCalendar.julianDayNumberFrom(year: -999999, month: 1, day: 1), -363521074)
		XCTAssertEqual(GregorianCalendar.julianDayNumberFrom(year: -99999, month: 1, day: 1), -34802824)
		XCTAssertEqual(GregorianCalendar.julianDayNumberFrom(year: -9999, month: 1, day: 1), -1930999)
		XCTAssertEqual(GregorianCalendar.julianDayNumberFrom(year: 9999, month: 12, day: 31), 5373484)
		XCTAssertEqual(GregorianCalendar.julianDayNumberFrom(year: 99999, month: 12, day: 31), 38245309)
		XCTAssertEqual(GregorianCalendar.julianDayNumberFrom(year: 999999, month: 12, day: 31), 366963559)
		XCTAssertEqual(GregorianCalendar.julianDayNumberFrom(year: -4712, month: 1, day: 1), 38)
		XCTAssertEqual(GregorianCalendar.julianDayNumberFrom(year: -4713, month: 11, day: 23), -1)
		XCTAssertEqual(GregorianCalendar.julianDayNumberFrom(year: -4713, month: 11, day: 24), 0)
		XCTAssertEqual(GregorianCalendar.julianDayNumberFrom(year: -4713, month: 11, day: 25), 1)
		XCTAssertEqual(GregorianCalendar.julianDayNumberFrom(year: 1582, month: 10, day: 4), 2299150)
		XCTAssertEqual(GregorianCalendar.julianDayNumberFrom(year: 1582, month: 10, day: 15), 2299161)
		XCTAssertEqual(GregorianCalendar.julianDayNumberFrom(year: 2000, month: 1, day: 1), 2451545)
		XCTAssertEqual(GregorianCalendar.julianDayNumberFrom(year: -5000, month: 1, day: 1), -105152)

		XCTAssertTrue(GregorianCalendar.dateFromJulianDayNumber(-363521074) == (-999999, 1, 1))
		XCTAssertTrue(GregorianCalendar.dateFromJulianDayNumber(-34802824) == (-99999, 1, 1))
		XCTAssertTrue(GregorianCalendar.dateFromJulianDayNumber(-1930999) == (-9999, 1, 1))
		XCTAssertTrue(GregorianCalendar.dateFromJulianDayNumber(5373484) == (9999, 12, 31))
		XCTAssertTrue(GregorianCalendar.dateFromJulianDayNumber(38245309) == (99999, 12, 31))
		XCTAssertTrue(GregorianCalendar.dateFromJulianDayNumber(366963559) == (999999, 12, 31))
		XCTAssertTrue(GregorianCalendar.dateFromJulianDayNumber(38) == (-4712, 1, 1))
		XCTAssertTrue(GregorianCalendar.dateFromJulianDayNumber(-1) == (-4713, 11, 23))
		XCTAssertTrue(GregorianCalendar.dateFromJulianDayNumber(0) == (-4713, 11, 24))
		XCTAssertTrue(GregorianCalendar.dateFromJulianDayNumber(1) == (-4713, 11, 25))
		XCTAssertTrue(GregorianCalendar.dateFromJulianDayNumber(2299150) == (1582, 10, 4))
		XCTAssertTrue(GregorianCalendar.dateFromJulianDayNumber(2299161) == (1582, 10, 15))
		XCTAssertTrue(GregorianCalendar.dateFromJulianDayNumber(2451545) == (2000, 1, 1))
		XCTAssertTrue(GregorianCalendar.dateFromJulianDayNumber(-105152) == (-5000, 1, 1))
	}

	func testLimits() {
		XCTAssertEqual(GregorianCalendar.julianDateFrom(year: -999999, month: 1, day: 1), -363521074.5)
		XCTAssertEqual(GregorianCalendar.julianDateFrom(year: -99999, month: 1, day: 1), -34802824.5)
		XCTAssertEqual(GregorianCalendar.julianDateFrom(year: -9999, month: 1, day: 1), -1930999.5)
		XCTAssertEqual(GregorianCalendar.julianDateFrom(year: 9999, month: 12, day: 31), 5373483.5)
		XCTAssertEqual(GregorianCalendar.julianDateFrom(year: 99999, month: 12, day: 31), 38245308.5)
		XCTAssertEqual(GregorianCalendar.julianDateFrom(year: 999999, month: 12, day: 31), 366963558.5)

		XCTAssertTrue(GregorianCalendar.dateAndTimeFromJulianDate(-363521074.5) == (-999999, 1, 1, 0, 0, 0))
		XCTAssertTrue(GregorianCalendar.dateAndTimeFromJulianDate(-34802824.5) == (-99999, 1, 1, 0, 0, 0))
		XCTAssertTrue(GregorianCalendar.dateAndTimeFromJulianDate(-1930999.5) == (-9999, 1, 1, 0, 0, 0))
		XCTAssertTrue(GregorianCalendar.dateAndTimeFromJulianDate(5373483.5) == (9999, 12, 31, 0, 0, 0))
		XCTAssertTrue(GregorianCalendar.dateAndTimeFromJulianDate(38245308.5) == (99999, 12, 31, 0, 0, 0))
		XCTAssertTrue(GregorianCalendar.dateAndTimeFromJulianDate(366963558.5) == (999999, 12, 31, 0, 0, 0))
	}

	func testArithmeticLimits() {
		// Values smaller than this cause an arithmetic overflow in dateFromJulianDayNumber
		let smallestJDNForGregorianCalendar: JulianDayNumber = .min + 56457
		var (Y, M, D) = GregorianCalendar.dateFromJulianDayNumber(smallestJDNForGregorianCalendar)
		var jdn = GregorianCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		XCTAssertEqual(smallestJDNForGregorianCalendar, jdn)

		// Values larger than this cause an arithmetic overflow in dateFromJulianDayNumber
		let largestJDNForGregorianCalendar: JulianDayNumber = 2305795661307959247
		(Y, M, D) = GregorianCalendar.dateFromJulianDayNumber(largestJDNForGregorianCalendar)
		jdn = GregorianCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		XCTAssertEqual(largestJDNForGregorianCalendar, jdn)
	}
}
