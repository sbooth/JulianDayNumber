//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import XCTest
@testable import JulianDayNumber

final class PersianCalendarTests: XCTestCase {
	func testJulianDayNumber() {
		XCTAssertEqual(PersianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1), 1952063)
		XCTAssertTrue(PersianCalendar.dateFromJulianDayNumber(1952063) == (1, 1, 1))
	}

	func testLimits() {
		XCTAssertEqual(PersianCalendar.julianDateFrom(year: -999999, month: 1, day: 1), -363047937.5)
		XCTAssertEqual(PersianCalendar.julianDateFrom(year: -99999, month: 1, day: 1), -34547937.5)
		XCTAssertEqual(PersianCalendar.julianDateFrom(year: -9999, month: 1, day: 1), -1697937.5)
		XCTAssertEqual(PersianCalendar.julianDateFrom(year: 9999, month: 13, day: 30), 5601696.5)
		XCTAssertEqual(PersianCalendar.julianDateFrom(year: 99999, month: 13, day: 30), 38451696.5)
		XCTAssertEqual(PersianCalendar.julianDateFrom(year: 999999, month: 13, day: 30), 366951696.5)

		XCTAssertTrue(PersianCalendar.dateAndTimeFromJulianDate(-363047937.5) == (-999999, 1, 1, 0, 0, 0))
		XCTAssertTrue(PersianCalendar.dateAndTimeFromJulianDate(-34547937.5) == (-99999, 1, 1, 0, 0, 0))
		XCTAssertTrue(PersianCalendar.dateAndTimeFromJulianDate(-1697937.5) == (-9999, 1, 1, 0, 0, 0))
		XCTAssertTrue(PersianCalendar.dateAndTimeFromJulianDate(5601696.5) == (9999, 13, 30, 0, 0, 0))
		XCTAssertTrue(PersianCalendar.dateAndTimeFromJulianDate(38451696.5) == (99999, 13, 30, 0, 0, 0))
		XCTAssertTrue(PersianCalendar.dateAndTimeFromJulianDate(366951696.5) == (999999, 13, 30, 0, 0, 0))
	}

	func testArithmeticLimits() {
		// Values smaller than this cause an arithmetic overflow in dateFromJulianDayNumber
//		let smallestJDNForPersianCalendar: JulianDayNumber = .min + 294
		// Values smaller than this cause an arithmetic overflow in julianDayNumberFrom
		let smallestJDNForPersianCalendar: JulianDayNumber = .min + 336
		var (Y, M, D) = PersianCalendar.dateFromJulianDayNumber(smallestJDNForPersianCalendar)
		var jdn = PersianCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		XCTAssertEqual(smallestJDNForPersianCalendar, jdn)

		// Values larger than this cause an arithmetic overflow in dateFromJulianDayNumber
		let largestJDNForPersianCalendar: JulianDayNumber = .max - 77
		(Y, M, D) = PersianCalendar.dateFromJulianDayNumber(largestJDNForPersianCalendar)
		jdn = PersianCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		XCTAssertEqual(largestJDNForPersianCalendar, jdn)
	}
}
