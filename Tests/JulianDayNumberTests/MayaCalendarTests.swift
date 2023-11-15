//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import XCTest
@testable import JulianDayNumber

final class MayaCalendarTests: XCTestCase {
	func testLongCount() {
		XCTAssertTrue(MayaCalendar.longCountFromJulianDayNumber(584286) == (0, 0, 0, 0, 3))
		XCTAssertTrue(MayaCalendar.longCountFromJulianDayNumber(584285) == (0, 0, 0, 0, 2))
		XCTAssertTrue(MayaCalendar.longCountFromJulianDayNumber(584284) == (0, 0, 0, 0, 1))
		XCTAssertTrue(MayaCalendar.longCountFromJulianDayNumber(584283) == (0, 0, 0, 0, 0))
		XCTAssertTrue(MayaCalendar.longCountFromJulianDayNumber(584282) == (-1, 19, 19, 17, 19))
		XCTAssertTrue(MayaCalendar.longCountFromJulianDayNumber(584281) == (-1, 19, 19, 17, 18))
		XCTAssertTrue(MayaCalendar.longCountFromJulianDayNumber(584280) == (-1, 19, 19, 17, 17))

		XCTAssertTrue(MayaCalendar.longCountFromJulianDayNumber(300) == (-5, 18, 17, 14, 17))
		XCTAssertTrue(MayaCalendar.longCountFromJulianDayNumber(3) == (-5, 18, 17, 0, 0))
		XCTAssertTrue(MayaCalendar.longCountFromJulianDayNumber(2) == (-5, 18, 16, 17, 19))
		XCTAssertTrue(MayaCalendar.longCountFromJulianDayNumber(1) == (-5, 18, 16, 17, 18))
		XCTAssertTrue(MayaCalendar.longCountFromJulianDayNumber(0) == (-5, 18, 16, 17, 17))
		XCTAssertTrue(MayaCalendar.longCountFromJulianDayNumber(-1) == (-5, 18, 16, 17, 16))
		XCTAssertTrue(MayaCalendar.longCountFromJulianDayNumber(-2) == (-5, 18, 16, 17, 15))
		XCTAssertTrue(MayaCalendar.longCountFromJulianDayNumber(-3) == (-5, 18, 16, 17, 14))
		XCTAssertTrue(MayaCalendar.longCountFromJulianDayNumber(-300) == (-5, 18, 16, 2, 17))

		XCTAssertEqual(MayaCalendar.julianDayNumberFromLongCount(baktun: 0, katun: 0, tun: 0, uinal: 0, kin: 0), 584283)

		XCTAssertEqual(MayaCalendar.julianDayNumberFromLongCount(baktun: 0, katun: 0, tun: 0, uinal: -1, kin: 19), MayaCalendar.julianDayNumberFromLongCount(baktun: 0, katun: 0, tun: -1, uinal: 17, kin: 19))
	}

	func testCalendarRound() {
		XCTAssertTrue(MayaCalendar.calendarRoundFromJulianDayNumber(MayaCalendar.longCountEpochJulianDayNumber) == (4, 20, 8, 18))
		XCTAssertTrue(MayaCalendar.calendarRoundFromJulianDayNumber(2460260) == (3, 17, 5, 12))

		XCTAssertEqual(MayaCalendar.julianDayNumberFromCalendarRound(number: 4, name: 20, day: 8, month: 18, onOrAfter: MayaCalendar.longCountEpochJulianDayNumber), MayaCalendar.longCountEpochJulianDayNumber)
		XCTAssertEqual(MayaCalendar.julianDayNumberFromCalendarRound(number: 4, name: 20, day: 8, month: 18, before: MayaCalendar.longCountEpochJulianDayNumber), MayaCalendar.longCountEpochJulianDayNumber - 18980)

		XCTAssertEqual(MayaCalendar.julianDayNumberFromCalendarRound(number: 1, name: 11, day: 10, month: 11), nil)
	}

	func testLordOfTheNight() {
		XCTAssertEqual(MayaCalendar.lordOfTheNightFrom(uinal: 0, kin: 0), 9)
		XCTAssertEqual(MayaCalendar.lordOfTheNightFrom(uinal: 0, kin: 7), 7)
		XCTAssertEqual(MayaCalendar.lordOfTheNightFrom(uinal: 17, kin: 19), 8)
	}

	func testLimits() {
		XCTAssertEqual(MayaCalendar.julianDayNumberFromLongCount(baktun: -2535, katun: 5, tun: 12, uinal: 2, kin: 5), -364415352)
		XCTAssertEqual(MayaCalendar.julianDayNumberFromLongCount(baktun: -254, katun: 10, tun: 12, uinal: 2, kin: 5), -35915352)
		XCTAssertEqual(MayaCalendar.julianDayNumberFromLongCount(baktun: 0, katun: 0, tun: 0, uinal: 0, kin: -3649635), -3065352)
		XCTAssertEqual(MayaCalendar.julianDayNumberFromLongCount(baktun: 0, katun: 0, tun: 0, uinal: 0, kin: 3649635), 4233918)
		XCTAssertEqual(MayaCalendar.julianDayNumberFromLongCount(baktun: 253, katun: 9, tun: 7, uinal: 15, kin: 15), 37083918)
		XCTAssertEqual(MayaCalendar.julianDayNumberFromLongCount(baktun: 2534, katun: 14, tun: 7, uinal: 15, kin: 15), 365583918)

		XCTAssertTrue(MayaCalendar.longCountFromJulianDayNumber(-364415352) == (-2535, 5, 12, 2, 5))
		XCTAssertTrue(MayaCalendar.longCountFromJulianDayNumber(-35915352) == (-254, 10, 12, 2, 5))
		XCTAssertTrue(MayaCalendar.longCountFromJulianDayNumber(-3065352) == (-26, 13, 2, 2, 5))
		XCTAssertTrue(MayaCalendar.longCountFromJulianDayNumber(4233918) == (25, 6, 17, 15, 15))
		XCTAssertTrue(MayaCalendar.longCountFromJulianDayNumber(37083918) == (253, 9, 7, 15, 15))
		XCTAssertTrue(MayaCalendar.longCountFromJulianDayNumber(365583918) == (2534, 14, 7, 15, 15))
	}

	func testArithmeticLimits() {
		var b, k, t, u, d: Int

		// Values smaller than this cause an arithmetic overflow in longCountFromJulianDayNumber
//		let smallestJDNForMayaCalendar = Int.min + 584283
		// Values smaller than this cause an arithmetic overflow in julianDayNumberFromLongCount
		let smallestJDNForMayaCalendar = Int.min + 584291
		(b, k, t, u, d) = MayaCalendar.longCountFromJulianDayNumber(smallestJDNForMayaCalendar)
		var jdn = MayaCalendar.julianDayNumberFromLongCount(baktun: b, katun: k, tun: t, uinal: u, kin: d)
		XCTAssertEqual(smallestJDNForMayaCalendar, jdn)

		// Values larger than this cause an arithmetic overflow in longCountFromJulianDayNumber
		let largestJDNForMayaCalendar = Int.max
		(b, k, t, u, d) = MayaCalendar.longCountFromJulianDayNumber(largestJDNForMayaCalendar)
		jdn = MayaCalendar.julianDayNumberFromLongCount(baktun: b, katun: k, tun: t, uinal: u, kin: d)
		XCTAssertEqual(largestJDNForMayaCalendar, jdn)
	}
}
