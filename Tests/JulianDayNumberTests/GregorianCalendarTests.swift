//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Testing
@testable import JulianDayNumber

@Suite struct GregorianCalendarTests {
	@Test func epoch() {
		#expect(GregorianCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == GregorianCalendar.epoch)
		#expect(GregorianCalendar.dateFromJulianDayNumber(GregorianCalendar.epoch) == (1, 1, 1))
	}

	@Test func dateValidation() {
		#expect(GregorianCalendar.isValid(year: 1600, month: 2, day: 29))
		#expect(!GregorianCalendar.isValid(year: 1700, month: 2, day: 29))
	}

	@Test func leapYear() {
		#expect(GregorianCalendar.isLeapYear(4))
		#expect(!GregorianCalendar.isLeapYear(100))
		#expect(GregorianCalendar.isLeapYear(1600))
		#expect(!GregorianCalendar.isLeapYear(1700))
		#expect(!GregorianCalendar.isLeapYear(1800))
		#expect(!GregorianCalendar.isLeapYear(1900))
		#expect(GregorianCalendar.isLeapYear(2000))
		#expect(!GregorianCalendar.isLeapYear(2100))
		#expect(GregorianCalendar.isLeapYear(2400))
		#expect(!GregorianCalendar.isLeapYear(-3))
		#expect(GregorianCalendar.isLeapYear(-4))
		#expect(GregorianCalendar.isLeapYear(-8))
		#expect(!GregorianCalendar.isLeapYear(-100))

		for y in 1583...2500 {
			let isLeap = GregorianCalendar.isLeapYear(y)
			let j = GregorianCalendar.julianDayNumberFrom(year: y, month: 2, day: isLeap ? 29 : 28)
			let d = GregorianCalendar.dateFromJulianDayNumber(j)
			#expect(d.month == 2)
			#expect(d.day == (isLeap ? 29 : 28))
		}
	}

	@Test func monthCount() {
		#expect(GregorianCalendar.numberOfMonthsInYear == 12)
	}

	@Test func monthLength() {
		#expect(GregorianCalendar.numberOfDaysIn(month: 2, year: 1600) == 29)
		#expect(GregorianCalendar.numberOfDaysIn(month: 2, year: 1700) == 28)
	}

	@Test func yearLength() {
		#expect(GregorianCalendar.numberOfDays(inYear: 4) == 366)
		#expect(GregorianCalendar.numberOfDays(inYear: 1581) == 365)
		#expect(GregorianCalendar.numberOfDays(inYear: 1582) == 365)
		#expect(GregorianCalendar.numberOfDays(inYear: 1583) == 365)
		#expect(GregorianCalendar.numberOfDays(inYear: 1600) == 366)

		var sum = 0
		for m in 1 ... 12 {
			sum += GregorianCalendar.numberOfDaysIn(month: m, year: 1961)
		}

		let jan1 = GregorianCalendar.julianDayNumberFrom(year: 1961, month: 1, day: 1)
		let dec31 = GregorianCalendar.julianDayNumberFrom(year: 1961, month: 12, day: 31)

		#expect(GregorianCalendar.numberOfDays(inYear: 1961) == sum)
		#expect(sum == (dec31 - jan1 + 1))
	}

	func testEaster() {
		// Dates from Meeus (1998)
		#expect(GregorianCalendar.easter(year: 1991) == (3, 31))
		#expect(GregorianCalendar.easter(year: 1992) == (4, 19))
		#expect(GregorianCalendar.easter(year: 1993) == (4, 11))
		#expect(GregorianCalendar.easter(year: 1954) == (4, 18))
		#expect(GregorianCalendar.easter(year: 2000) == (4, 23))
		#expect(GregorianCalendar.easter(year: 1818) == (3, 22))
	}

	@Test func julianDayNumber() {
		#expect(GregorianCalendar.julianDayNumberFrom(year: -999999, month: 1, day: 1) == -363521074)
		#expect(GregorianCalendar.julianDayNumberFrom(year: -99999, month: 1, day: 1) == -34802824)
		#expect(GregorianCalendar.julianDayNumberFrom(year: -9999, month: 1, day: 1) == -1930999)
		#expect(GregorianCalendar.julianDayNumberFrom(year: 9999, month: 12, day: 31) == 5373484)
		#expect(GregorianCalendar.julianDayNumberFrom(year: 99999, month: 12, day: 31) == 38245309)
		#expect(GregorianCalendar.julianDayNumberFrom(year: 999999, month: 12, day: 31) == 366963559)
		#expect(GregorianCalendar.julianDayNumberFrom(year: -4712, month: 1, day: 1) == 38)
		#expect(GregorianCalendar.julianDayNumberFrom(year: -4713, month: 11, day: 23) == -1)
		#expect(GregorianCalendar.julianDayNumberFrom(year: -4713, month: 11, day: 24) == 0)
		#expect(GregorianCalendar.julianDayNumberFrom(year: -4713, month: 11, day: 25) == 1)
		#expect(GregorianCalendar.julianDayNumberFrom(year: 1582, month: 10, day: 4) == 2299150)
		#expect(GregorianCalendar.julianDayNumberFrom(year: 1582, month: 10, day: 15) == 2299161)
		#expect(GregorianCalendar.julianDayNumberFrom(year: 2000, month: 1, day: 1) == 2451545)
		#expect(GregorianCalendar.julianDayNumberFrom(year: -5000, month: 1, day: 1) == -105152)

		#expect(GregorianCalendar.dateFromJulianDayNumber(-363521074) == (-999999, 1, 1))
		#expect(GregorianCalendar.dateFromJulianDayNumber(-34802824) == (-99999, 1, 1))
		#expect(GregorianCalendar.dateFromJulianDayNumber(-1930999) == (-9999, 1, 1))
		#expect(GregorianCalendar.dateFromJulianDayNumber(5373484) == (9999, 12, 31))
		#expect(GregorianCalendar.dateFromJulianDayNumber(38245309) == (99999, 12, 31))
		#expect(GregorianCalendar.dateFromJulianDayNumber(366963559) == (999999, 12, 31))
		#expect(GregorianCalendar.dateFromJulianDayNumber(38) == (-4712, 1, 1))
		#expect(GregorianCalendar.dateFromJulianDayNumber(-1) == (-4713, 11, 23))
		#expect(GregorianCalendar.dateFromJulianDayNumber(0) == (-4713, 11, 24))
		#expect(GregorianCalendar.dateFromJulianDayNumber(1) == (-4713, 11, 25))
		#expect(GregorianCalendar.dateFromJulianDayNumber(2299150) == (1582, 10, 4))
		#expect(GregorianCalendar.dateFromJulianDayNumber(2299161) == (1582, 10, 15))
		#expect(GregorianCalendar.dateFromJulianDayNumber(2451545) == (2000, 1, 1))
		#expect(GregorianCalendar.dateFromJulianDayNumber(-105152) == (-5000, 1, 1))
	}

	@Test func limits() {
		#expect(GregorianCalendar.julianDateFrom(year: -999999, month: 1, day: 1) == -363521074.5)
		#expect(GregorianCalendar.julianDateFrom(year: -99999, month: 1, day: 1) == -34802824.5)
		#expect(GregorianCalendar.julianDateFrom(year: -9999, month: 1, day: 1) == -1930999.5)
		#expect(GregorianCalendar.julianDateFrom(year: 9999, month: 12, day: 31) == 5373483.5)
		#expect(GregorianCalendar.julianDateFrom(year: 99999, month: 12, day: 31) == 38245308.5)
		#expect(GregorianCalendar.julianDateFrom(year: 999999, month: 12, day: 31) == 366963558.5)

		#expect(GregorianCalendar.dateAndTimeFromJulianDate(-363521074.5) == (-999999, 1, 1, 0, 0, 0))
		#expect(GregorianCalendar.dateAndTimeFromJulianDate(-34802824.5) == (-99999, 1, 1, 0, 0, 0))
		#expect(GregorianCalendar.dateAndTimeFromJulianDate(-1930999.5) == (-9999, 1, 1, 0, 0, 0))
		#expect(GregorianCalendar.dateAndTimeFromJulianDate(5373483.5) == (9999, 12, 31, 0, 0, 0))
		#expect(GregorianCalendar.dateAndTimeFromJulianDate(38245308.5) == (99999, 12, 31, 0, 0, 0))
		#expect(GregorianCalendar.dateAndTimeFromJulianDate(366963558.5) == (999999, 12, 31, 0, 0, 0))
	}

	@Test func arithmeticLimits() {
		// Values smaller than this cause an arithmetic overflow in dateFromJulianDayNumber
		let smallestJDNForGregorianCalendar = Int.min + 56457
		var (Y, M, D) = GregorianCalendar.dateFromJulianDayNumber(smallestJDNForGregorianCalendar)
		var jdn = GregorianCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		#expect(smallestJDNForGregorianCalendar == jdn)

		// Values larger than this cause an arithmetic overflow in dateFromJulianDayNumber
		let largestJDNForGregorianCalendar = 2305795661307959247
		(Y, M, D) = GregorianCalendar.dateFromJulianDayNumber(largestJDNForGregorianCalendar)
		jdn = GregorianCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		#expect(largestJDNForGregorianCalendar == jdn)
	}
}
