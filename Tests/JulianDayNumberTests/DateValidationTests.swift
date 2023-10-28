//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import XCTest
@testable import JulianDayNumber

final class DateValidationTests: XCTestCase {
	func testDateValidation() {
		XCTAssertTrue(isDateValid(year: 1969, month: 7, day: 20))
		XCTAssertFalse(isDateValid(year: 1969, month: 7, day: 40))
		XCTAssertTrue(isDateValid(year: 1600, month: 2, day: 29))
	}

	func testJulianDateValidation() {
		XCTAssertTrue(isJulianCalendarDateValid(year: 1600, month: 2, day: 29))
		XCTAssertTrue(isJulianCalendarDateValid(year: 1700, month: 2, day: 29))
	}

	func testGregorianDateValidation() {
		XCTAssertTrue(isGregorianCalendarDateValid(year: 1600, month: 2, day: 29))
		XCTAssertFalse(isGregorianCalendarDateValid(year: 1700, month: 2, day: 29))
	}
}
