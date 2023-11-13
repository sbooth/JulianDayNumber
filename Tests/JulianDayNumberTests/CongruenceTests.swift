//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import XCTest
@testable import JulianDayNumber

final class CongruenceTests: XCTestCase {
	func testEpoch() {
		XCTAssertEqual(ArmenianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1), JulianCalendar.julianDayNumberFrom(year: 552, month: 7, day: 11))
		XCTAssertEqual(BahaiCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1), GregorianCalendar.julianDayNumberFrom(year: 1844, month: 3, day: 21))
		XCTAssertEqual(CopticCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1), JulianCalendar.julianDayNumberFrom(year: 284, month: 8, day: 29))
		XCTAssertEqual(EgyptianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1), JulianCalendar.julianDayNumberFrom(year: -746, month: 2, day: 26))
		XCTAssertEqual(EthiopianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1), JulianCalendar.julianDayNumberFrom(year: 8, month: 8, day: 29))
		XCTAssertEqual(FrenchRepublicanCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1), GregorianCalendar.julianDayNumberFrom(year: 1792, month: 9, day: 22))
		// Strictly speaking the Gregorian calendar epoch is January 1, 1 AD in the Julian calendar
		XCTAssertEqual(GregorianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1), JulianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 3))
		XCTAssertEqual(IslamicCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1), JulianCalendar.julianDayNumberFrom(year: 622, month: 7, day: 16))
		XCTAssertEqual(MayanCalendar.julianDayNumberFromLongCount(baktun: 0, katun: 0, tun: 0, uinal: 0, kin: 0), JulianCalendar.julianDayNumberFrom(year: -3113, month: 9, day: 6))
		XCTAssertEqual(SakaCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1), JulianCalendar.julianDayNumberFrom(year: 79, month: 3, day: 24))
	}

	func testGregorianToJulianConversion() {
		XCTAssertEqual(JulianCalendar.julianDayNumberFrom(year: -9999, month: 1, day: 1), GregorianCalendar.julianDayNumberFrom(year: -10000, month: 10, day: 16))
		XCTAssertEqual(GregorianCalendar.julianDayNumberFrom(year: 99999, month: 12, day: 31), JulianCalendar.julianDayNumberFrom(year: 99997, month: 12, day: 13))
		XCTAssertEqual(JulianCalendar.julianDayNumberFrom(year: -4712, month: 1, day: 1), GregorianCalendar.julianDayNumberFrom(year: -4713, month: 11, day: 24))
		XCTAssertEqual(JulianCalendar.julianDayNumberFrom(year: 1582, month: 10, day: 4), GregorianCalendar.julianDayNumberFrom(year: 1582, month: 10, day: 14))
		XCTAssertEqual(GregorianCalendar.julianDayNumberFrom(year: 1582, month: 10, day: 15), JulianCalendar.julianDayNumberFrom(year: 1582, month: 10, day: 5))
	}
}
