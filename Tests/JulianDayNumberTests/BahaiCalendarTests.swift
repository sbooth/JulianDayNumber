//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Testing
@testable import JulianDayNumber

@Suite struct BahaiCalendarTests {
	@Test func epoch() throws {
		#expect(try BahaiCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == BahaiCalendar.epoch)
		#expect(try BahaiCalendar.dateFromJulianDayNumber(BahaiCalendar.epoch) == (1, 1, 1))
	}

	@Test func dateValidation() {
		#expect(BahaiCalendar.isValid(year: 1, month: 1, day: 1))
		#expect(!BahaiCalendar.isValid(year: 3, month: 19, day: 5))
		#expect(BahaiCalendar.isValid(year: 4, month: 19, day: 5))
	}

	@Test func leapYear() throws {
		#expect(!BahaiCalendar.isLeapYear(1))
		#expect(BahaiCalendar.isLeapYear(4))
		#expect(BahaiCalendar.isLeapYear(100))
		#expect(!BahaiCalendar.isLeapYear(750))
		#expect(BahaiCalendar.isLeapYear(900))
		#expect(BahaiCalendar.isLeapYear(1236))
		#expect(!BahaiCalendar.isLeapYear(1429))
		#expect(!BahaiCalendar.isLeapYear(-3))
		#expect(BahaiCalendar.isLeapYear(-4))
		#expect(BahaiCalendar.isLeapYear(-8))
		#expect(BahaiCalendar.isLeapYear(-100))

		for y in -500...500 {
			let isLeap = BahaiCalendar.isLeapYear(y)
			let j = try BahaiCalendar.julianDayNumberFrom(year: y, month: 19, day: isLeap ? 5 : 4)
			let d = try BahaiCalendar.dateFromJulianDayNumber(j)
			#expect(d.month == 19)
			#expect(d.day == (isLeap ? 5 : 4))
		}
	}

	@Test func monthCount() {
		#expect(BahaiCalendar.numberOfMonthsInYear == 20)
	}

	@Test func monthLength() {
		for month in 1...18 {
			#expect(BahaiCalendar.numberOfDaysIn(month: month, year: 1) == 19)
		}
		#expect(BahaiCalendar.numberOfDaysIn(month: 19, year: 1) == 4)
		#expect(BahaiCalendar.numberOfDaysIn(month: 20, year: 1) == 19)
		#expect(BahaiCalendar.numberOfDaysIn(month: 19, year: 2) == 4)
		#expect(BahaiCalendar.numberOfDaysIn(month: 19, year: 3) == 4)
		#expect(BahaiCalendar.numberOfDaysIn(month: 19, year: 4) == 5)
	}

	@Test func yearLength() {
		#expect(BahaiCalendar.numberOfDays(inYear: 1) == 365)
		#expect(BahaiCalendar.numberOfDays(inYear:4) == 366)
		#expect(BahaiCalendar.numberOfDays(inYear:750) == 365)
		#expect(BahaiCalendar.numberOfDays(inYear:1236) == 366)
		#expect(BahaiCalendar.numberOfDays(inYear:1600) == 366)
	}

	@Test func julianDayNumber() throws {
		#expect(try BahaiCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == 2394647)
	}

	@Test func limits() throws {
		#expect(try BahaiCalendar.julianDateFrom(year: -999999, month: 1, day: 1) == -362847853.5)
		#expect(try BahaiCalendar.julianDateFrom(year: -99999, month: 1, day: 1) == -34129603.5)
		#expect(try BahaiCalendar.julianDateFrom(year: -9999, month: 1, day: 1) == -1257778.5)
		#expect(try BahaiCalendar.julianDateFrom(year: 9999, month: 20, day: 19) == 6046704.5)
		#expect(try BahaiCalendar.julianDateFrom(year: 99999, month: 20, day: 19) == 38918529.5)
		#expect(try BahaiCalendar.julianDateFrom(year: 999999, month: 20, day: 19) == 367636779.5)

		#expect(try BahaiCalendar.dateAndTimeFromJulianDate(-362847853.5) == (-999999, 1, 1, 0, 0, 0))
		#expect(try BahaiCalendar.dateAndTimeFromJulianDate(-34129603.5) == (-99999, 1, 1, 0, 0, 0))
		#expect(try BahaiCalendar.dateAndTimeFromJulianDate(-1257778.5) == (-9999, 1, 1, 0, 0, 0))
		#expect(try BahaiCalendar.dateAndTimeFromJulianDate(6046704.5) == (9999, 20, 19, 0, 0, 0))
		#expect(try BahaiCalendar.dateAndTimeFromJulianDate(38918529.5) == (99999, 20, 19, 0, 0, 0))
		#expect(try BahaiCalendar.dateAndTimeFromJulianDate(367636779.5) == (999999, 20, 19, 0, 0, 0))
	}

	@Test func arithmeticLimits() throws {
		let minDate = try BahaiCalendar.dateFromJulianDayNumber(.min)
		let minJ = try BahaiCalendar.julianDayNumberFromDate(minDate)
		#expect(minJ == .min)

		let maxDate = try BahaiCalendar.dateFromJulianDayNumber(.max)
		let maxJ = try BahaiCalendar.julianDayNumberFromDate(maxDate)
		#expect(maxJ == .max)
	}
}
