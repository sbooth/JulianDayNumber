//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import XCTest
@testable import JulianDayNumber

final class JDTests: XCTestCase {
	func testJD() {
		// Values from Meeus (1998)
		XCTAssertEqual(calendarDateToJulianDate(year: 2000, month: 1, day: 1.5), 2451545)
		XCTAssertEqual(calendarDateToJulianDate(year: 1999, month: 1, day: 1), 2451179.5)
		XCTAssertEqual(calendarDateToJulianDate(year: 1987, month: 1, day: 27, hour: 0), 2446822.5)
		XCTAssertEqual(calendarDateToJulianDate(year: 1987, month: 6, day: 19.5), 2446966)
		XCTAssertEqual(calendarDateToJulianDate(year: 1988, month: 1, day: 27), 2447187.5)
		XCTAssertEqual(calendarDateToJulianDate(year: 1988, month: 6, day: 19, hour: 12), 2447332.0)
		XCTAssertEqual(calendarDateToJulianDate(year: 1900, month: 1, day: 1), 2415020.5)
		XCTAssertEqual(calendarDateToJulianDate(year: 1600, month: 1, day: 1), 2305447.5)
		XCTAssertEqual(calendarDateToJulianDate(year: 1600, month: 12, day: 31), 2305812.5)
		XCTAssertEqual(calendarDateToJulianDate(year: 837, month: 4, day: 10.3), 2026871.8)
		XCTAssertEqual(calendarDateToJulianDate(year: -123, month: 12, day: 31.0), 1676496.5)
		XCTAssertEqual(calendarDateToJulianDate(year: -122, month: 1, day: 1.0), 1676497.5)
		XCTAssertEqual(calendarDateToJulianDate(year: -1000, month: 7, day: 12, hour: 12), 1356001)
		XCTAssertEqual(calendarDateToJulianDate(year: -1000, month: 2, day: 29), 1355866.5)
		XCTAssertEqual(calendarDateToJulianDate(year: -1001, month: 8, day: 17.9), 1355671.4)
		XCTAssertEqual(calendarDateToJulianDate(year: -4712, month: 1, day: 1.5), 0)

		XCTAssertTrue(julianDateToCalendarDate(2451545) == (2000, 1, 1, 12, 0, 0))
		XCTAssertTrue(julianDateToCalendarDate(2451179.5) == (1999, 1, 1, 0, 0, 0))
		XCTAssertTrue(julianDateToCalendarDate(2446822.5) == (1987, 1, 27, 0, 0, 0))
		XCTAssertTrue(julianDateToCalendarDate(2446966) == (1987, 6, 19, 12, 0, 0))
		XCTAssertTrue(julianDateToCalendarDate(2447187.5) == (1988, 1, 27, 0, 0, 0))
		XCTAssertTrue(julianDateToCalendarDate(2447332.0) == (1988, 6, 19, 12, 0, 0))
		XCTAssertTrue(julianDateToCalendarDate(2415020.5) == (1900, 1, 1, 0, 0, 0))
		XCTAssertTrue(julianDateToCalendarDate(2305447.5) == (1600, 1, 1, 0, 0, 0))
		XCTAssertTrue(julianDateToCalendarDate(2305812.5) == (1600, 12, 31, 0, 0, 0))
//		XCTAssertTrue(julianDateToCalendarDate(2026871.8) == (837, 4, 10, 7, 12, 0))
		// Account for floating-point error since 2026871.8 is not perfectly representable by a double (real value is 2026871.80000000005)
		var calendarDate = julianDateToCalendarDate(2026871.8)
		XCTAssertTrue((calendarDate.year, calendarDate.month, calendarDate.day) == (837, 4, 10))
		var fractionalDay = timeToFractionalDay(hour: calendarDate.hour, minute: calendarDate.minute, second: calendarDate.second)
		XCTAssertEqual(fractionalDay, 0.3, accuracy: 0.000005) // ≈1/2 second accuracy check
		XCTAssertTrue(julianDateToCalendarDate(1676496.5) == (-123, 12, 31, 0, 0, 0))
		XCTAssertTrue(julianDateToCalendarDate(1676497.5) == (-122, 1, 1, 0, 0, 0))
		XCTAssertTrue(julianDateToCalendarDate(1356001) == (-1000, 7, 12, 12, 0, 0))
		XCTAssertTrue(julianDateToCalendarDate(1355866.5) == (-1000, 2, 29, 0, 0, 0))
//		XCTAssertTrue(julianDateToCalendarDate(1355671.4) == (-1001, 8, 17, 21, 36, 0))
		// Account for floating-point error since 1355671.4 is not perfectly representable by a double (real value is 1355671.39999999991)
		calendarDate = julianDateToCalendarDate(1355671.4)
		XCTAssertTrue((calendarDate.year, calendarDate.month, calendarDate.day) == (-1001, 8, 17))
		fractionalDay = timeToFractionalDay(hour: calendarDate.hour, minute: calendarDate.minute, second: calendarDate.second)
		XCTAssertEqual(fractionalDay, 0.9, accuracy: 0.000005)  // ≈1/2 second accuracy check
		XCTAssertTrue(julianDateToCalendarDate(0) == (-4712, 1, 1, 12, 0, 0))

		XCTAssertEqual(calendarDateToJulianDate(year: -4713, month: 12, day: 31, hour: 12), -1)
		XCTAssertEqual(calendarDateToJulianDate(year: -4712, month: 1, day: 1), -0.5)
		XCTAssertEqual(calendarDateToJulianDate(year: -4712, month: 1, day: 1, hour: 12), 0)
		XCTAssertEqual(calendarDateToJulianDate(year: -4712, month: 1, day: 2), 0.5)
		XCTAssertEqual(calendarDateToJulianDate(year: -4712, month: 1, day: 2, hour: 12), 1)

		XCTAssertTrue(julianDateToCalendarDate(-1) == (-4713, 12, 31, 12, 0, 0))
		XCTAssertTrue(julianDateToCalendarDate(-0.5) == (-4712, 1, 1, 0, 0, 0))
		XCTAssertTrue(julianDateToCalendarDate(0) == (-4712, 1, 1, 12, 0, 0))
		XCTAssertTrue(julianDateToCalendarDate(0.5) == (-4712, 1, 2, 0, 0, 0))
		XCTAssertTrue(julianDateToCalendarDate(1) == (-4712, 1, 2, 12, 0, 0))

		XCTAssertTrue(julianDateToCalendarDate(-1.75) == (-4713, 12, 30, 18, 0, 0))
		XCTAssertTrue(julianDateToCalendarDate(1.75) == (-4712, 1, 3, 6, 0, 0))
	}

	func testJDLimits() {
		XCTAssertEqual(calendarDateToJulianDate(year: -9999, month: 1, day: 1), -1931076.5)
		XCTAssertEqual(calendarDateToJulianDate(year: 99999, month: 12, day: 31), 38245308.5)
		XCTAssertEqual(julianCalendarDateToJulianDate(year: -9999, month: 1, day: 1), -1931076.5)
		XCTAssertEqual(julianCalendarDateToJulianDate(year: 99999, month: 12, day: 31), 38246056.5)
		XCTAssertEqual(gregorianCalendarDateToJulianDate(year: -9999, month: 1, day: 1), -1930999.5)
		XCTAssertEqual(gregorianCalendarDateToJulianDate(year: 99999, month: 12, day: 31), 38245308.5)

		XCTAssertTrue(julianDateToCalendarDate(-1931076.5) == (-9999, 1, 1, 0, 0, 0))
		XCTAssertTrue(julianDateToCalendarDate(38245308.5) == (99999, 12, 31, 0, 0, 0))
		XCTAssertTrue(julianDateToJulianCalendarDate(-1931076.5) == (-9999, 1, 1, 0, 0, 0))
		XCTAssertTrue(julianDateToJulianCalendarDate(38246056.5) == (99999, 12, 31, 0, 0, 0))
		XCTAssertTrue(julianDateToGregorianCalendarDate(-1930999.5) == (-9999, 1, 1, 0, 0, 0))
		XCTAssertTrue(julianDateToGregorianCalendarDate(38245308.5) == (99999, 12, 31, 0, 0, 0))
	}

	func testDate() {
		XCTAssertEqual(Date.j2000, Date(julianDate: 2451544.9992571296))
		XCTAssertEqual(Date(julianDate: 2451544.9992571296).daysSinceJ2000, 0)
	}
}
