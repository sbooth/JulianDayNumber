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

	func testJulianCalendarJDNRoundTrip() {
		for year in stride(from: minYear, through: maxYear, by: 1) {
			for month in stride(from: 1, through: 12, by: 1) {
				let days = JulianCalendar.daysInMonth(year: year, month: month)
				for day in stride(from: 1, through: days, by: 1) {
					let jdn = JulianCalendar.dateToJulianDayNumber(year: year, month: month, day: day)
					let (Y, M, D) = JulianCalendar.julianDayNumberToDate(jdn)
					XCTAssertEqual(year, Y)
					XCTAssertEqual(month, M)
					XCTAssertEqual(day, D)
				}
			}
		}
	}

	func testGregorianCalendarJDNRoundTrip() {
		for year in stride(from: minYear, through: maxYear, by: 1) {
			for month in stride(from: 1, through: 12, by: 1) {
				let days = GregorianCalendar.daysInMonth(year: year, month: month)
				for day in stride(from: 1, through: days, by: 1) {
					let jdn = GregorianCalendar.dateToJulianDayNumber(year: year, month: month, day: day)
					let (Y, M, D) = GregorianCalendar.julianDayNumberToDate(jdn)
					XCTAssertEqual(year, Y)
					XCTAssertEqual(month, M)
					XCTAssertEqual(day, D)
				}
			}
		}
	}

	func testAstronomicalCalendarJDNRoundTrip() {
		for year in stride(from: minYear, through: maxYear, by: 1) {
			for month in stride(from: 1, through: 12, by: 1) {
				let days = AstronomicalCalendar.daysInMonth(year: year, month: month)
				for day in stride(from: 1, through: days, by: 1) {
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

	func testIslamicCalendarJDNRoundTrip() {
		for year in stride(from: minYear, through: maxYear, by: 1) {
			for month in stride(from: 1, through: 12, by: 1) {
				let days = IslamicCalendar.daysInMonth(year: year, month: month)
				for day in stride(from: 1, through: days, by: 1) {
					let jdn = IslamicCalendar.dateToJulianDayNumber(year: year, month: month, day: day)
					let (Y, M, D) = IslamicCalendar.julianDayNumberToDate(jdn)
					XCTAssertEqual(year, Y)
					XCTAssertEqual(month, M)
					XCTAssertEqual(day, D)
				}
			}
		}
	}

	func testEgyptianCalendarJDNRoundTrip() {
		for year in stride(from: minYear, through: maxYear, by: 1) {
			for month in stride(from: 1, through: 13, by: 1) {
				let days = EgyptianCalendar.daysInMonth(month: month)
				for day in stride(from: 1, through: days, by: 1) {
					let jdn = EgyptianCalendar.dateToJulianDayNumber(year: year, month: month, day: day)
					let (Y, M, D) = EgyptianCalendar.julianDayNumberToDate(jdn)
					XCTAssertEqual(year, Y)
					XCTAssertEqual(month, M)
					XCTAssertEqual(day, D)
				}
			}
		}
	}
}
