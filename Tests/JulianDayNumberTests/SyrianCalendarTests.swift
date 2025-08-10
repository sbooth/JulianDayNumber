//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Testing
@testable import JulianDayNumber

@Suite struct SyrianCalendarTests {
	@Test func epoch() throws {
		#expect(try SyrianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == SyrianCalendar.epoch)
		#expect(try SyrianCalendar.dateFromJulianDayNumber(SyrianCalendar.epoch) == (1, 1, 1))
	}

	@Test func julianDayNumber() throws {
		#expect(try SyrianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == 1607739)
		#expect(try SyrianCalendar.dateFromJulianDayNumber(1607739) == (1, 1, 1))
	}

	@Test func leapYear() throws {
		#expect(!SyrianCalendar.isLeapYear(1))
		#expect(SyrianCalendar.isLeapYear(3))
		#expect(SyrianCalendar.isLeapYear(7))
		#expect(SyrianCalendar.isLeapYear(1739))
		#expect(!SyrianCalendar.isLeapYear(1740))
		#expect(SyrianCalendar.isLeapYear(-1))
		#expect(!SyrianCalendar.isLeapYear(-2))

		for y in -500...500 {
			let isLeap = SyrianCalendar.isLeapYear(y)
			let j = try SyrianCalendar.julianDayNumberFrom(year: y, month: 6, day: isLeap ? 29 : 28)
			let d = try SyrianCalendar.dateFromJulianDayNumber(j)
			#expect(d.month == 6)
			#expect(d.day == (isLeap ? 29 : 28))
		}
	}

	@Test func monthCount() {
		#expect(SyrianCalendar.numberOfMonthsInYear == 12)
	}

	@Test func monthLength() {
		#expect(SyrianCalendar.numberOfDaysIn(month: 1, year: 1) == 31)
		#expect(SyrianCalendar.numberOfDaysIn(month: 2, year: 1) == 30)
		#expect(SyrianCalendar.numberOfDaysIn(month: 3, year: 1) == 31)
		#expect(SyrianCalendar.numberOfDaysIn(month: 4, year: 1) == 31)
		#expect(SyrianCalendar.numberOfDaysIn(month: 6, year: 1) == 31)
		#expect(SyrianCalendar.numberOfDaysIn(month: 7, year: 1) == 30)
		#expect(SyrianCalendar.numberOfDaysIn(month: 8, year: 1) == 31)
		#expect(SyrianCalendar.numberOfDaysIn(month: 9, year: 1) == 30)
		#expect(SyrianCalendar.numberOfDaysIn(month: 10, year: 1) == 31)
		#expect(SyrianCalendar.numberOfDaysIn(month: 11, year: 1) == 31)
		#expect(SyrianCalendar.numberOfDaysIn(month: 12, year: 1) == 30)

		#expect(SyrianCalendar.numberOfDaysIn(month: 5, year: 1) == 28)
		#expect(SyrianCalendar.numberOfDaysIn(month: 5, year: 3) == 29)
	}

	@Test func yearLength() {
		#expect(SyrianCalendar.numberOfDays(inYear: 1) == 365)
		#expect(SyrianCalendar.numberOfDays(inYear: 3) == 366)
		#expect(SyrianCalendar.numberOfDays(inYear: 7) == 366)
		#expect(SyrianCalendar.numberOfDays(inYear: 8) == 365)
		#expect(SyrianCalendar.numberOfDays(inYear: 1739) == 366)
	}

	@Test func limits() throws {
		#expect(try SyrianCalendar.julianDateFrom(year: -999999, month: 1, day: 1) == -363642261.5)
		#expect(try SyrianCalendar.julianDateFrom(year: -99999, month: 1, day: 1) == -34917261.5)
		#expect(try SyrianCalendar.julianDateFrom(year: -9999, month: 1, day: 1) == -2044761.5)
		#expect(try SyrianCalendar.julianDateFrom(year: 9999, month: 12, day: 30) == 5259872.5)
		#expect(try SyrianCalendar.julianDateFrom(year: 99999, month: 12, day: 30) == 38132372.5)
		#expect(try SyrianCalendar.julianDateFrom(year: 999999, month: 12, day: 30) == 366857372.5)

		#expect(try SyrianCalendar.dateAndTimeFromJulianDate(-363642261.5) == (-999999, 1, 1, 0, 0, 0))
		#expect(try SyrianCalendar.dateAndTimeFromJulianDate(-34917261.5) == (-99999, 1, 1, 0, 0, 0))
		#expect(try SyrianCalendar.dateAndTimeFromJulianDate(-2044761.5) == (-9999, 1, 1, 0, 0, 0))
		#expect(try SyrianCalendar.dateAndTimeFromJulianDate(5259872.5) == (9999, 12, 30, 0, 0, 0))
		#expect(try SyrianCalendar.dateAndTimeFromJulianDate(38132372.5) == (99999, 12, 30, 0, 0, 0))
		#expect(try SyrianCalendar.dateAndTimeFromJulianDate(366857372.5) == (999999, 12, 30, 0, 0, 0))
	}

	@Test func arithmeticLimits() throws {
		let minDate = try SyrianCalendar.dateFromJulianDayNumber(.min)
		let minJ = try SyrianCalendar.julianDayNumberFromDate(minDate)
		#expect(minJ == .min)

		let maxDate = try SyrianCalendar.dateFromJulianDayNumber(.max)
		let maxJ = try SyrianCalendar.julianDayNumberFromDate(maxDate)
		#expect(maxJ == .max)
	}
}
