//
// SPDX-FileCopyrightText: 2021 Stephen F. Booth <contact@sbooth.dev>
// SPDX-License-Identifier: MIT
//
// Part of https://github.com/sbooth/JulianDayNumber
//

import Testing
@testable import JulianDayNumber

@Suite struct MayaCalendarTests {
	@Test func epoch() {
		#expect(MayaCalendar.julianDayNumberFromLongCount(baktun: 0, katun: 0, tun: 0, uinal: 0, kin: 0) == MayaCalendar.epoch)
		#expect(MayaCalendar.dateFromJulianDayNumber(MayaCalendar.epoch) == (0, 0, 0, 0, 0))
	}

	@Test func dateValidation() {
		#expect(MayaCalendar.isValidLongCount(baktun: 0, katun: 0, tun: 0, uinal: 0, kin: 19))
		#expect(!MayaCalendar.isValidLongCount(baktun: 0, katun: 0, tun: 0, uinal: 0, kin: 20))
		#expect(MayaCalendar.isValidLongCount(baktun: 0, katun: 0, tun: 0, uinal: 19, kin: 0))
		#expect(!MayaCalendar.isValidLongCount(baktun: 0, katun: 0, tun: 0, uinal: 20, kin: 0))
		#expect(MayaCalendar.isValidLongCount(baktun: 0, katun: 0, tun: 17, uinal: 0, kin: 0))
		#expect(!MayaCalendar.isValidLongCount(baktun: 0, katun: 0, tun: 18, uinal: 0, kin: 0))
		#expect(MayaCalendar.isValidLongCount(baktun: 0, katun: 19, tun: 0, uinal: 0, kin: 0))
		#expect(!MayaCalendar.isValidLongCount(baktun: 0, katun: 20, tun: 0, uinal: 0, kin: 0))
		#expect(MayaCalendar.isValidLongCount(baktun: -1, katun: 0, tun: 0, uinal: 0, kin: 0))
	}

	@Test func longCount() {
		#expect(MayaCalendar.longCountFromJulianDayNumber(584286) == (0, 0, 0, 0, 3))
		#expect(MayaCalendar.longCountFromJulianDayNumber(584285) == (0, 0, 0, 0, 2))
		#expect(MayaCalendar.longCountFromJulianDayNumber(584284) == (0, 0, 0, 0, 1))
		#expect(MayaCalendar.longCountFromJulianDayNumber(584283) == (0, 0, 0, 0, 0))
		#expect(MayaCalendar.longCountFromJulianDayNumber(584282) == (-1, 19, 19, 17, 19))
		#expect(MayaCalendar.longCountFromJulianDayNumber(584281) == (-1, 19, 19, 17, 18))
		#expect(MayaCalendar.longCountFromJulianDayNumber(584280) == (-1, 19, 19, 17, 17))

		#expect(MayaCalendar.longCountFromJulianDayNumber(300) == (-5, 18, 17, 14, 17))
		#expect(MayaCalendar.longCountFromJulianDayNumber(3) == (-5, 18, 17, 0, 0))
		#expect(MayaCalendar.longCountFromJulianDayNumber(2) == (-5, 18, 16, 17, 19))
		#expect(MayaCalendar.longCountFromJulianDayNumber(1) == (-5, 18, 16, 17, 18))
		#expect(MayaCalendar.longCountFromJulianDayNumber(0) == (-5, 18, 16, 17, 17))
		#expect(MayaCalendar.longCountFromJulianDayNumber(-1) == (-5, 18, 16, 17, 16))
		#expect(MayaCalendar.longCountFromJulianDayNumber(-2) == (-5, 18, 16, 17, 15))
		#expect(MayaCalendar.longCountFromJulianDayNumber(-3) == (-5, 18, 16, 17, 14))
		#expect(MayaCalendar.longCountFromJulianDayNumber(-300) == (-5, 18, 16, 2, 17))

		#expect(MayaCalendar.julianDayNumberFromLongCount(baktun: 0, katun: 0, tun: 0, uinal: 0, kin: 0) == 584283)

		#expect(MayaCalendar.julianDayNumberFromLongCount(baktun: 0, katun: 0, tun: 0, uinal: -1, kin: 19) == MayaCalendar.julianDayNumberFromLongCount(baktun: 0, katun: 0, tun: -1, uinal: 17, kin: 19))
	}

	@Test func calendarRound() {
		#expect(MayaCalendar.calendarRoundFromJulianDayNumber(MayaCalendar.longCountEpoch) == (4, 20, 8, 18))
		#expect(MayaCalendar.calendarRoundFromJulianDayNumber(2460260) == (3, 17, 5, 12))

		#expect(MayaCalendar.julianDayNumberFromCalendarRound(number: 4, name: 20, day: 8, month: 18, onOrAfter: MayaCalendar.longCountEpoch) == MayaCalendar.longCountEpoch)
		#expect(MayaCalendar.julianDayNumberFromCalendarRound(number: 4, name: 20, day: 8, month: 18, before: MayaCalendar.longCountEpoch) == MayaCalendar.longCountEpoch - 18980)

		#expect(MayaCalendar.julianDayNumberFromCalendarRound(number: 1, name: 11, day: 10, month: 11) == nil)
	}

	@Test func lordOfTheNight() {
		#expect(MayaCalendar.lordOfTheNightFrom(uinal: 0, kin: 0) == 9)
		#expect(MayaCalendar.lordOfTheNightFrom(uinal: 0, kin: 7) == 7)
		#expect(MayaCalendar.lordOfTheNightFrom(uinal: 17, kin: 19) == 8)
	}

	@Test func limits() {
		#expect(MayaCalendar.julianDayNumberFromLongCount(baktun: -2535, katun: 5, tun: 12, uinal: 2, kin: 5) == -364415352)
		#expect(MayaCalendar.julianDayNumberFromLongCount(baktun: -254, katun: 10, tun: 12, uinal: 2, kin: 5) == -35915352)
		#expect(MayaCalendar.julianDayNumberFromLongCount(baktun: 0, katun: 0, tun: 0, uinal: 0, kin: -3649635) == -3065352)
		#expect(MayaCalendar.julianDayNumberFromLongCount(baktun: 0, katun: 0, tun: 0, uinal: 0, kin: 3649635) == 4233918)
		#expect(MayaCalendar.julianDayNumberFromLongCount(baktun: 253, katun: 9, tun: 7, uinal: 15, kin: 15) == 37083918)
		#expect(MayaCalendar.julianDayNumberFromLongCount(baktun: 2534, katun: 14, tun: 7, uinal: 15, kin: 15) == 365583918)

		#expect(MayaCalendar.longCountFromJulianDayNumber(-364415352) == (-2535, 5, 12, 2, 5))
		#expect(MayaCalendar.longCountFromJulianDayNumber(-35915352) == (-254, 10, 12, 2, 5))
		#expect(MayaCalendar.longCountFromJulianDayNumber(-3065352) == (-26, 13, 2, 2, 5))
		#expect(MayaCalendar.longCountFromJulianDayNumber(4233918) == (25, 6, 17, 15, 15))
		#expect(MayaCalendar.longCountFromJulianDayNumber(37083918) == (253, 9, 7, 15, 15))
		#expect(MayaCalendar.longCountFromJulianDayNumber(365583918) == (2534, 14, 7, 15, 15))
	}

	@Test func arithmeticLimits() {
		let minLC = MayaCalendar.dateFromJulianDayNumber(.min)
		let minJ = MayaCalendar.julianDayNumberFromDate(minLC)
		#expect(minJ == .min)

		let maxLC = MayaCalendar.dateFromJulianDayNumber(.max)
		let maxJ = MayaCalendar.julianDayNumberFromDate(maxLC)
		#expect(maxJ == .max)
	}
}
