//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Testing
@testable import JulianDayNumber

@Suite struct CongruenceTests {
	@Test func epoch() throws {
		#expect(try ArmenianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == JulianCalendar.julianDayNumberFrom(year: 552, month: 7, day: 11))
		#expect(try BahaiCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == GregorianCalendar.julianDayNumberFrom(year: 1844, month: 3, day: 21))
		#expect(try CopticCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == JulianCalendar.julianDayNumberFrom(year: 284, month: 8, day: 29))
		#expect(try EgyptianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == JulianCalendar.julianDayNumberFrom(year: -746, month: 2, day: 26))
		#expect(try EthiopianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == JulianCalendar.julianDayNumberFrom(year: 8, month: 8, day: 29))
		#expect(try FrenchRepublicanCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == GregorianCalendar.julianDayNumberFrom(year: 1792, month: 9, day: 22))
		#expect(try GregorianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == JulianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 3))
		#expect(try HebrewCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == JulianCalendar.julianDayNumberFrom(year: -3760, month: 10, day: 7))
		#expect(try IslamicCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == JulianCalendar.julianDayNumberFrom(year: 622, month: 7, day: 16))
		#expect(try KhwarizmianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == JulianCalendar.julianDayNumberFrom(year: 632, month: 6, day: 21))
		#expect(try MacedonianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == JulianCalendar.julianDayNumberFrom(year: -311, month: 9, day: 1))
		#expect(try MayaCalendar.julianDayNumberFromLongCount(baktun: 0, katun: 0, tun: 0, uinal: 0, kin: 0) == JulianCalendar.julianDayNumberFrom(year: -3113, month: 9, day: 6))
		#expect(try PersianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == JulianCalendar.julianDayNumberFrom(year: 632, month: 6, day: 16))
		#expect(try SakaCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == JulianCalendar.julianDayNumberFrom(year: 79, month: 3, day: 24))
		#expect(try SyrianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == JulianCalendar.julianDayNumberFrom(year: -311, month: 10, day: 1))
	}

	@Test func gregorianToJulianConversion() throws {
		#expect(try JulianCalendar.julianDayNumberFrom(year: -9999, month: 1, day: 1) == GregorianCalendar.julianDayNumberFrom(year: -10000, month: 10, day: 16))
		#expect(try GregorianCalendar.julianDayNumberFrom(year: 99999, month: 12, day: 31) == JulianCalendar.julianDayNumberFrom(year: 99997, month: 12, day: 13))
		#expect(try JulianCalendar.julianDayNumberFrom(year: -4712, month: 1, day: 1) == GregorianCalendar.julianDayNumberFrom(year: -4713, month: 11, day: 24))
		#expect(try JulianCalendar.julianDayNumberFrom(year: 1582, month: 10, day: 4) == GregorianCalendar.julianDayNumberFrom(year: 1582, month: 10, day: 14))
		#expect(try GregorianCalendar.julianDayNumberFrom(year: 1582, month: 10, day: 15) == JulianCalendar.julianDayNumberFrom(year: 1582, month: 10, day: 5))
	}
}
