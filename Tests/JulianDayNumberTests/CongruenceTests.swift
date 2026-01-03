//
// SPDX-FileCopyrightText: 2021 Stephen F. Booth <contact@sbooth.dev>
// SPDX-License-Identifier: MIT
//
// Part of https://github.com/sbooth/JulianDayNumber
//

import Testing
@testable import JulianDayNumber

@Suite struct CongruenceTests {
	@Test func epoch() {
		#expect(ArmenianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == JulianCalendar.julianDayNumberFrom(year: 552, month: 7, day: 11))
		#expect(BahaiCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == GregorianCalendar.julianDayNumberFrom(year: 1844, month: 3, day: 21))
		#expect(CopticCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == JulianCalendar.julianDayNumberFrom(year: 284, month: 8, day: 29))
		#expect(EgyptianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == JulianCalendar.julianDayNumberFrom(year: -746, month: 2, day: 26))
		#expect(EthiopianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == JulianCalendar.julianDayNumberFrom(year: 8, month: 8, day: 29))
		#expect(FrenchRepublicanCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == GregorianCalendar.julianDayNumberFrom(year: 1792, month: 9, day: 22))
		#expect(GregorianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == JulianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 3))
		#expect(HebrewCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == JulianCalendar.julianDayNumberFrom(year: -3760, month: 10, day: 7))
		#expect(IslamicCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == JulianCalendar.julianDayNumberFrom(year: 622, month: 7, day: 16))
		#expect(KhwarizmianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == JulianCalendar.julianDayNumberFrom(year: 632, month: 6, day: 21))
		#expect(MacedonianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == JulianCalendar.julianDayNumberFrom(year: -311, month: 9, day: 1))
		#expect(MayaCalendar.julianDayNumberFromLongCount(baktun: 0, katun: 0, tun: 0, uinal: 0, kin: 0) == JulianCalendar.julianDayNumberFrom(year: -3113, month: 9, day: 6))
		#expect(PersianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == JulianCalendar.julianDayNumberFrom(year: 632, month: 6, day: 16))
		#expect(SakaCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == JulianCalendar.julianDayNumberFrom(year: 79, month: 3, day: 24))
		#expect(SyrianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == JulianCalendar.julianDayNumberFrom(year: -311, month: 10, day: 1))
	}

	@Test func gregorianToJulianConversion() {
		#expect(JulianCalendar.julianDayNumberFrom(year: -9999, month: 1, day: 1) == GregorianCalendar.julianDayNumberFrom(year: -10000, month: 10, day: 16))
		#expect(GregorianCalendar.julianDayNumberFrom(year: 99999, month: 12, day: 31) == JulianCalendar.julianDayNumberFrom(year: 99997, month: 12, day: 13))
		#expect(JulianCalendar.julianDayNumberFrom(year: -4712, month: 1, day: 1) == GregorianCalendar.julianDayNumberFrom(year: -4713, month: 11, day: 24))
		#expect(JulianCalendar.julianDayNumberFrom(year: 1582, month: 10, day: 4) == GregorianCalendar.julianDayNumberFrom(year: 1582, month: 10, day: 14))
		#expect(GregorianCalendar.julianDayNumberFrom(year: 1582, month: 10, day: 15) == JulianCalendar.julianDayNumberFrom(year: 1582, month: 10, day: 5))
	}
}
