//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//
import XCTest
@testable import JulianDayNumber

final class SyrianCalendarTests: XCTestCase {
	func testJulianDayNumber() {
		XCTAssertEqual(SyrianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1), 1607739)
		XCTAssertTrue(SyrianCalendar.dateFromJulianDayNumber(1607739) == (1, 1, 1))
	}

	func testLimits() {
		XCTAssertEqual(SyrianCalendar.julianDateFrom(year: -999999, month: 1, day: 1), -363642261.5)
		XCTAssertEqual(SyrianCalendar.julianDateFrom(year: -99999, month: 1, day: 1), -34917261.5)
		XCTAssertEqual(SyrianCalendar.julianDateFrom(year: -9999, month: 1, day: 1), -2044761.5)
		XCTAssertEqual(SyrianCalendar.julianDateFrom(year: 9999, month: 12, day: 30), 5259872.5)
		XCTAssertEqual(SyrianCalendar.julianDateFrom(year: 99999, month: 12, day: 30), 38132372.5)
		XCTAssertEqual(SyrianCalendar.julianDateFrom(year: 999999, month: 12, day: 30), 366857372.5)

		XCTAssertTrue(SyrianCalendar.dateAndTimeFromJulianDate(-363642261.5) == (-999999, 1, 1, 0, 0, 0))
		XCTAssertTrue(SyrianCalendar.dateAndTimeFromJulianDate(-34917261.5) == (-99999, 1, 1, 0, 0, 0))
		XCTAssertTrue(SyrianCalendar.dateAndTimeFromJulianDate(-2044761.5) == (-9999, 1, 1, 0, 0, 0))
		XCTAssertTrue(SyrianCalendar.dateAndTimeFromJulianDate(5259872.5) == (9999, 12, 30, 0, 0, 0))
		XCTAssertTrue(SyrianCalendar.dateAndTimeFromJulianDate(38132372.5) == (99999, 12, 30, 0, 0, 0))
		XCTAssertTrue(SyrianCalendar.dateAndTimeFromJulianDate(366857372.5) == (999999, 12, 30, 0, 0, 0))
	}

	func testArithmeticLimits() {
		// Values smaller than this cause an arithmetic overflow in dateFromJulianDayNumber
		let smallestJDNForSyrianCalendar = Int.min + 144
		var (Y, M, D) = SyrianCalendar.dateFromJulianDayNumber(smallestJDNForSyrianCalendar)
		var jdn = SyrianCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		XCTAssertEqual(smallestJDNForSyrianCalendar, jdn)

		// Values larger than this cause an arithmetic overflow in dateFromJulianDayNumber
		let largestJDNForSyrianCalendar = (Int.max - 3) / 4 - 1401
		(Y, M, D) = SyrianCalendar.dateFromJulianDayNumber(largestJDNForSyrianCalendar)
		jdn = SyrianCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		XCTAssertEqual(largestJDNForSyrianCalendar, jdn)
	}
}
