//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import XCTest
@testable import JulianDayNumber

final class IntegerDivisionTests: XCTestCase {
	func testIntegerDivision() {
		XCTAssertTrue(flooredQuotientAndRemainder(100, dividedBy: 20) == (5, 0))
		XCTAssertTrue(flooredQuotientAndRemainder(100, dividedBy: 23) == (4, 8))
		XCTAssertTrue(flooredQuotientAndRemainder(-100, dividedBy: 20) == (-5, 0))
		XCTAssertTrue(flooredQuotientAndRemainder(-100, dividedBy: 23) == (-5, 15))
		XCTAssertTrue(flooredQuotientAndRemainder(-100, dividedBy: -20) == (5, 0))
		XCTAssertTrue(flooredQuotientAndRemainder(-100, dividedBy: -23) == (4, -8))
		XCTAssertTrue(flooredQuotientAndRemainder(-100, dividedBy: -230) == (0, -100))
		XCTAssertTrue(flooredQuotientAndRemainder(-100, dividedBy: 230) == (-1, 130))
	}
}
