//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Testing
import Foundation
@testable import JulianDayNumber

@Suite struct DateJDTests {
	@Test func date() {
		#expect(Date.j2000 == Date(julianDate: 2451544.9992571296))
		#expect(Date(julianDate: 2451544.9992571296).daysSinceJ2000 == 0)
	}
}
