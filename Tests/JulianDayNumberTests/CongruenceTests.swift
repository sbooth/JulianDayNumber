//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import XCTest
@testable import JulianDayNumber

final class CongruenceTests: XCTestCase {
	func testGregorianToJulianConversion() {
		XCTAssertEqual(JulianCalendar.dateToJulianDayNumber(year: -9999, month: 1, day: 1), GregorianCalendar.dateToJulianDayNumber(year: -10000, month: 10, day: 16))
		XCTAssertEqual(GregorianCalendar.dateToJulianDayNumber(year: 99999, month: 12, day: 31), JulianCalendar.dateToJulianDayNumber(year: 99997, month: 12, day: 13))
		XCTAssertEqual(JulianCalendar.dateToJulianDayNumber(year: -4712, month: 1, day: 1), GregorianCalendar.dateToJulianDayNumber(year: -4713, month: 11, day: 24))
		XCTAssertEqual(JulianCalendar.dateToJulianDayNumber(year: 1582, month: 10, day: 4), GregorianCalendar.dateToJulianDayNumber(year: 1582, month: 10, day: 14))
		XCTAssertEqual(GregorianCalendar.dateToJulianDayNumber(year: 1582, month: 10, day: 15), JulianCalendar.dateToJulianDayNumber(year: 1582, month: 10, day: 5))
	}
}
