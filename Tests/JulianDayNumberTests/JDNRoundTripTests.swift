//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import XCTest
@testable import JulianDayNumber

final class JDNRoundTripTests: XCTestCase {
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

	func testAstronomical() {
		for year in minYear...maxYear {
			for month in 1...AstronomicalCalendar.monthsInYear {
				for day in 1...AstronomicalCalendar.daysInMonth(year: year, month: month) {
					let jdn = AstronomicalCalendar.dateToJulianDayNumber(year: year, month: month, day: day)
					let (Y, M, D) = AstronomicalCalendar.julianDayNumberToDate(jdn)
					XCTAssertEqual(year, Y)
					XCTAssertEqual(month, M)
					// Handle Julian to Gregorian calendar changeover by ignoring "nonexistent" dates
					if Y == 1582 && M == 10 && (day > 4 && day < 15) {
						continue
					}
					XCTAssertEqual(day, D)
				}
			}
		}
	}

	func testBahai() {
		for year in minYear...maxYear {
			for month in 1...BahaiCalendar.monthsInYear {
				for day in 1...BahaiCalendar.daysInMonth(year: year, month: month) {
					let jdn = BahaiCalendar.dateToJulianDayNumber(year: year, month: month, day: day)
					let (Y, M, D) = BahaiCalendar.julianDayNumberToDate(jdn)
					XCTAssertEqual(year, Y)
					XCTAssertEqual(month, M)
					XCTAssertEqual(day, D)
				}
			}
		}
	}

	func testCoptic() {
		for year in minYear...maxYear {
			for month in 1...CopticCalendar.monthsInYear {
				for day in 1...CopticCalendar.daysInMonth(year: year, month: month) {
					let jdn = CopticCalendar.dateToJulianDayNumber(year: year, month: month, day: day)
					let (Y, M, D) = CopticCalendar.julianDayNumberToDate(jdn)
					XCTAssertEqual(year, Y)
					XCTAssertEqual(month, M)
					XCTAssertEqual(day, D)
				}
			}
		}
	}

	func testEgyptian() {
		for year in minYear...maxYear {
			for month in 1...EgyptianCalendar.monthsInYear {
				for day in 1...EgyptianCalendar.daysInMonth(month: month) {
					let jdn = EgyptianCalendar.dateToJulianDayNumber(year: year, month: month, day: day)
					let (Y, M, D) = EgyptianCalendar.julianDayNumberToDate(jdn)
					XCTAssertEqual(year, Y)
					XCTAssertEqual(month, M)
					XCTAssertEqual(day, D)
				}
			}
		}
	}

	func testEthiopian() {
		for year in minYear...maxYear {
			for month in 1...EthiopianCalendar.monthsInYear {
				for day in 1...EthiopianCalendar.daysInMonth(year: year, month: month) {
					let jdn = EthiopianCalendar.dateToJulianDayNumber(year: year, month: month, day: day)
					let (Y, M, D) = EthiopianCalendar.julianDayNumberToDate(jdn)
					XCTAssertEqual(year, Y)
					XCTAssertEqual(month, M)
					XCTAssertEqual(day, D)
				}
			}
		}
	}

	func testFrenchRepublican() {
		for year in minYear...maxYear {
			for month in 1...FrenchRepublicanCalendar.monthsInYear {
				for day in 1...FrenchRepublicanCalendar.daysInMonth(year: year, month: month) {
					let jdn = FrenchRepublicanCalendar.dateToJulianDayNumber(year: year, month: month, day: day)
					let (Y, M, D) = FrenchRepublicanCalendar.julianDayNumberToDate(jdn)
					XCTAssertEqual(year, Y)
					XCTAssertEqual(month, M)
					XCTAssertEqual(day, D)
				}
			}
		}
	}

	func testGregorian() {
		for year in minYear...maxYear {
			for month in 1...GregorianCalendar.monthsInYear {
				for day in 1...GregorianCalendar.daysInMonth(year: year, month: month) {
					let jdn = GregorianCalendar.dateToJulianDayNumber(year: year, month: month, day: day)
					let (Y, M, D) = GregorianCalendar.julianDayNumberToDate(jdn)
					XCTAssertEqual(year, Y)
					XCTAssertEqual(month, M)
					XCTAssertEqual(day, D)
				}
			}
		}
	}

	func testIslamic() {
		for year in minYear...maxYear {
			for month in 1...IslamicCalendar.monthsInYear {
				for day in 1...IslamicCalendar.daysInMonth(year: year, month: month) {
					let jdn = IslamicCalendar.dateToJulianDayNumber(year: year, month: month, day: day)
					let (Y, M, D) = IslamicCalendar.julianDayNumberToDate(jdn)
					XCTAssertEqual(year, Y)
					XCTAssertEqual(month, M)
					XCTAssertEqual(day, D)
				}
			}
		}
	}

	func testJewish() {
		for year in minYear...maxYear {
			for month in 1...JewishCalendar.monthsInYear(year) {
				for day in 1...JewishCalendar.daysInMonth(year: year, month: month) {
					let jdn = JewishCalendar.dateToJulianDayNumber(year: year, month: month, day: day)
					let (Y, M, D) = JewishCalendar.julianDayNumberToDate(jdn)
					XCTAssertEqual(year, Y)
					XCTAssertEqual(month, M)
					XCTAssertEqual(day, D)
				}
			}
		}
	}

	func testJulian() {
		for year in minYear...maxYear {
			for month in 1...JulianCalendar.monthsInYear {
				for day in 1...JulianCalendar.daysInMonth(year: year, month: month) {
					let jdn = JulianCalendar.dateToJulianDayNumber(year: year, month: month, day: day)
					let (Y, M, D) = JulianCalendar.julianDayNumberToDate(jdn)
					XCTAssertEqual(year, Y)
					XCTAssertEqual(month, M)
					XCTAssertEqual(day, D)
				}
			}
		}
	}

	func testSaka() {
		for year in minYear...maxYear {
			for month in 1...SakaCalendar.monthsInYear {
				for day in 1...SakaCalendar.daysInMonth(year: year, month: month) {
					let jdn = SakaCalendar.dateToJulianDayNumber(year: year, month: month, day: day)
					let (Y, M, D) = SakaCalendar.julianDayNumberToDate(jdn)
					XCTAssertEqual(year, Y)
					XCTAssertEqual(month, M)
					XCTAssertEqual(day, D)
				}
			}
		}
	}
}
