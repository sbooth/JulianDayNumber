//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import XCTest
@testable import JulianDayNumber

final class DateValidationTests: XCTestCase {
	func testJulianDateValidation() {
		XCTAssertTrue(JulianCalendar.isDateValid(year: 1600, month: 2, day: 29))
		XCTAssertTrue(JulianCalendar.isDateValid(year: 1700, month: 2, day: 29))
	}

	func testGregorianDateValidation() {
		XCTAssertTrue(GregorianCalendar.isDateValid(year: 1600, month: 2, day: 29))
		XCTAssertFalse(GregorianCalendar.isDateValid(year: 1700, month: 2, day: 29))
	}

	func testAstronomicalDateValidation() {
		XCTAssertTrue(AstronomicalCalendar.isDateValid(year: 1969, month: 7, day: 20))
		XCTAssertFalse(AstronomicalCalendar.isDateValid(year: 1969, month: 7, day: 40))
		XCTAssertTrue(AstronomicalCalendar.isDateValid(year: 1600, month: 2, day: 29))
	}
}
