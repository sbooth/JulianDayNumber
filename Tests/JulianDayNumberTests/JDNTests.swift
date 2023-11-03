//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import XCTest
@testable import JulianDayNumber

final class JDNTests: XCTestCase {
	func testJulian() {
		XCTAssertEqual(JulianCalendar.dateToJulianDayNumber(year: -9999, month: 1, day: 1), -1931076)
		XCTAssertEqual(JulianCalendar.dateToJulianDayNumber(year: 99999, month: 12, day: 31), 38246057)
		XCTAssertEqual(JulianCalendar.dateToJulianDayNumber(year: -4713, month: 12, day: 31), -1)
		XCTAssertEqual(JulianCalendar.dateToJulianDayNumber(year: -4712, month: 1, day: 1), 0)
		XCTAssertEqual(JulianCalendar.dateToJulianDayNumber(year: -4712, month: 1, day: 2), 1)
		XCTAssertEqual(JulianCalendar.dateToJulianDayNumber(year: 1582, month: 10, day: 4), 2299160)
		XCTAssertEqual(JulianCalendar.dateToJulianDayNumber(year: 1582, month: 10, day: 15), 2299171)
		XCTAssertEqual(JulianCalendar.dateToJulianDayNumber(year: 2000, month: 1, day: 1), 2451558)
		XCTAssertEqual(JulianCalendar.dateToJulianDayNumber(year: -5000, month: 1, day: 1), -105192)

		XCTAssertTrue(JulianCalendar.julianDayNumberToDate(-1931076) == (-9999, 1, 1))
		XCTAssertTrue(JulianCalendar.julianDayNumberToDate(38246057) == (99999, 12, 31))
		XCTAssertTrue(JulianCalendar.julianDayNumberToDate(-1) == (-4713, 12, 31))
		XCTAssertTrue(JulianCalendar.julianDayNumberToDate(0) == (-4712, 1, 1))
		XCTAssertTrue(JulianCalendar.julianDayNumberToDate(1) == (-4712, 1, 2))
		XCTAssertTrue(JulianCalendar.julianDayNumberToDate(2299160) == (1582, 10, 4))
		XCTAssertTrue(JulianCalendar.julianDayNumberToDate(2299171) == (1582, 10, 15))
		XCTAssertTrue(JulianCalendar.julianDayNumberToDate(2451558) == (2000, 1, 1))
		XCTAssertTrue(JulianCalendar.julianDayNumberToDate(-105192) == (-5000, 1, 1))
	}

	func testGregorian() {
		XCTAssertEqual(GregorianCalendar.dateToJulianDayNumber(year: -9999, month: 1, day: 1), -1930999)
		XCTAssertEqual(GregorianCalendar.dateToJulianDayNumber(year: 99999, month: 12, day: 31), 38245309)
		XCTAssertEqual(GregorianCalendar.dateToJulianDayNumber(year: -4712, month: 1, day: 1), 38)
		XCTAssertEqual(GregorianCalendar.dateToJulianDayNumber(year: -4713, month: 11, day: 23), -1)
		XCTAssertEqual(GregorianCalendar.dateToJulianDayNumber(year: -4713, month: 11, day: 24), 0)
		XCTAssertEqual(GregorianCalendar.dateToJulianDayNumber(year: -4713, month: 11, day: 25), 1)
		XCTAssertEqual(GregorianCalendar.dateToJulianDayNumber(year: 1582, month: 10, day: 4), 2299150)
		XCTAssertEqual(GregorianCalendar.dateToJulianDayNumber(year: 1582, month: 10, day: 15), 2299161)
		XCTAssertEqual(GregorianCalendar.dateToJulianDayNumber(year: 2000, month: 1, day: 1), 2451545)
		XCTAssertEqual(GregorianCalendar.dateToJulianDayNumber(year: -5000, month: 1, day: 1), -105152)

		XCTAssertTrue(GregorianCalendar.julianDayNumberToDate(-1930999) == (-9999, 1, 1))
		XCTAssertTrue(GregorianCalendar.julianDayNumberToDate(38245309) == (99999, 12, 31))
		XCTAssertTrue(GregorianCalendar.julianDayNumberToDate(38) == (-4712, 1, 1))
		XCTAssertTrue(GregorianCalendar.julianDayNumberToDate(-1) == (-4713, 11, 23))
		XCTAssertTrue(GregorianCalendar.julianDayNumberToDate(0) == (-4713, 11, 24))
		XCTAssertTrue(GregorianCalendar.julianDayNumberToDate(1) == (-4713, 11, 25))
		XCTAssertTrue(GregorianCalendar.julianDayNumberToDate(2299150) == (1582, 10, 4))
		XCTAssertTrue(GregorianCalendar.julianDayNumberToDate(2299161) == (1582, 10, 15))
		XCTAssertTrue(GregorianCalendar.julianDayNumberToDate(2451545) == (2000, 1, 1))
		XCTAssertTrue(GregorianCalendar.julianDayNumberToDate(-105152) == (-5000, 1, 1))
	}

	func testAstronomical() {
		XCTAssertEqual(AstronomicalCalendar.dateToJulianDayNumber(year: -9999, month: 1, day: 1), -1931076)
		XCTAssertEqual(AstronomicalCalendar.dateToJulianDayNumber(year: 99999, month: 12, day: 31), 38245309)
		XCTAssertEqual(AstronomicalCalendar.dateToJulianDayNumber(year: -4712, month: 1, day: 1), 0)
		XCTAssertEqual(AstronomicalCalendar.dateToJulianDayNumber(year: 1582, month: 10, day: 4), 2299160)
		XCTAssertEqual(AstronomicalCalendar.dateToJulianDayNumber(year: 1582, month: 10, day: 15), 2299161)
		// NASA (https://ssd.jpl.nasa.gov/tools/jdc/) uses the Gregorian calendar for dates after 1582-10-04.
		// This means that 1582-10-05 through 1582-10-14 are 10 JDN earlier than if the Julian calendar is used.
		// AstronomicalCalendar uses a different rule and uses the Julian calendar for dates before 1582-10-15.
		// I'm not sure why but who wants to argue with NASA?
//		XCTAssertEqual(AstronomicalCalendar.dateToJulianDayNumber(year: 1582, month: 10, day: 7), 2299153)
		XCTAssertEqual(AstronomicalCalendar.dateToJulianDayNumber(year: 2000, month: 1, day: 1), 2451545)
		XCTAssertEqual(AstronomicalCalendar.dateToJulianDayNumber(year: -5000, month: 1, day: 1), -105192)

		XCTAssertTrue(AstronomicalCalendar.julianDayNumberToDate(-1931076) == (-9999, 1, 1))
		XCTAssertTrue(AstronomicalCalendar.julianDayNumberToDate(38245309) == (99999, 12, 31))
		XCTAssertTrue(AstronomicalCalendar.julianDayNumberToDate(0) == (-4712, 1, 1))
		XCTAssertTrue(AstronomicalCalendar.julianDayNumberToDate(2299160) == (1582, 10, 4))
		XCTAssertTrue(AstronomicalCalendar.julianDayNumberToDate(2299161) == (1582, 10, 15))
		XCTAssertTrue(AstronomicalCalendar.julianDayNumberToDate(2451545) == (2000, 1, 1))
		XCTAssertTrue(AstronomicalCalendar.julianDayNumberToDate(-105192) == (-5000, 1, 1))

		XCTAssertEqual(AstronomicalCalendar.dateToJulianDayNumber(year: -9999, month: 1, day: 1), JulianCalendar.dateToJulianDayNumber(year: -9999, month: 1, day: 1))
		XCTAssertNotEqual(AstronomicalCalendar.dateToJulianDayNumber(year: 99999, month: 12, day: 31), JulianCalendar.dateToJulianDayNumber(year: 99999, month: 12, day: 31))
		XCTAssertEqual(AstronomicalCalendar.dateToJulianDayNumber(year: -4712, month: 1, day: 1), JulianCalendar.dateToJulianDayNumber(year: -4712, month: 1, day: 1))
		XCTAssertNotEqual(AstronomicalCalendar.dateToJulianDayNumber(year: 2000, month: 1, day: 1), JulianCalendar.dateToJulianDayNumber(year: 2000, month: 1, day: 1))
	}

	func testIslamic() {
		// From Richards
		XCTAssertEqual(IslamicCalendar.dateToJulianDayNumber(year: 1, month: 1, day: 1), 1948440)
		// From Meeus
		XCTAssertEqual(IslamicCalendar.dateToJulianDayNumber(year: 1421, month: 1, day: 1), 2451641)
	}

	func testGregorianToJulianConversion() {
		XCTAssertEqual(JulianCalendar.dateToJulianDayNumber(year: -9999, month: 1, day: 1), GregorianCalendar.dateToJulianDayNumber(year: -10000, month: 10, day: 16))
		XCTAssertEqual(GregorianCalendar.dateToJulianDayNumber(year: 99999, month: 12, day: 31), JulianCalendar.dateToJulianDayNumber(year: 99997, month: 12, day: 13))
		XCTAssertEqual(JulianCalendar.dateToJulianDayNumber(year: -4712, month: 1, day: 1), GregorianCalendar.dateToJulianDayNumber(year: -4713, month: 11, day: 24))
		XCTAssertEqual(JulianCalendar.dateToJulianDayNumber(year: 1582, month: 10, day: 4), GregorianCalendar.dateToJulianDayNumber(year: 1582, month: 10, day: 14))
		XCTAssertEqual(GregorianCalendar.dateToJulianDayNumber(year: 1582, month: 10, day: 15), JulianCalendar.dateToJulianDayNumber(year: 1582, month: 10, day: 5))
	}

	func testArithmeticLimits() {
		var y,m,d: Int
		var jdn: Int

		// Arithmetic limits for JDN to Julian calendar date conversion using 64-bit integers

		precondition(Int.bitWidth == 64, "Arithmetic limit testing requires 64-bit integers")

		// Values smaller than this cause an arithmetic overflow in JulianCalendar.julianDayNumberToDate
		let smallestJDNForJulianCalendar = -9223372036854775664
		(y,m,d) = JulianCalendar.julianDayNumberToDate(smallestJDNForJulianCalendar)
		jdn = JulianCalendar.dateToJulianDayNumber(year: y, month: m, day: d)
		XCTAssertEqual(smallestJDNForJulianCalendar, jdn)

		// Values larger than this cause an arithmetic overflow in JulianCalendar.julianDayNumberToDate
		let largestJDNForJulianCalendar = 2305843009213692550
		(y,m,d) = JulianCalendar.julianDayNumberToDate(largestJDNForJulianCalendar)
		jdn = JulianCalendar.dateToJulianDayNumber(year: y, month: m, day: d)
		XCTAssertEqual(largestJDNForJulianCalendar, jdn)

		// Arithmetic limits for JDN to Gregorian calendar date conversion using 64-bit integers

		// Values smaller than this cause an arithmetic overflow in GregorianCalendar.julianDayNumberToDate
		let smallestJDNForGregorianCalendar = -9223372036854719351
		(y,m,d) = GregorianCalendar.julianDayNumberToDate(smallestJDNForGregorianCalendar)
		jdn = GregorianCalendar.dateToJulianDayNumber(year: y, month: m, day: d)
		XCTAssertEqual(smallestJDNForGregorianCalendar, jdn)

		// Values larger than this cause an arithmetic overflow in GregorianCalendar.julianDayNumberToDate
		let largestJDNForGregorianCalendar = 2305795661307959247
		(y,m,d) = GregorianCalendar.julianDayNumberToDate(largestJDNForGregorianCalendar)
		jdn = GregorianCalendar.dateToJulianDayNumber(year: y, month: m, day: d)
		XCTAssertEqual(largestJDNForGregorianCalendar, jdn)

		// Arithmetic limits for JDN to Islamic calendar date conversion using 64-bit integers

		// Values smaller than this cause an arithmetic overflow in IslamicCalendar.julianDayNumberToDate
		let smallestJDNForIslamicCalendar = -9223372036854775352
		(y,m,d) = IslamicCalendar.julianDayNumberToDate(smallestJDNForIslamicCalendar)
		jdn = IslamicCalendar.dateToJulianDayNumber(year: y, month: m, day: d)
		XCTAssertEqual(smallestJDNForIslamicCalendar, jdn)

		// Values larger than this cause an arithmetic overflow in IslamicCalendar.julianDayNumberToDate
		let largestJDNForIslamicCalendar = 307445734561818195
		(y,m,d) = IslamicCalendar.julianDayNumberToDate(largestJDNForIslamicCalendar)
		jdn = IslamicCalendar.dateToJulianDayNumber(year: y, month: m, day: d)
		XCTAssertEqual(largestJDNForIslamicCalendar, jdn)
	}
}
