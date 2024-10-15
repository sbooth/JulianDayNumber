//
// Copyright © 2021-2024 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Testing
@testable import JulianDayNumber

@Suite struct EgyptianCalendarTests {
	@Test func dateValidation() {
		#expect(EgyptianCalendar.isDateValid(year: 1600, month: 2, day: 30))
	}

	@Test func monthCount() {
		#expect(EgyptianCalendar.monthsInYear == 13)
	}

	@Test func monthLength() {
		for month in 1...12 {
			#expect(EgyptianCalendar.daysInMonth(month: month) == 30)
		}
		#expect(EgyptianCalendar.daysInMonth(month: 13) == 5)
	}

	@Test func julianDayNumber() {
		// From Richards
		#expect(EgyptianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == 1448638)
	}

	@Test func limits() {
		#expect(EgyptianCalendar.julianDateFrom(year: -999999, month: 1, day: 1) == -363551362.5)
		#expect(EgyptianCalendar.julianDateFrom(year: -99999, month: 1, day: 1) == -35051362.5)
		#expect(EgyptianCalendar.julianDateFrom(year: -9999, month: 1, day: 1) == -2201362.5)
		#expect(EgyptianCalendar.julianDateFrom(year: 9999, month: 13, day: 5) == 5098271.5)
		#expect(EgyptianCalendar.julianDateFrom(year: 99999, month: 13, day: 5) == 37948271.5)
		#expect(EgyptianCalendar.julianDateFrom(year: 999999, month: 13, day: 5) == 366448271.5)

		#expect(EgyptianCalendar.dateAndTimeFromJulianDate(-363551362.5) == (-999999, 1, 1, 0, 0, 0))
		#expect(EgyptianCalendar.dateAndTimeFromJulianDate(-35051362.5) == (-99999, 1, 1, 0, 0, 0))
		#expect(EgyptianCalendar.dateAndTimeFromJulianDate(-2201362.5) == (-9999, 1, 1, 0, 0, 0))
		#expect(EgyptianCalendar.dateAndTimeFromJulianDate(5098271.5) == (9999, 13, 5, 0, 0, 0))
		#expect(EgyptianCalendar.dateAndTimeFromJulianDate(37948271.5) == (99999, 13, 5, 0, 0, 0))
		#expect(EgyptianCalendar.dateAndTimeFromJulianDate(366448271.5) == (999999, 13, 5, 0, 0, 0))
	}

	@Test func arithmeticLimits() {
		// Values smaller than this cause an arithmetic overflow in dateFromJulianDayNumber
//		let smallestJDNForEgyptianCalendar = Int.min + 293
		// Values smaller than this cause an arithmetic overflow in julianDayNumberFrom
		let smallestJDNForEgyptianCalendar = Int.min + 611
		var (Y, M, D) = EgyptianCalendar.dateFromJulianDayNumber(smallestJDNForEgyptianCalendar)
		var jdn = EgyptianCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		#expect(smallestJDNForEgyptianCalendar == jdn)

		// Values larger than this cause an arithmetic overflow in dateFromJulianDayNumber
		let largestJDNForEgyptianCalendar = Int.max - 47
		(Y, M, D) = EgyptianCalendar.dateFromJulianDayNumber(largestJDNForEgyptianCalendar)
		jdn = EgyptianCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		#expect(largestJDNForEgyptianCalendar == jdn)
	}
}
