//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import XCTest
@testable import JulianDayNumber

final class MayanCalendarTests: XCTestCase {
	func testLongCount() {
		XCTAssertTrue(MayanCalendar.longCountFromJulianDayNumber(584286) == (0, 0, 0, 0, 3))
		XCTAssertTrue(MayanCalendar.longCountFromJulianDayNumber(584285) == (0, 0, 0, 0, 2))
		XCTAssertTrue(MayanCalendar.longCountFromJulianDayNumber(584284) == (0, 0, 0, 0, 1))
		XCTAssertTrue(MayanCalendar.longCountFromJulianDayNumber(584283) == (0, 0, 0, 0, 0))
		XCTAssertTrue(MayanCalendar.longCountFromJulianDayNumber(584282) == (-1, 19, 19, 17, 19))
		XCTAssertTrue(MayanCalendar.longCountFromJulianDayNumber(584281) == (-1, 19, 19, 17, 18))
		XCTAssertTrue(MayanCalendar.longCountFromJulianDayNumber(584280) == (-1, 19, 19, 17, 17))

		XCTAssertTrue(MayanCalendar.longCountFromJulianDayNumber(300) == (-5, 18, 17, 14, 17))
		XCTAssertTrue(MayanCalendar.longCountFromJulianDayNumber(3) == (-5, 18, 17, 0, 0))
		XCTAssertTrue(MayanCalendar.longCountFromJulianDayNumber(2) == (-5, 18, 16, 17, 19))
		XCTAssertTrue(MayanCalendar.longCountFromJulianDayNumber(1) == (-5, 18, 16, 17, 18))
		XCTAssertTrue(MayanCalendar.longCountFromJulianDayNumber(0) == (-5, 18, 16, 17, 17))
		XCTAssertTrue(MayanCalendar.longCountFromJulianDayNumber(-1) == (-5, 18, 16, 17, 16))
		XCTAssertTrue(MayanCalendar.longCountFromJulianDayNumber(-2) == (-5, 18, 16, 17, 15))
		XCTAssertTrue(MayanCalendar.longCountFromJulianDayNumber(-3) == (-5, 18, 16, 17, 14))
		XCTAssertTrue(MayanCalendar.longCountFromJulianDayNumber(-300) == (-5, 18, 16, 2, 17))

		XCTAssertEqual(MayanCalendar.julianDayNumberFromLongCount(baktun: 0, katun: 0, tun: 0, uinal: 0, kin: 0), 584283)

		XCTAssertEqual(MayanCalendar.julianDayNumberFromLongCount(baktun: 0, katun: 0, tun: 0, uinal: -1, kin: 19), MayanCalendar.julianDayNumberFromLongCount(baktun: 0, katun: 0, tun: -1, uinal: 17, kin: 19))
	}

	func testCalendarRound() {
		XCTAssertTrue(MayanCalendar.calendarRoundFromJulianDayNumber(MayanCalendar.longCountEpochJulianDayNumber) == (4, 20, 8, 18))
		XCTAssertTrue(MayanCalendar.calendarRoundFromJulianDayNumber(2460260) == (3, 17, 5, 12))

		XCTAssertEqual(MayanCalendar.julianDayNumberFromCalendarRound(number: 4, name: 20, day: 8, month: 18, onOrAfter: MayanCalendar.longCountEpochJulianDayNumber), MayanCalendar.longCountEpochJulianDayNumber)
		XCTAssertEqual(MayanCalendar.julianDayNumberFromCalendarRound(number: 4, name: 20, day: 8, month: 18, before: MayanCalendar.longCountEpochJulianDayNumber), MayanCalendar.longCountEpochJulianDayNumber - 18980)

		XCTAssertEqual(MayanCalendar.julianDayNumberFromCalendarRound(number: 1, name: 11, day: 10, month: 11), nil)
	}

	func testLordOfTheNight() {
		XCTAssertEqual(MayanCalendar.lordOfTheNightFrom(uinal: 0, kin: 0), 9)
		XCTAssertEqual(MayanCalendar.lordOfTheNightFrom(uinal: 0, kin: 7), 7)
		XCTAssertEqual(MayanCalendar.lordOfTheNightFrom(uinal: 17, kin: 19), 8)
	}

	func testLimits() {
		XCTAssertEqual(MayanCalendar.julianDayNumberFromLongCount(baktun: -2535, katun: 5, tun: 12, uinal: 2, kin: 5), -364415352)
		XCTAssertEqual(MayanCalendar.julianDayNumberFromLongCount(baktun: -254, katun: 10, tun: 12, uinal: 2, kin: 5), -35915352)
		XCTAssertEqual(MayanCalendar.julianDayNumberFromLongCount(baktun: 0, katun: 0, tun: 0, uinal: 0, kin: -3649635), -3065352)
		XCTAssertEqual(MayanCalendar.julianDayNumberFromLongCount(baktun: 0, katun: 0, tun: 0, uinal: 0, kin: 3649635), 4233918)
		XCTAssertEqual(MayanCalendar.julianDayNumberFromLongCount(baktun: 253, katun: 9, tun: 7, uinal: 15, kin: 15), 37083918)
		XCTAssertEqual(MayanCalendar.julianDayNumberFromLongCount(baktun: 2534, katun: 14, tun: 7, uinal: 15, kin: 15), 365583918)

		XCTAssertTrue(MayanCalendar.longCountFromJulianDayNumber(-364415352) == (-2535, 5, 12, 2, 5))
		XCTAssertTrue(MayanCalendar.longCountFromJulianDayNumber(-35915352) == (-254, 10, 12, 2, 5))
		XCTAssertTrue(MayanCalendar.longCountFromJulianDayNumber(-3065352) == (-26, 13, 2, 2, 5))
		XCTAssertTrue(MayanCalendar.longCountFromJulianDayNumber(4233918) == (25, 6, 17, 15, 15))
		XCTAssertTrue(MayanCalendar.longCountFromJulianDayNumber(37083918) == (253, 9, 7, 15, 15))
		XCTAssertTrue(MayanCalendar.longCountFromJulianDayNumber(365583918) == (2534, 14, 7, 15, 15))
	}

	func testArithmeticLimits() {
		var b, k, t, u, d: Int

		// Values smaller than this cause an arithmetic overflow in longCountFromJulianDayNumber
//		let smallestJDNForMayanCalendar = -9223372036854191525
		// Values smaller than this cause an arithmetic overflow in julianDayNumberFromLongCount
		let smallestJDNForMayanCalendar = -9223372036854191517
		(b, k, t, u, d) = MayanCalendar.longCountFromJulianDayNumber(smallestJDNForMayanCalendar)
		var jdn = MayanCalendar.julianDayNumberFromLongCount(baktun: b, katun: k, tun: t, uinal: u, kin: d)
		XCTAssertEqual(smallestJDNForMayanCalendar, jdn)

		// Values larger than this cause an arithmetic overflow in longCountFromJulianDayNumber
		let largestJDNForMayanCalendar = Int.max
		(b, k, t, u, d) = MayanCalendar.longCountFromJulianDayNumber(largestJDNForMayanCalendar)
		jdn = MayanCalendar.julianDayNumberFromLongCount(baktun: b, katun: k, tun: t, uinal: u, kin: d)
		XCTAssertEqual(largestJDNForMayanCalendar, jdn)
	}
}
