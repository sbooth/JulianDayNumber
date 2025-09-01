//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Testing
@testable import JulianDayNumber

@Suite struct EthiopianCalendarTests {
	@Test func epoch() throws {
		#expect(try EthiopianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == EthiopianCalendar.epoch)
		#expect(try EthiopianCalendar.dateFromJulianDayNumber(EthiopianCalendar.epoch) == (1, 1, 1))
	}

	@Test func dateValidation() {
		#expect(EthiopianCalendar.isValid(year: 2015, month: 13, day: 6))
		#expect(!EthiopianCalendar.isValid(year: 2016, month: 13, day: 6))
	}

	@Test func leapYear() throws {
		#expect(!EthiopianCalendar.isLeapYear(1))
		#expect(EthiopianCalendar.isLeapYear(3))
		#expect(EthiopianCalendar.isLeapYear(7))
		#expect(EthiopianCalendar.isLeapYear(1739))
		#expect(!EthiopianCalendar.isLeapYear(1740))
		#expect(EthiopianCalendar.isLeapYear(-1))
		#expect(!EthiopianCalendar.isLeapYear(-2))
		#expect(EthiopianCalendar.isLeapYear(2015))
		#expect(!EthiopianCalendar.isLeapYear(2016))

		for y in -500...500 {
			let isLeap = EthiopianCalendar.isLeapYear(y)
			let j = try EthiopianCalendar.julianDayNumberFrom(year: y, month: 13, day: isLeap ? 6 : 5)
			let d = try EthiopianCalendar.dateFromJulianDayNumber(j)
			#expect(d.month == 13)
			#expect(d.day == (isLeap ? 6 : 5))
		}
	}

	@Test func monthCount() {
		#expect(EthiopianCalendar.numberOfMonthsInYear == 13)
	}

	@Test func monthLength() {
		for month in 1...12 {
			#expect(EthiopianCalendar.numberOfDaysIn(month: month, year: 1) == 30)
		}
		#expect(EthiopianCalendar.numberOfDaysIn(month: 13, year: 1) == 5)
		#expect(EthiopianCalendar.numberOfDaysIn(month: 13, year: 3) == 6)
	}

	@Test func yearLength() {
		#expect(EthiopianCalendar.numberOfDays(inYear: 1) == 365)
		#expect(EthiopianCalendar.numberOfDays(inYear: 3) == 366)
		#expect(EthiopianCalendar.numberOfDays(inYear: 7) == 366)
		#expect(EthiopianCalendar.numberOfDays(inYear: 8) == 365)
		#expect(EthiopianCalendar.numberOfDays(inYear: 1739) == 366)
	}

	@Test func julianDayNumber() throws {
		#expect(try EthiopianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == 1724221)
		#expect(try EthiopianCalendar.dateFromJulianDayNumber(1724221) == (1, 1, 1))
		#expect(try EthiopianCalendar.julianDayNumberFrom(year: 2000, month: 1, day: 1) == 2454356)
	}

	@Test func limits() throws {
		#expect(try EthiopianCalendar.julianDateFrom(year: -999999, month: 1, day: 1) == -363525779.5)
		#expect(try EthiopianCalendar.julianDateFrom(year: -99999, month: 1, day: 1) == -34800779.5)
		#expect(try EthiopianCalendar.julianDateFrom(year: -9999, month: 1, day: 1) == -1928279.5)
		#expect(try EthiopianCalendar.julianDateFrom(year: 9999, month: 13, day: 5) == 5376353.5)
		#expect(try EthiopianCalendar.julianDateFrom(year: 99999, month: 13, day: 5) == 38248853.5)
		#expect(try EthiopianCalendar.julianDateFrom(year: 999999, month: 13, day: 5) == 366973853.5)

		#expect(try EthiopianCalendar.dateAndTimeFromJulianDate(-363525779.5) == (-999999, 1, 1, 0, 0, 0))
		#expect(try EthiopianCalendar.dateAndTimeFromJulianDate(-34800779.5) == (-99999, 1, 1, 0, 0, 0))
		#expect(try EthiopianCalendar.dateAndTimeFromJulianDate(-1928279.5) == (-9999, 1, 1, 0, 0, 0))
		#expect(try EthiopianCalendar.dateAndTimeFromJulianDate(5376353.5) == (9999, 13, 5, 0, 0, 0))
		#expect(try EthiopianCalendar.dateAndTimeFromJulianDate(38248853.5) == (99999, 13, 5, 0, 0, 0))
		#expect(try EthiopianCalendar.dateAndTimeFromJulianDate(366973853.5) == (999999, 13, 5, 0, 0, 0))
	}

	@Test func arithmeticLimits() throws {
		let minDate = try EthiopianCalendar.dateFromJulianDayNumber(.min)
		let minJ = try EthiopianCalendar.julianDayNumberFromDate(minDate)
		#expect(minJ == .min)

		let maxDate = try EthiopianCalendar.dateFromJulianDayNumber(.max)
		let maxJ = try EthiopianCalendar.julianDayNumberFromDate(maxDate)
		#expect(maxJ == .max)

		_ = EthiopianCalendar.isLeapYear(.min)
		_ = EthiopianCalendar.isLeapYear(.max)
	}
}
