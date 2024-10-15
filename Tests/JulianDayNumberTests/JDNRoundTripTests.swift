//
// Copyright © 2021-2024 Stephen F. Booth <me@sbooth.org>
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

	@Test func armenian() {
		for year in minYear...maxYear {
			for month in 1...ArmenianCalendar.monthsInYear {
				for day in 1...ArmenianCalendar.daysInMonth(month) {
					let jdn = ArmenianCalendar.julianDayNumberFrom(year: year, month: month, day: day)
					let (Y, M, D) = ArmenianCalendar.dateFromJulianDayNumber(jdn)
					#expect(year == Y)
					#expect(month == M)
					#expect(day == D)
				}
			}
		}
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
		for year in minYear...maxYear {
			for month in 1...BahaiCalendar.monthsInYear {
				for day in 1...BahaiCalendar.daysInMonth(year: year, month: month) {
					let jdn = BahaiCalendar.julianDayNumberFrom(year: year, month: month, day: day)
					let (Y, M, D) = BahaiCalendar.dateFromJulianDayNumber(jdn)
					#expect(year == Y)
					#expect(month == M)
					#expect(day == D)
				}
			}
		}
	}

	@Test func coptic() {
		for year in minYear...maxYear {
			for month in 1...CopticCalendar.monthsInYear {
				for day in 1...CopticCalendar.daysInMonth(year: year, month: month) {
					let jdn = CopticCalendar.julianDayNumberFrom(year: year, month: month, day: day)
					let (Y, M, D) = CopticCalendar.dateFromJulianDayNumber(jdn)
					#expect(year == Y)
					#expect(month == M)
					#expect(day == D)
				}
			}
		}
	}

	@Test func egyptian() {
		for year in minYear...maxYear {
			for month in 1...EgyptianCalendar.monthsInYear {
				for day in 1...EgyptianCalendar.daysInMonth(month: month) {
					let jdn = EgyptianCalendar.julianDayNumberFrom(year: year, month: month, day: day)
					let (Y, M, D) = EgyptianCalendar.dateFromJulianDayNumber(jdn)
					#expect(year == Y)
					#expect(month == M)
					#expect(day == D)
				}
			}
		}
	}

	@Test func ethiopian() {
		for year in minYear...maxYear {
			for month in 1...EthiopianCalendar.monthsInYear {
				for day in 1...EthiopianCalendar.daysInMonth(year: year, month: month) {
					let jdn = EthiopianCalendar.julianDayNumberFrom(year: year, month: month, day: day)
					let (Y, M, D) = EthiopianCalendar.dateFromJulianDayNumber(jdn)
					#expect(year == Y)
					#expect(month == M)
					#expect(day == D)
				}
			}
		}
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
		for year in minYear...maxYear {
			for month in 1...IslamicCalendar.monthsInYear {
				for day in 1...IslamicCalendar.daysInMonth(year: year, month: month) {
					let jdn = IslamicCalendar.julianDayNumberFrom(year: year, month: month, day: day)
					let (Y, M, D) = IslamicCalendar.dateFromJulianDayNumber(jdn)
					#expect(year == Y)
					#expect(month == M)
					#expect(day == D)
				}
			}
		}
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
		for year in minYear...maxYear {
			for month in 1...KhwarizmianCalendar.monthsInYear {
				for day in 1...KhwarizmianCalendar.daysInMonth(month) {
					let jdn = KhwarizmianCalendar.julianDayNumberFrom(year: year, month: month, day: day)
					let (Y, M, D) = KhwarizmianCalendar.dateFromJulianDayNumber(jdn)
					#expect(year == Y)
					#expect(month == M)
					#expect(day == D)
				}
			}
		}
	}

	@Test func macedonian() {
		for year in minYear...maxYear {
			for month in 1...MacedonianCalendar.monthsInYear {
				for day in 1...MacedonianCalendar.daysInMonth(year: year, month: month) {
					let jdn = MacedonianCalendar.julianDayNumberFrom(year: year, month: month, day: day)
					let (Y, M, D) = MacedonianCalendar.dateFromJulianDayNumber(jdn)
					#expect(year == Y)
					#expect(month == M)
					#expect(day == D)
				}
			}
		}
	}

	@Test func maya() {
		let minJ = MayaCalendar.longCountEpoch + minYear * 365
		let maxJ = MayaCalendar.longCountEpoch + maxYear * 365
		for J in minJ...maxJ {
			let (b, k, t, u, d) = MayaCalendar.longCountFromJulianDayNumber(J)
			let jdn = MayaCalendar.julianDayNumberFromLongCount(baktun: b, katun: k, tun: t, uinal: u, kin: d)
			#expect(J == jdn)
		}
	}

	@Test func persian() {
		for year in minYear...maxYear {
			for month in 1...PersianCalendar.monthsInYear {
				for day in 1...PersianCalendar.daysInMonth(month) {
					let jdn = PersianCalendar.julianDayNumberFrom(year: year, month: month, day: day)
					let (Y, M, D) = PersianCalendar.dateFromJulianDayNumber(jdn)
					#expect(year == Y)
					#expect(month == M)
					#expect(day == D)
				}
			}
		}
	}

	@Test func saka() {
		for year in minYear...maxYear {
			for month in 1...SakaCalendar.monthsInYear {
				for day in 1...SakaCalendar.daysInMonth(year: year, month: month) {
					let jdn = SakaCalendar.julianDayNumberFrom(year: year, month: month, day: day)
					let (Y, M, D) = SakaCalendar.dateFromJulianDayNumber(jdn)
					#expect(year == Y)
					#expect(month == M)
					#expect(day == D)
				}
			}
		}
	}

	@Test func syrian() {
		for year in minYear...maxYear {
			for month in 1...SyrianCalendar.monthsInYear {
				for day in 1...SyrianCalendar.daysInMonth(year: year, month: month) {
					let jdn = SyrianCalendar.julianDayNumberFrom(year: year, month: month, day: day)
					let (Y, M, D) = SyrianCalendar.dateFromJulianDayNumber(jdn)
					#expect(year == Y)
					#expect(month == M)
					#expect(day == D)
				}
			}
		}
	}
}
