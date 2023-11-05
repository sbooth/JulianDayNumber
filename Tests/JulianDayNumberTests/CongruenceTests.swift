//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import XCTest
@testable import JulianDayNumber

final class CongruenceTests: XCTestCase {
	func testEpoch() {
		XCTAssertEqual(CopticCalendar.dateToJulianDayNumber(year: 1, month: 1, day: 1), JulianCalendar.dateToJulianDayNumber(year: 284, month: 8, day: 29))
		XCTAssertEqual(EgyptianCalendar.dateToJulianDayNumber(year: 1, month: 1, day: 1), JulianCalendar.dateToJulianDayNumber(year: -746, month: 2, day: 26))
		XCTAssertEqual(EthiopianCalendar.dateToJulianDayNumber(year: 1, month: 1, day: 1), JulianCalendar.dateToJulianDayNumber(year: 8, month: 8, day: 29))
		XCTAssertEqual(GregorianCalendar.dateToJulianDayNumber(year: 1, month: 1, day: 1), JulianCalendar.dateToJulianDayNumber(year: 1, month: 1, day: 3))
		XCTAssertEqual(IslamicCalendar.dateToJulianDayNumber(year: 1, month: 1, day: 1), JulianCalendar.dateToJulianDayNumber(year: 622, month: 7, day: 16))
	}

	func testGregorianToJulianConversion() {
		XCTAssertEqual(JulianCalendar.dateToJulianDayNumber(year: -9999, month: 1, day: 1), GregorianCalendar.dateToJulianDayNumber(year: -10000, month: 10, day: 16))
		XCTAssertEqual(GregorianCalendar.dateToJulianDayNumber(year: 99999, month: 12, day: 31), JulianCalendar.dateToJulianDayNumber(year: 99997, month: 12, day: 13))
		XCTAssertEqual(JulianCalendar.dateToJulianDayNumber(year: -4712, month: 1, day: 1), GregorianCalendar.dateToJulianDayNumber(year: -4713, month: 11, day: 24))
		XCTAssertEqual(JulianCalendar.dateToJulianDayNumber(year: 1582, month: 10, day: 4), GregorianCalendar.dateToJulianDayNumber(year: 1582, month: 10, day: 14))
		XCTAssertEqual(GregorianCalendar.dateToJulianDayNumber(year: 1582, month: 10, day: 15), JulianCalendar.dateToJulianDayNumber(year: 1582, month: 10, day: 5))
	}
}
