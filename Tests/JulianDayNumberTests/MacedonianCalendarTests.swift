//
// Copyright © 2021-2024 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Testing
@testable import JulianDayNumber

@Suite struct MacedonianCalendarTests {
	@Test func julianDayNumber() {
		#expect(MacedonianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == 1607709)
		#expect(MacedonianCalendar.dateFromJulianDayNumber(1607709) == (1, 1, 1))
	}

	@Test func limits() {
		#expect(MacedonianCalendar.julianDateFrom(year: -999999, month: 1, day: 1) == -363642291.5)
		#expect(MacedonianCalendar.julianDateFrom(year: -99999, month: 1, day: 1) == -34917291.5)
		#expect(MacedonianCalendar.julianDateFrom(year: -9999, month: 1, day: 1) == -2044791.5)
		#expect(MacedonianCalendar.julianDateFrom(year: 9999, month: 12, day: 31) == 5259842.5)
		#expect(MacedonianCalendar.julianDateFrom(year: 99999, month: 12, day: 31) == 38132342.5)
		#expect(MacedonianCalendar.julianDateFrom(year: 999999, month: 12, day: 31) == 366857342.5)

		#expect(MacedonianCalendar.dateAndTimeFromJulianDate(-363642291.5) == (-999999, 1, 1, 0, 0, 0))
		#expect(MacedonianCalendar.dateAndTimeFromJulianDate(-34917291.5) == (-99999, 1, 1, 0, 0, 0))
		#expect(MacedonianCalendar.dateAndTimeFromJulianDate(-2044791.5) == (-9999, 1, 1, 0, 0, 0))
		#expect(MacedonianCalendar.dateAndTimeFromJulianDate(5259842.5) == (9999, 12, 31, 0, 0, 0))
		#expect(MacedonianCalendar.dateAndTimeFromJulianDate(38132342.5) == (99999, 12, 31, 0, 0, 0))
		#expect(MacedonianCalendar.dateAndTimeFromJulianDate(366857342.5) == (999999, 12, 31, 0, 0, 0))
	}

	@Test func arithmeticLimits() {
		// Values smaller than this cause an arithmetic overflow in dateFromJulianDayNumber
		let smallestJDNForMacedonianCalendar = Int.min + 144
		var (Y, M, D) = MacedonianCalendar.dateFromJulianDayNumber(smallestJDNForMacedonianCalendar)
		var jdn = MacedonianCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		#expect(smallestJDNForMacedonianCalendar == jdn)

		// Values larger than this cause an arithmetic overflow in dateFromJulianDayNumber
		let largestJDNForMacedonianCalendar = (Int.max - 3) / 4 - 1401
		(Y, M, D) = MacedonianCalendar.dateFromJulianDayNumber(largestJDNForMacedonianCalendar)
		jdn = MacedonianCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		#expect(largestJDNForMacedonianCalendar == jdn)
	}
}
