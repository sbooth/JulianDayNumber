//
// SPDX-FileCopyrightText: 2021 Stephen F. Booth <contact@sbooth.dev>
// SPDX-License-Identifier: MIT
//
// Part of https://github.com/sbooth/JulianDayNumber
//

import Testing
@testable import JulianDayNumber

@Suite struct EgyptianCalendarTests {
	@Test func epoch() {
		#expect(EgyptianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == EgyptianCalendar.epoch)
		#expect(EgyptianCalendar.dateFromJulianDayNumber(EgyptianCalendar.epoch) == (1, 1, 1))
	}

	@Test func dateValidation() {
		#expect(EgyptianCalendar.isValid(year: 1600, month: 2, day: 30))
	}

	@Test func monthCount() {
		#expect(EgyptianCalendar.numberOfMonthsInYear == 13)
	}

	@Test func monthLength() {
		for month in 1...12 {
			#expect(EgyptianCalendar.numberOfDays(inMonth: month) == 30)
		}
		#expect(EgyptianCalendar.numberOfDays(inMonth: 13) == 5)
	}

	@Test func yearLength() {
		#expect(EgyptianCalendar.numberOfDaysInYear == 365)
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
		let minDate = EgyptianCalendar.dateFromJulianDayNumber(.min + 611)
		let minJ = EgyptianCalendar.julianDayNumberFromDate(minDate)
		#expect(minJ == .min + 611)

		let maxDate = EgyptianCalendar.dateFromJulianDayNumber(.max)
		let maxJ = EgyptianCalendar.julianDayNumberFromDate(maxDate)
		#expect(maxJ == .max)
	}
}
