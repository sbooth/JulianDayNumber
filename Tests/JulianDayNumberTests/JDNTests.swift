//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import XCTest
@testable import JulianDayNumber

final class JDNTests: XCTestCase {
	func testJDN() {
		XCTAssertEqual(JDN(year: -9999, month: 1, day: 1), -1931076)
		XCTAssertEqual(JDN(year: 99999, month: 12, day: 31), 38245309)
		XCTAssertEqual(JDN(year: -4712, month: 1, day: 1), 0)
		XCTAssertEqual(JDN(year: 1582, month: 10, day: 4), 2299160)
		XCTAssertEqual(JDN(year: 1582, month: 10, day: 15), 2299161)
		XCTAssertEqual(JDN(year: 2000, month: 1, day: 1), 2451545)
		XCTAssertEqual(JDN(year: -5000, month: 1, day: 1), -105192)

		XCTAssertTrue(JDN(-1931076).toDate() == (-9999, 1, 1))
		XCTAssertTrue(JDN(38245309).toDate() == (99999, 12, 31))
		XCTAssertTrue(JDN(0).toDate() == (-4712, 1, 1))
		XCTAssertTrue(JDN(2299160).toDate() == (1582, 10, 4))
		XCTAssertTrue(JDN(2299161).toDate() == (1582, 10, 15))
		XCTAssertTrue(JDN(2451545).toDate() == (2000, 1, 1))
		XCTAssertTrue(JDN(-105192).toDate() == (-5000, 1, 1))

		XCTAssertEqual(JDN(year: -9999, month: 1, day: 1), JDN(year: -9999, month: 1, day: 1, calendar: .julian))
		XCTAssertNotEqual(JDN(year: 99999, month: 12, day: 31), JDN(year: 99999, month: 12, day: 31, calendar: .julian))
		XCTAssertEqual(JDN(year: -4712, month: 1, day: 1), JDN(year: -4712, month: 1, day: 1, calendar: .julian))
		XCTAssertNotEqual(JDN(year: 2000, month: 1, day: 1), JDN(year: 2000, month: 1, day: 1, calendar: .julian))
	}

	func testJDNJulian() {
		XCTAssertEqual(julianCalendarDateToJulianDayNumber(year: -9999, month: 1, day: 1), -1931076)
		XCTAssertEqual(julianCalendarDateToJulianDayNumber(year: 99999, month: 12, day: 31), 38246057)
		XCTAssertEqual(julianCalendarDateToJulianDayNumber(year: -4713, month: 12, day: 31), -1)
		XCTAssertEqual(julianCalendarDateToJulianDayNumber(year: -4712, month: 1, day: 1), 0)
		XCTAssertEqual(julianCalendarDateToJulianDayNumber(year: -4712, month: 1, day: 2), 1)
		XCTAssertEqual(julianCalendarDateToJulianDayNumber(year: 1582, month: 10, day: 4), 2299160)
		XCTAssertEqual(julianCalendarDateToJulianDayNumber(year: 1582, month: 10, day: 15), 2299171)
		XCTAssertEqual(julianCalendarDateToJulianDayNumber(year: 2000, month: 1, day: 1), 2451558)
		XCTAssertEqual(julianCalendarDateToJulianDayNumber(year: -5000, month: 1, day: 1), -105192)

		XCTAssertTrue(julianDayNumberToJulianCalendarDate(-1931076) == (-9999, 1, 1))
		XCTAssertTrue(julianDayNumberToJulianCalendarDate(38246057) == (99999, 12, 31))
		XCTAssertTrue(julianDayNumberToJulianCalendarDate(-1) == (-4713, 12, 31))
		XCTAssertTrue(julianDayNumberToJulianCalendarDate(0) == (-4712, 1, 1))
		XCTAssertTrue(julianDayNumberToJulianCalendarDate(1) == (-4712, 1, 2))
		XCTAssertTrue(julianDayNumberToJulianCalendarDate(2299160) == (1582, 10, 4))
		XCTAssertTrue(julianDayNumberToJulianCalendarDate(2299171) == (1582, 10, 15))
		XCTAssertTrue(julianDayNumberToJulianCalendarDate(2451558) == (2000, 1, 1))
		XCTAssertTrue(julianDayNumberToJulianCalendarDate(-105192) == (-5000, 1, 1))
	}

	func testJDNGregorian() {
		XCTAssertEqual(gregorianCalendarDateToJulianDayNumber(year: -9999, month: 1, day: 1), -1930999)
		XCTAssertEqual(gregorianCalendarDateToJulianDayNumber(year: 99999, month: 12, day: 31), 38245309)
		XCTAssertEqual(gregorianCalendarDateToJulianDayNumber(year: -4712, month: 1, day: 1), 38)
		XCTAssertEqual(gregorianCalendarDateToJulianDayNumber(year: -4713, month: 11, day: 23), -1)
		XCTAssertEqual(gregorianCalendarDateToJulianDayNumber(year: -4713, month: 11, day: 24), 0)
		XCTAssertEqual(gregorianCalendarDateToJulianDayNumber(year: -4713, month: 11, day: 25), 1)
		XCTAssertEqual(gregorianCalendarDateToJulianDayNumber(year: 1582, month: 10, day: 4), 2299150)
		XCTAssertEqual(gregorianCalendarDateToJulianDayNumber(year: 1582, month: 10, day: 15), 2299161)
		XCTAssertEqual(gregorianCalendarDateToJulianDayNumber(year: 2000, month: 1, day: 1), 2451545)
		XCTAssertEqual(gregorianCalendarDateToJulianDayNumber(year: -5000, month: 1, day: 1), -105152)

		XCTAssertTrue(julianDayNumberToGregorianCalendarDate(-1930999) == (-9999, 1, 1))
		XCTAssertTrue(julianDayNumberToGregorianCalendarDate(38245309) == (99999, 12, 31))
		XCTAssertTrue(julianDayNumberToGregorianCalendarDate(38) == (-4712, 1, 1))
		XCTAssertTrue(julianDayNumberToGregorianCalendarDate(-1) == (-4713, 11, 23))
		XCTAssertTrue(julianDayNumberToGregorianCalendarDate(0) == (-4713, 11, 24))
		XCTAssertTrue(julianDayNumberToGregorianCalendarDate(1) == (-4713, 11, 25))
		XCTAssertTrue(julianDayNumberToGregorianCalendarDate(2299150) == (1582, 10, 4))
		XCTAssertTrue(julianDayNumberToGregorianCalendarDate(2299161) == (1582, 10, 15))
		XCTAssertTrue(julianDayNumberToGregorianCalendarDate(2451545) == (2000, 1, 1))
		XCTAssertTrue(julianDayNumberToGregorianCalendarDate(-105152) == (-5000, 1, 1))
	}

	func testJDNGregorianToJulianConversion() {
		XCTAssertEqual(julianCalendarDateToJulianDayNumber(year: -9999, month: 1, day: 1), gregorianCalendarDateToJulianDayNumber(year: -10000, month: 10, day: 16))
		XCTAssertEqual(gregorianCalendarDateToJulianDayNumber(year: 99999, month: 12, day: 31), julianCalendarDateToJulianDayNumber(year: 99997, month: 12, day: 13))
		XCTAssertEqual(julianCalendarDateToJulianDayNumber(year: -4712, month: 1, day: 1), gregorianCalendarDateToJulianDayNumber(year: -4713, month: 11, day: 24))
		XCTAssertEqual(julianCalendarDateToJulianDayNumber(year: 1582, month: 10, day: 4), gregorianCalendarDateToJulianDayNumber(year: 1582, month: 10, day: 14))
		XCTAssertEqual(gregorianCalendarDateToJulianDayNumber(year: 1582, month: 10, day: 15), julianCalendarDateToJulianDayNumber(year: 1582, month: 10, day: 5))
	}

	func testExtremes() {
		var y,m,d: Int
		var jdn: Int

		// Arithmetic limits for JDN to Julian calendar date conversion using 64-bit integers

//		guard Int.bitWidth == 64 else {
//			return
//		}

		// Values smaller than this cause an arithmetic overflow in julianDayNumberToJulianCalendarDate
		let smallestJDNForJulianCalendar = -9223372036854775664
		(y,m,d) = julianDayNumberToJulianCalendarDate(smallestJDNForJulianCalendar)
		jdn = julianCalendarDateToJulianDayNumber(year: y, month: m, day: d)
		XCTAssertEqual(smallestJDNForJulianCalendar, jdn)

		// Values larger than this cause an arithmetic overflow in julianDayNumberToJulianCalendarDate
		let largestJDNForJulianCalendar = 2305843009213692550
		(y,m,d) = julianDayNumberToJulianCalendarDate(largestJDNForJulianCalendar)
		jdn = julianCalendarDateToJulianDayNumber(year: y, month: m, day: d)
		XCTAssertEqual(largestJDNForJulianCalendar, jdn)

		// Arithmetic limits for JDN to Gregorian calendar date conversion using 64-bit integers

		// Values smaller than this cause an arithmetic overflow in julianDayNumberToGregorianCalendarDate
		let smallestJDNForGregorianCalendar = -9223372036854719351
		(y,m,d) = julianDayNumberToGregorianCalendarDate(smallestJDNForGregorianCalendar)
		jdn = gregorianCalendarDateToJulianDayNumber(year: y, month: m, day: d)
		XCTAssertEqual(smallestJDNForGregorianCalendar, jdn)

		// Values larger than this cause an arithmetic overflow in julianDayNumberToGregorianCalendarDate
		let largestJDNForGregorianCalendar = 2305795661307959247
		(y,m,d) = julianDayNumberToGregorianCalendarDate(largestJDNForGregorianCalendar)
		jdn = gregorianCalendarDateToJulianDayNumber(year: y, month: m, day: d)
		XCTAssertEqual(largestJDNForGregorianCalendar, jdn)

		// Arithmetic limits for JDN to Islamic calendar date conversion using 64-bit integers

		// Values smaller than this cause an arithmetic overflow in julianDayNumberToIslamicCalendarDate
		let smallestJDNForIslamicCalendar = -9223372036854775352
		(y,m,d) = julianDayNumberToIslamicCalendarDate(smallestJDNForIslamicCalendar)
		jdn = islamicCalendarDateToJulianDayNumber(year: y, month: m, day: d)
		XCTAssertEqual(smallestJDNForIslamicCalendar, jdn)

		// Values larger than this cause an arithmetic overflow in julianDayNumberToIslamicCalendarDate
		let largestJDNForIslamicCalendar = 307445734561818195
		(y,m,d) = julianDayNumberToIslamicCalendarDate(largestJDNForIslamicCalendar)
		jdn = islamicCalendarDateToJulianDayNumber(year: y, month: m, day: d)
		XCTAssertEqual(largestJDNForIslamicCalendar, jdn)
	}

	func testJDNIslamic() {
		// From Richards
		XCTAssertEqual(islamicCalendarDateToJulianDayNumber(year: 1, month: 1, day: 1), 1948440)
		// From Meeus
		XCTAssertEqual(islamicCalendarDateToJulianDayNumber(year: 1421, month: 1, day: 1), 2451641)
	}
}
