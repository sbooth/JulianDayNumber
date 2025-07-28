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

	func testCalendar<C>(_ calendar: C.Type) where C: Calendar & JulianDayNumberConverting {
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
			for month in 1...AstronomicalCalendar.monthsInYear {
				for day in 1...AstronomicalCalendar.daysInMonth(year: year, month: month) {
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
		for year in minYear...maxYear {
			for month in 1...FrenchRepublicanCalendar.monthsInYear {
				for day in 1...FrenchRepublicanCalendar.daysInMonth(year: year, month: month) {
					let jdn = FrenchRepublicanCalendar.julianDayNumberFrom(year: year, month: month, day: day)
					let (Y, M, D) = FrenchRepublicanCalendar.dateFromJulianDayNumber(jdn)
					#expect(year == Y)
					#expect(month == M)
					#expect(day == D)
				}
			}
		}
	}

	@Test func gregorian() {
		for year in minYear...maxYear {
			for month in 1...GregorianCalendar.monthsInYear {
				for day in 1...GregorianCalendar.daysInMonth(year: year, month: month) {
					let jdn = GregorianCalendar.julianDayNumberFrom(year: year, month: month, day: day)
					let (Y, M, D) = GregorianCalendar.dateFromJulianDayNumber(jdn)
					#expect(year == Y)
					#expect(month == M)
					#expect(day == D)
				}
			}
		}
	}

	@Test func hebrew() {
		for year in minYear...maxYear {
			for month in 1...HebrewCalendar.monthsInYear(year) {
				for day in 1...HebrewCalendar.daysInMonth(year: year, month: month) {
					let jdn = HebrewCalendar.julianDayNumberFrom(year: year, month: month, day: day)
					let (Y, M, D) = HebrewCalendar.dateFromJulianDayNumber(jdn)
					#expect(year == Y)
					#expect(month == M)
					#expect(day == D)
				}
			}
		}
	}

	@Test func islamic() {
		testCalendar(IslamicCalendar.self)
	}

	@Test func julian() {
		for year in minYear...maxYear {
			for month in 1...JulianCalendar.monthsInYear {
				for day in 1...JulianCalendar.daysInMonth(year: year, month: month) {
					let jdn = JulianCalendar.julianDayNumberFrom(year: year, month: month, day: day)
					let (Y, M, D) = JulianCalendar.dateFromJulianDayNumber(jdn)
					#expect(year == Y)
					#expect(month == M)
					#expect(day == D)
				}
			}
		}
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
