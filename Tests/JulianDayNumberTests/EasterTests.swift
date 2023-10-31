//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import XCTest
@testable import JulianDayNumber

final class EasterTests: XCTestCase {
	func testEaster() {
		// Dates from Meeus (1998)
		XCTAssertTrue(easter(year: 1991) == (3, 31))
		XCTAssertTrue(easter(year: 1992) == (4, 19))
		XCTAssertTrue(easter(year: 1993) == (4, 11))
		XCTAssertTrue(easter(year: 1954) == (4, 18))
		XCTAssertTrue(easter(year: 2000) == (4, 23))
		XCTAssertTrue(easter(year: 1818) == (3, 22))
		XCTAssertTrue(easter(year: 179) == (4, 12))
		XCTAssertTrue(easter(year: 711) == (4, 12))
		XCTAssertTrue(easter(year: 1243) == (4, 12))
	}
}
