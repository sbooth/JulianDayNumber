//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import XCTest
@testable import JulianDayNumber

final class JDTests: XCTestCase {
	func testAstronomical() {
		// Values from Meeus (1998)
		XCTAssertEqual(AstronomicalCalendar.dateToJulianDate(year: 2000, month: 1, day: 1.5), 2451545)
		XCTAssertEqual(AstronomicalCalendar.dateToJulianDate(year: 1999, month: 1, day: 1), 2451179.5)
		XCTAssertEqual(AstronomicalCalendar.dateToJulianDate(year: 1987, month: 1, day: 27, hour: 0), 2446822.5)
		XCTAssertEqual(AstronomicalCalendar.dateToJulianDate(year: 1987, month: 6, day: 19.5), 2446966)
		XCTAssertEqual(AstronomicalCalendar.dateToJulianDate(year: 1988, month: 1, day: 27), 2447187.5)
		XCTAssertEqual(AstronomicalCalendar.dateToJulianDate(year: 1988, month: 6, day: 19, hour: 12), 2447332.0)
		XCTAssertEqual(AstronomicalCalendar.dateToJulianDate(year: 1900, month: 1, day: 1), 2415020.5)
		XCTAssertEqual(AstronomicalCalendar.dateToJulianDate(year: 1600, month: 1, day: 1), 2305447.5)
		XCTAssertEqual(AstronomicalCalendar.dateToJulianDate(year: 1600, month: 12, day: 31), 2305812.5)
		XCTAssertEqual(AstronomicalCalendar.dateToJulianDate(year: 837, month: 4, day: 10.3), 2026871.8)
		XCTAssertEqual(AstronomicalCalendar.dateToJulianDate(year: -123, month: 12, day: 31.0), 1676496.5)
		XCTAssertEqual(AstronomicalCalendar.dateToJulianDate(year: -122, month: 1, day: 1.0), 1676497.5)
		XCTAssertEqual(AstronomicalCalendar.dateToJulianDate(year: -1000, month: 7, day: 12, hour: 12), 1356001)
		XCTAssertEqual(AstronomicalCalendar.dateToJulianDate(year: -1000, month: 2, day: 29), 1355866.5)
		XCTAssertEqual(AstronomicalCalendar.dateToJulianDate(year: -1001, month: 8, day: 17.9), 1355671.4)
		XCTAssertEqual(AstronomicalCalendar.dateToJulianDate(year: -4712, month: 1, day: 1.5), 0)

		XCTAssertTrue(AstronomicalCalendar.julianDateToDate(2451545) == (2000, 1, 1, 12, 0, 0))
		XCTAssertTrue(AstronomicalCalendar.julianDateToDate(2451179.5) == (1999, 1, 1, 0, 0, 0))
		XCTAssertTrue(AstronomicalCalendar.julianDateToDate(2446822.5) == (1987, 1, 27, 0, 0, 0))
		XCTAssertTrue(AstronomicalCalendar.julianDateToDate(2446966) == (1987, 6, 19, 12, 0, 0))
		XCTAssertTrue(AstronomicalCalendar.julianDateToDate(2447187.5) == (1988, 1, 27, 0, 0, 0))
		XCTAssertTrue(AstronomicalCalendar.julianDateToDate(2447332.0) == (1988, 6, 19, 12, 0, 0))
		XCTAssertTrue(AstronomicalCalendar.julianDateToDate(2415020.5) == (1900, 1, 1, 0, 0, 0))
		XCTAssertTrue(AstronomicalCalendar.julianDateToDate(2305447.5) == (1600, 1, 1, 0, 0, 0))
		XCTAssertTrue(AstronomicalCalendar.julianDateToDate(2305812.5) == (1600, 12, 31, 0, 0, 0))
		//		XCTAssertTrue(AstronomicalCalendar.julianDateToDate(2026871.8) == (837, 4, 10, 7, 12, 0))
		// Account for floating-point error since 2026871.8 is not perfectly representable by a double (real value is 2026871.80000000005)
		var calendarDate = AstronomicalCalendar.julianDateToDate(2026871.8)
		XCTAssertTrue((calendarDate.year, calendarDate.month, calendarDate.day) == (837, 4, 10))
		var fractionalDay = timeToFractionalDay(hour: calendarDate.hour, minute: calendarDate.minute, second: calendarDate.second)
		XCTAssertEqual(fractionalDay, 0.3, accuracy: 0.000005) // ≈1/2 second accuracy check
		XCTAssertTrue(AstronomicalCalendar.julianDateToDate(1676496.5) == (-123, 12, 31, 0, 0, 0))
		XCTAssertTrue(AstronomicalCalendar.julianDateToDate(1676497.5) == (-122, 1, 1, 0, 0, 0))
		XCTAssertTrue(AstronomicalCalendar.julianDateToDate(1356001) == (-1000, 7, 12, 12, 0, 0))
		XCTAssertTrue(AstronomicalCalendar.julianDateToDate(1355866.5) == (-1000, 2, 29, 0, 0, 0))
		//		XCTAssertTrue(AstronomicalCalendar.julianDateToDate(1355671.4) == (-1001, 8, 17, 21, 36, 0))
		// Account for floating-point error since 1355671.4 is not perfectly representable by a double (real value is 1355671.39999999991)
		calendarDate = AstronomicalCalendar.julianDateToDate(1355671.4)
		XCTAssertTrue((calendarDate.year, calendarDate.month, calendarDate.day) == (-1001, 8, 17))
		fractionalDay = timeToFractionalDay(hour: calendarDate.hour, minute: calendarDate.minute, second: calendarDate.second)
		XCTAssertEqual(fractionalDay, 0.9, accuracy: 0.000005)  // ≈1/2 second accuracy check
		XCTAssertTrue(AstronomicalCalendar.julianDateToDate(0) == (-4712, 1, 1, 12, 0, 0))

		XCTAssertEqual(AstronomicalCalendar.dateToJulianDate(year: -4713, month: 12, day: 31, hour: 12), -1)
		XCTAssertEqual(AstronomicalCalendar.dateToJulianDate(year: -4712, month: 1, day: 1), -0.5)
		XCTAssertEqual(AstronomicalCalendar.dateToJulianDate(year: -4712, month: 1, day: 1, hour: 12), 0)
		XCTAssertEqual(AstronomicalCalendar.dateToJulianDate(year: -4712, month: 1, day: 2), 0.5)
		XCTAssertEqual(AstronomicalCalendar.dateToJulianDate(year: -4712, month: 1, day: 2, hour: 12), 1)

		XCTAssertTrue(AstronomicalCalendar.julianDateToDate(-1) == (-4713, 12, 31, 12, 0, 0))
		XCTAssertTrue(AstronomicalCalendar.julianDateToDate(-0.5) == (-4712, 1, 1, 0, 0, 0))
		XCTAssertTrue(AstronomicalCalendar.julianDateToDate(0) == (-4712, 1, 1, 12, 0, 0))
		XCTAssertTrue(AstronomicalCalendar.julianDateToDate(0.5) == (-4712, 1, 2, 0, 0, 0))
		XCTAssertTrue(AstronomicalCalendar.julianDateToDate(1) == (-4712, 1, 2, 12, 0, 0))

		XCTAssertTrue(AstronomicalCalendar.julianDateToDate(-1.75) == (-4713, 12, 30, 18, 0, 0))
		XCTAssertTrue(AstronomicalCalendar.julianDateToDate(1.75) == (-4712, 1, 3, 6, 0, 0))
	}

	func testLimits() {
		XCTAssertEqual(AstronomicalCalendar.dateToJulianDate(year: -999999, month: 1, day: 1), -363528576.5)
		XCTAssertEqual(AstronomicalCalendar.dateToJulianDate(year: -99999, month: 1, day: 1), -34803576.5)
		XCTAssertEqual(AstronomicalCalendar.dateToJulianDate(year: -9999, month: 1, day: 1), -1931076.5)
		XCTAssertEqual(AstronomicalCalendar.dateToJulianDate(year: 9999, month: 12, day: 31), 5373483.5)
		XCTAssertEqual(AstronomicalCalendar.dateToJulianDate(year: 99999, month: 12, day: 31), 38245308.5)
		XCTAssertEqual(AstronomicalCalendar.dateToJulianDate(year: 999999, month: 12, day: 31), 366963558.5)
		XCTAssertEqual(JulianCalendar.dateToJulianDate(year: -999999, month: 1, day: 1), -363528576.5)
		XCTAssertEqual(JulianCalendar.dateToJulianDate(year: -99999, month: 1, day: 1), -34803576.5)
		XCTAssertEqual(JulianCalendar.dateToJulianDate(year: -9999, month: 1, day: 1), -1931076.5)
		XCTAssertEqual(JulianCalendar.dateToJulianDate(year: 9999, month: 12, day: 31), 5373556.5)
		XCTAssertEqual(JulianCalendar.dateToJulianDate(year: 99999, month: 12, day: 31), 38246056.5)
		XCTAssertEqual(JulianCalendar.dateToJulianDate(year: 999999, month: 12, day: 31), 366971056.5)
		XCTAssertEqual(GregorianCalendar.dateToJulianDate(year: -999999, month: 1, day: 1), -363521074.5)
		XCTAssertEqual(GregorianCalendar.dateToJulianDate(year: -99999, month: 1, day: 1), -34802824.5)
		XCTAssertEqual(GregorianCalendar.dateToJulianDate(year: -9999, month: 1, day: 1), -1930999.5)
		XCTAssertEqual(GregorianCalendar.dateToJulianDate(year: 9999, month: 12, day: 31), 5373483.5)
		XCTAssertEqual(GregorianCalendar.dateToJulianDate(year: 99999, month: 12, day: 31), 38245308.5)
		XCTAssertEqual(GregorianCalendar.dateToJulianDate(year: 999999, month: 12, day: 31), 366963558.5)

		XCTAssertTrue(AstronomicalCalendar.julianDateToDate(-363528576.5) == (-999999, 1, 1, 0, 0, 0))
		XCTAssertTrue(AstronomicalCalendar.julianDateToDate(-34803576.5) == (-99999, 1, 1, 0, 0, 0))
		XCTAssertTrue(AstronomicalCalendar.julianDateToDate(-1931076.5) == (-9999, 1, 1, 0, 0, 0))
		XCTAssertTrue(AstronomicalCalendar.julianDateToDate(5373483.5) == (9999, 12, 31, 0, 0, 0))
		XCTAssertTrue(AstronomicalCalendar.julianDateToDate(38245308.5) == (99999, 12, 31, 0, 0, 0))
		XCTAssertTrue(AstronomicalCalendar.julianDateToDate(366963558.5) == (999999, 12, 31, 0, 0, 0))
		XCTAssertTrue(JulianCalendar.julianDateToDate(-363528576.5) == (-999999, 1, 1, 0, 0, 0))
		XCTAssertTrue(JulianCalendar.julianDateToDate(-34803576.5) == (-99999, 1, 1, 0, 0, 0))
		XCTAssertTrue(JulianCalendar.julianDateToDate(-1931076.5) == (-9999, 1, 1, 0, 0, 0))
		XCTAssertTrue(JulianCalendar.julianDateToDate(5373556.5) == (9999, 12, 31, 0, 0, 0))
		XCTAssertTrue(JulianCalendar.julianDateToDate(38246056.5) == (99999, 12, 31, 0, 0, 0))
		XCTAssertTrue(JulianCalendar.julianDateToDate(366971056.5) == (999999, 12, 31, 0, 0, 0))
		XCTAssertTrue(GregorianCalendar.julianDateToDate(-363521074.5) == (-999999, 1, 1, 0, 0, 0))
		XCTAssertTrue(GregorianCalendar.julianDateToDate(-34802824.5) == (-99999, 1, 1, 0, 0, 0))
		XCTAssertTrue(GregorianCalendar.julianDateToDate(-1930999.5) == (-9999, 1, 1, 0, 0, 0))
		XCTAssertTrue(GregorianCalendar.julianDateToDate(5373483.5) == (9999, 12, 31, 0, 0, 0))
		XCTAssertTrue(GregorianCalendar.julianDateToDate(38245308.5) == (99999, 12, 31, 0, 0, 0))
		XCTAssertTrue(GregorianCalendar.julianDateToDate(366963558.5) == (999999, 12, 31, 0, 0, 0))
	}

	func testDate() {
		XCTAssertEqual(Date.j2000, Date(julianDate: 2451544.9992571296))
		XCTAssertEqual(Date(julianDate: 2451544.9992571296).daysSinceJ2000, 0)
	}
}
