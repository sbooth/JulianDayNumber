//
// SPDX-FileCopyrightText: 2021 Stephen F. Booth <contact@sbooth.dev>
// SPDX-License-Identifier: MIT
//
// Part of https://github.com/sbooth/JulianDayNumber
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
