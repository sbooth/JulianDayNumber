//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
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
		XCTAssertTrue(GregorianCalendar.isLeapYear(1600))
		XCTAssertTrue(GregorianCalendar.isLeapYear(2000))
		XCTAssertTrue(GregorianCalendar.isLeapYear(2400))
		XCTAssertFalse(GregorianCalendar.isLeapYear(1700))
		XCTAssertFalse(GregorianCalendar.isLeapYear(1800))
		XCTAssertFalse(GregorianCalendar.isLeapYear(1900))
		XCTAssertFalse(GregorianCalendar.isLeapYear(2100))
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
		XCTAssertEqual(GregorianCalendar.dateToJulianDayNumber(year: -999999, month: 1, day: 1), -363521074)
		XCTAssertEqual(GregorianCalendar.dateToJulianDayNumber(year: -99999, month: 1, day: 1), -34802824)
		XCTAssertEqual(GregorianCalendar.dateToJulianDayNumber(year: -9999, month: 1, day: 1), -1930999)
		XCTAssertEqual(GregorianCalendar.dateToJulianDayNumber(year: 9999, month: 12, day: 31), 5373484)
		XCTAssertEqual(GregorianCalendar.dateToJulianDayNumber(year: 99999, month: 12, day: 31), 38245309)
		XCTAssertEqual(GregorianCalendar.dateToJulianDayNumber(year: 999999, month: 12, day: 31), 366963559)
		XCTAssertEqual(GregorianCalendar.dateToJulianDayNumber(year: -4712, month: 1, day: 1), 38)
		XCTAssertEqual(GregorianCalendar.dateToJulianDayNumber(year: -4713, month: 11, day: 23), -1)
		XCTAssertEqual(GregorianCalendar.dateToJulianDayNumber(year: -4713, month: 11, day: 24), 0)
		XCTAssertEqual(GregorianCalendar.dateToJulianDayNumber(year: -4713, month: 11, day: 25), 1)
		XCTAssertEqual(GregorianCalendar.dateToJulianDayNumber(year: 1582, month: 10, day: 4), 2299150)
		XCTAssertEqual(GregorianCalendar.dateToJulianDayNumber(year: 1582, month: 10, day: 15), 2299161)
		XCTAssertEqual(GregorianCalendar.dateToJulianDayNumber(year: 2000, month: 1, day: 1), 2451545)
		XCTAssertEqual(GregorianCalendar.dateToJulianDayNumber(year: -5000, month: 1, day: 1), -105152)

		XCTAssertTrue(GregorianCalendar.julianDayNumberToDate(-363521074) == (-999999, 1, 1))
		XCTAssertTrue(GregorianCalendar.julianDayNumberToDate(-34802824) == (-99999, 1, 1))
		XCTAssertTrue(GregorianCalendar.julianDayNumberToDate(-1930999) == (-9999, 1, 1))
		XCTAssertTrue(GregorianCalendar.julianDayNumberToDate(5373484) == (9999, 12, 31))
		XCTAssertTrue(GregorianCalendar.julianDayNumberToDate(38245309) == (99999, 12, 31))
		XCTAssertTrue(GregorianCalendar.julianDayNumberToDate(366963559) == (999999, 12, 31))
		XCTAssertTrue(GregorianCalendar.julianDayNumberToDate(38) == (-4712, 1, 1))
		XCTAssertTrue(GregorianCalendar.julianDayNumberToDate(-1) == (-4713, 11, 23))
		XCTAssertTrue(GregorianCalendar.julianDayNumberToDate(0) == (-4713, 11, 24))
		XCTAssertTrue(GregorianCalendar.julianDayNumberToDate(1) == (-4713, 11, 25))
		XCTAssertTrue(GregorianCalendar.julianDayNumberToDate(2299150) == (1582, 10, 4))
		XCTAssertTrue(GregorianCalendar.julianDayNumberToDate(2299161) == (1582, 10, 15))
		XCTAssertTrue(GregorianCalendar.julianDayNumberToDate(2451545) == (2000, 1, 1))
		XCTAssertTrue(GregorianCalendar.julianDayNumberToDate(-105152) == (-5000, 1, 1))
	}

	func testLimits() {
		XCTAssertEqual(GregorianCalendar.dateToJulianDate(year: -999999, month: 1, day: 1), -363521074.5)
		XCTAssertEqual(GregorianCalendar.dateToJulianDate(year: -99999, month: 1, day: 1), -34802824.5)
		XCTAssertEqual(GregorianCalendar.dateToJulianDate(year: -9999, month: 1, day: 1), -1930999.5)
		XCTAssertEqual(GregorianCalendar.dateToJulianDate(year: 9999, month: 12, day: 31), 5373483.5)
		XCTAssertEqual(GregorianCalendar.dateToJulianDate(year: 99999, month: 12, day: 31), 38245308.5)
		XCTAssertEqual(GregorianCalendar.dateToJulianDate(year: 999999, month: 12, day: 31), 366963558.5)

		XCTAssertTrue(GregorianCalendar.julianDateToDate(-363521074.5) == (-999999, 1, 1, 0, 0, 0))
		XCTAssertTrue(GregorianCalendar.julianDateToDate(-34802824.5) == (-99999, 1, 1, 0, 0, 0))
		XCTAssertTrue(GregorianCalendar.julianDateToDate(-1930999.5) == (-9999, 1, 1, 0, 0, 0))
		XCTAssertTrue(GregorianCalendar.julianDateToDate(5373483.5) == (9999, 12, 31, 0, 0, 0))
		XCTAssertTrue(GregorianCalendar.julianDateToDate(38245308.5) == (99999, 12, 31, 0, 0, 0))
		XCTAssertTrue(GregorianCalendar.julianDateToDate(366963558.5) == (999999, 12, 31, 0, 0, 0))
	}

	func testArithmeticLimits() {
		var Y, M, D, h, m: Int
		var s: Double

		// Values smaller than this cause an arithmetic overflow in julianDayNumberToDate
		let smallestJDNForGregorianCalendar = -9223372036854719351
		(Y, M, D) = GregorianCalendar.julianDayNumberToDate(smallestJDNForGregorianCalendar)
		var jdn = GregorianCalendar.dateToJulianDayNumber(year: Y, month: M, day: D)
		XCTAssertEqual(smallestJDNForGregorianCalendar, jdn)

		// Values larger than this cause an arithmetic overflow in julianDayNumberToDate
		let largestJDNForGregorianCalendar = 2305795661307959247
		(Y, M, D) = GregorianCalendar.julianDayNumberToDate(largestJDNForGregorianCalendar)
		jdn = GregorianCalendar.dateToJulianDayNumber(year: Y, month: M, day: D)
		XCTAssertEqual(largestJDNForGregorianCalendar, jdn)

		// Values smaller than this cause an arithmetic overflow in julianDateToDate
		let smallestJDForGregorianCalendar = -0x1.fffffffffffc8p+62
		(Y, M, D, h, m, s) = GregorianCalendar.julianDateToDate(smallestJDForGregorianCalendar)
		var jd = GregorianCalendar.dateToJulianDate(year: Y, month: M, day: D, hour: h, minute: m, second: s)
		XCTAssertEqual(smallestJDForGregorianCalendar, jd)

		// Values larger than this cause an arithmetic overflow in julianDateToDate
		let largestJDForGregorianCalendar = 0x1.fffd4eff4e5d7p+60
		(Y, M, D, h, m, s) = GregorianCalendar.julianDateToDate(largestJDForGregorianCalendar)
		jd = GregorianCalendar.dateToJulianDate(year: Y, month: M, day: D, hour: h, minute: m, second: s)
		XCTAssertEqual(largestJDForGregorianCalendar, jd)
	}
}
