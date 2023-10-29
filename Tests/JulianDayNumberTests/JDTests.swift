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
	}

	func testJDLimits() {
		XCTAssertEqual(calendarDateToJulianDate(year: -9999, month: 1, day: 1), -1931076.5)
		XCTAssertEqual(calendarDateToJulianDate(year: 99999, month: 12, day: 31), 38245308.5)
		XCTAssertEqual(julianCalendarDateToJulianDate(year: -9999, month: 1, day: 1), -1931076.5)
		XCTAssertEqual(julianCalendarDateToJulianDate(year: 99999, month: 12, day: 31), 38246056.5)
		XCTAssertEqual(gregorianCalendarDateToJulianDate(year: -9999, month: 1, day: 1), -1930999.5)
		XCTAssertEqual(gregorianCalendarDateToJulianDate(year: 99999, month: 12, day: 31), 38245308.5)
	}

	func testDate() {
		XCTAssertEqual(Date.j2000, Date(julianDayNumber: 2451545, fractionalDay: 0.4992571296))
		let jdnAndFraction = Date.j2000.julianDayNumberAndFractionalDay
		XCTAssertEqual(jdnAndFraction.J, 2451545)
		XCTAssertEqual(jdnAndFraction.fractionalDay, 0.4992571296, accuracy: 1e-10)
	}
}
