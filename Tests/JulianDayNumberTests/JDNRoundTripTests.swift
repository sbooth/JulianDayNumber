//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import XCTest
@testable import JulianDayNumber

private let monthLengths = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ]

final class JDNRoundTripTests: XCTestCase {
	// Round-trip test of all supported JDNs
	func testJDNRoundTrip() {
		for year in stride(from: -9999, through: 99999, by: 1) {
			let isLeapYear = isLeapYear(year)
			for month in stride(from: 1, through: 12, by: 1) {
				let days: Int
				if month == 2 {
					days = isLeapYear ? 29 : 28
				} else {
					days = monthLengths[month - 1]
				}
				for day in stride(from: 1, through: days, by: 1) {
					let jdn = calendarDateToJulianDayNumber(year: year, month: month, day: day)
					let (Y, M, D) = julianDayNumberToCalendarDate(jdn)
					XCTAssertEqual(year, Y)
					XCTAssertEqual(month, M)
					// Handle Gregorian changeover by ignoring "nonexistent" dates
					if Y == 1582 && M == 10 && (day > 4 && day < 15) {
						continue
					}
					XCTAssertEqual(day, D)
				}
			}
		}
	}

	// Round-trip test of all supported JDNs using the Julian calendar
	func testJDNRoundTripJulian() {
		for year in stride(from: -9999, through: 99999, by: 1) {
			let isLeapYear = isJulianCalendarLeapYear(year)
			for month in stride(from: 1, through: 12, by: 1) {
				let days: Int
				if month == 2 {
					days = isLeapYear ? 29 : 28
				} else {
					days = monthLengths[month - 1]
				}
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

	// Round-trip test of all supported JDNs using the Gregorian calendar
	func testJDNRoundTripGregorian() {
		for year in stride(from: -9999, through: 99999, by: 1) {
			let isLeapYear = isGregorianCalendarLeapYear(year)
			for month in stride(from: 1, through: 12, by: 1) {
				let days: Int
				if month == 2 {
					days = isLeapYear ? 29 : 28
				} else {
					days = monthLengths[month - 1]
				}
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
}
