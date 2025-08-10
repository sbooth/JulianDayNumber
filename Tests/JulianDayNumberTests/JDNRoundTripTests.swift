//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
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

	func testCalendar<C>(_ calendar: C.Type) throws where C: Calendar {
		for year in minYear...maxYear {
			for month in 1...calendar.numberOfMonths(inYear: year) {
				for day in 1...calendar.numberOfDaysIn(month: month, year: year) {
					let jdn = try calendar.julianDayNumberFrom(year: year, month: month, day: day)
					let (Y, M, D) = try calendar.dateFromJulianDayNumber(jdn)
					#expect((year, month, day) == (Y, M, D))
				}
			}
		}
	}

	@Test func armenian() throws {
		try testCalendar(ArmenianCalendar.self)
	}

	@Test func astronomical() throws {
		for year in minYear...maxYear {
			for month in 1...AstronomicalCalendar.numberOfMonths(inYear: year) {
				for day in 1...AstronomicalCalendar.numberOfDaysIn(month: month, year: year) {
					let jdn = try AstronomicalCalendar.julianDayNumberFrom(year: year, month: month, day: day)
					let (Y, M, D) = try AstronomicalCalendar.dateFromJulianDayNumber(jdn)
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

	@Test func bahai() throws {
		try testCalendar(BahaiCalendar.self)
	}

	@Test func coptic() throws {
		try testCalendar(CopticCalendar.self)
	}

	@Test func egyptian() throws {
		try testCalendar(EgyptianCalendar.self)
	}

	@Test func ethiopian() throws {
		try testCalendar(EthiopianCalendar.self)
	}

	@Test func frenchRepublican() throws {
		try testCalendar(FrenchRepublicanCalendar.self)
	}

	@Test func gregorian() throws {
		try testCalendar(GregorianCalendar.self)
	}

	@Test func hebrew() throws {
		try testCalendar(HebrewCalendar.self)
	}

	@Test func islamic() throws {
		try testCalendar(IslamicCalendar.self)
	}

	@Test func julian() throws {
		try testCalendar(JulianCalendar.self)
	}

	@Test func khwarizmian() throws {
		try testCalendar(KhwarizmianCalendar.self)
	}

	@Test func macedonian() throws {
		try testCalendar(MacedonianCalendar.self)
	}

	@Test func maya() throws {
		let minJ = MayaCalendar.longCountEpoch + JulianDayNumber(minYear) * 365
		let maxJ = MayaCalendar.longCountEpoch + JulianDayNumber(maxYear) * 365
		for J in minJ...maxJ {
			let (b, k, t, u, d) = try MayaCalendar.longCountFromJulianDayNumber(J)
			let jdn = try MayaCalendar.julianDayNumberFromLongCount(baktun: b, katun: k, tun: t, uinal: u, kin: d)
			#expect(J == jdn)
		}
	}

	@Test func persian() throws {
		try testCalendar(PersianCalendar.self)
	}

	@Test func saka() throws {
		try testCalendar(SakaCalendar.self)
	}

	@Test func syrian() throws {
		try testCalendar(SyrianCalendar.self)
	}
}
