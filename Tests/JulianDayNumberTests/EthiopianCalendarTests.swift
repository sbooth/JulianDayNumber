//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Testing
@testable import JulianDayNumber

@Suite struct EthiopianCalendarTests {
	@Test func epoch() {
		#expect(EthiopianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == EthiopianCalendar.epoch)
		#expect(EthiopianCalendar.dateFromJulianDayNumber(EthiopianCalendar.epoch) == (1, 1, 1))
	}

	@Test func dateValidation() {
		#expect(EthiopianCalendar.isValidDate(year: 2015, month: 13, day: 6))
		#expect(!EthiopianCalendar.isValidDate(year: 2016, month: 13, day: 6))
	}

	@Test func leapYear() {
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
			let j = EthiopianCalendar.julianDayNumberFrom(year: y, month: 13, day: isLeap ? 6 : 5)
			let d = EthiopianCalendar.dateFromJulianDayNumber(j)
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

	@Test func julianDayNumber() {
		#expect(EthiopianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == 1724221)
		#expect(EthiopianCalendar.dateFromJulianDayNumber(1724221) == (1, 1, 1))
		#expect(EthiopianCalendar.julianDayNumberFrom(year: 2000, month: 1, day: 1) == 2454356)
	}

	@Test func limits() {
		#expect(EthiopianCalendar.julianDateFrom(year: -999999, month: 1, day: 1) == -363525779.5)
		#expect(EthiopianCalendar.julianDateFrom(year: -99999, month: 1, day: 1) == -34800779.5)
		#expect(EthiopianCalendar.julianDateFrom(year: -9999, month: 1, day: 1) == -1928279.5)
		#expect(EthiopianCalendar.julianDateFrom(year: 9999, month: 13, day: 5) == 5376353.5)
		#expect(EthiopianCalendar.julianDateFrom(year: 99999, month: 13, day: 5) == 38248853.5)
		#expect(EthiopianCalendar.julianDateFrom(year: 999999, month: 13, day: 5) == 366973853.5)

		#expect(EthiopianCalendar.dateAndTimeFromJulianDate(-363525779.5) == (-999999, 1, 1, 0, 0, 0))
		#expect(EthiopianCalendar.dateAndTimeFromJulianDate(-34800779.5) == (-99999, 1, 1, 0, 0, 0))
		#expect(EthiopianCalendar.dateAndTimeFromJulianDate(-1928279.5) == (-9999, 1, 1, 0, 0, 0))
		#expect(EthiopianCalendar.dateAndTimeFromJulianDate(5376353.5) == (9999, 13, 5, 0, 0, 0))
		#expect(EthiopianCalendar.dateAndTimeFromJulianDate(38248853.5) == (99999, 13, 5, 0, 0, 0))
		#expect(EthiopianCalendar.dateAndTimeFromJulianDate(366973853.5) == (999999, 13, 5, 0, 0, 0))
	}

	@Test func arithmeticLimits() {
		// Values smaller than this cause an arithmetic overflow in dateFromJulianDayNumber
//		let smallestJDNForEthiopianCalendar = Int.min + 144
		// Values smaller than this cause an arithmetic overflow in julianDayNumberFrom
		let smallestJDNForEthiopianCalendar = Int.min + 384
		var (Y, M, D) = EthiopianCalendar.dateFromJulianDayNumber(smallestJDNForEthiopianCalendar)
		var jdn = EthiopianCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		#expect(smallestJDNForEthiopianCalendar == jdn)

		// Values larger than this cause an arithmetic overflow in dateFromJulianDayNumber
		let largestJDNForEthiopianCalendar = (Int.max - 3) / 4 - 124
		(Y, M, D) = EthiopianCalendar.dateFromJulianDayNumber(largestJDNForEthiopianCalendar)
		jdn = EthiopianCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		#expect(largestJDNForEthiopianCalendar == jdn)
	}
}
