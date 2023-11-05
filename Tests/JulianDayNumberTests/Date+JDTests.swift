//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import XCTest
@testable import JulianDayNumber

final class DateJDTests: XCTestCase {
	func testDate() {
		XCTAssertEqual(Date.j2000, Date(julianDate: 2451544.9992571296))
		XCTAssertEqual(Date(julianDate: 2451544.9992571296).daysSinceJ2000, 0)
	}
}
