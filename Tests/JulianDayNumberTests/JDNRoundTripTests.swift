//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import XCTest
@testable import JulianDayNumber

final class JDNRoundTripTests: XCTestCase {
	func testJulianCalendarJDNRoundTrip() {
		for year in stride(from: -9999, through: 99999, by: 1) {
			for month in stride(from: 1, through: 12, by: 1) {
				let days = JulianCalendar.daysInMonth(year: year, month: month)
				for day in stride(from: 1, through: days, by: 1) {
					let jdn = julianCalendarDateToJulianDayNumber(year: year, month: month, day: day)
					let (Y, M, D) = julianDayNumberToJulianCalendarDate(jdn)
					XCTAssertEqual(year, Y)
					XCTAssertEqual(month, M)
					XCTAssertEqual(day, D)
				}
			}
		}
	}

	func testGregorianCalendarJDNRoundTrip() {
		for year in stride(from: -9999, through: 99999, by: 1) {
			for month in stride(from: 1, through: 12, by: 1) {
				let days = GregorianCalendar.daysInMonth(year: year, month: month)
				for day in stride(from: 1, through: days, by: 1) {
					let jdn = gregorianCalendarDateToJulianDayNumber(year: year, month: month, day: day)
					let (Y, M, D) = julianDayNumberToGregorianCalendarDate(jdn)
					XCTAssertEqual(year, Y)
					XCTAssertEqual(month, M)
					XCTAssertEqual(day, D)
				}
			}
		}
	}

	func testJulianGregorianCalendarJDNRoundTrip() {
		for year in stride(from: -9999, through: 99999, by: 1) {
			for month in stride(from: 1, through: 12, by: 1) {
				let days = JulianGregorianCalendar.daysInMonth(year: year, month: month)
				for day in stride(from: 1, through: days, by: 1) {
					let J = JDN(year: year, month: month, day: day)
					let (Y, M, D) = J.toDate()
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
		for year in stride(from: -9999, through: 99999, by: 1) {
			for month in stride(from: 1, through: 12, by: 1) {
				let days = IslamicCalendar.daysInMonth(year: year, month: month)
				for day in stride(from: 1, through: days, by: 1) {
					let jdn = islamicCalendarDateToJulianDayNumber(year: year, month: month, day: day)
					let (Y, M, D) = julianDayNumberToIslamicCalendarDate(jdn)
					XCTAssertEqual(year, Y)
					XCTAssertEqual(month, M)
					XCTAssertEqual(day, D)
				}
			}
		}
	}
}
