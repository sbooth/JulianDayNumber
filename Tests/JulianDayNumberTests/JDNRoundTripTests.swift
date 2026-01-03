//
// SPDX-FileCopyrightText: 2021 Stephen F. Booth <contact@sbooth.dev>
// SPDX-License-Identifier: MIT
//
// Part of https://github.com/sbooth/JulianDayNumber
//

import Testing
@testable import JulianDayNumber

@Suite struct JDNRoundTripTests {
#if LONG_ROUND_TRIP_TEST
	let minYear = -999999
	let maxYear = 999999
#elseif MEDIUM_ROUND_TRIP_TEST
	let minYear = -99999
	let maxYear = 99999
#else
	let minYear = -9999
	let maxYear = 9999
#endif

	func testCalendar<C>(_ calendar: C.Type) where C: Calendar {
		for year in minYear...maxYear {
			for month in 1...calendar.numberOfMonths(inYear: year) {
				for day in 1...calendar.numberOfDaysIn(month: month, year: year) {
					let jdn = calendar.julianDayNumberFrom(year: year, month: month, day: day)
					let (Y, M, D) = calendar.dateFromJulianDayNumber(jdn)
					#expect((year, month, day) == (Y, M, D))
				}
			}
		}
	}

	@Test func armenian() {
		testCalendar(ArmenianCalendar.self)
	}

	@Test func astronomical() {
		for year in minYear...maxYear {
			for month in 1...AstronomicalCalendar.numberOfMonths(inYear: year) {
				for day in 1...AstronomicalCalendar.numberOfDaysIn(month: month, year: year) {
					let jdn = AstronomicalCalendar.julianDayNumberFrom(year: year, month: month, day: day)
					let (Y, M, D) = AstronomicalCalendar.dateFromJulianDayNumber(jdn)
					#expect(year == Y)
					#expect(month == M)
					// Handle Julian to Gregorian calendar changeover by ignoring "nonexistent" dates
					if Y == 1582 && M == 10 && (day > 4 && day < 15) {
						continue
					}
					#expect(day == D)
				}
			}
		}
	}

	@Test func bahai() {
		testCalendar(BahaiCalendar.self)
	}

	@Test func coptic() {
		testCalendar(CopticCalendar.self)
	}

	@Test func egyptian() {
		testCalendar(EgyptianCalendar.self)
	}

	@Test func ethiopian() {
		testCalendar(EthiopianCalendar.self)
	}

	@Test func frenchRepublican() {
		testCalendar(FrenchRepublicanCalendar.self)
	}

	@Test func gregorian() {
		testCalendar(GregorianCalendar.self)
	}

	@Test func hebrew() {
		testCalendar(HebrewCalendar.self)
	}

	@Test func islamic() {
		testCalendar(IslamicCalendar.self)
	}

	@Test func julian() {
		testCalendar(JulianCalendar.self)
	}

	@Test func khwarizmian() {
		testCalendar(KhwarizmianCalendar.self)
	}

	@Test func macedonian() {
		testCalendar(MacedonianCalendar.self)
	}

	@Test func maya() {
		let minJ = MayaCalendar.longCountEpoch + JulianDayNumber(minYear) * 365
		let maxJ = MayaCalendar.longCountEpoch + JulianDayNumber(maxYear) * 365
		for J in minJ...maxJ {
			let (b, k, t, u, d) = MayaCalendar.longCountFromJulianDayNumber(J)
			let jdn = MayaCalendar.julianDayNumberFromLongCount(baktun: b, katun: k, tun: t, uinal: u, kin: d)
			#expect(J == jdn)
		}
	}

	@Test func persian() {
		testCalendar(PersianCalendar.self)
	}

	@Test func saka() {
		testCalendar(SakaCalendar.self)
	}

	@Test func syrian() {
		testCalendar(SyrianCalendar.self)
	}
}
