//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Testing
@testable import JulianDayNumber

@Suite struct HebrewCalendarTests {
	@Test func firstDayOfTishrei() {
		#expect(HebrewCalendar.firstDayOfTishrei(year: 1) == 347998)
		#expect(HebrewCalendar.firstDayOfTishrei(year: 2) == 348353)
		#expect(HebrewCalendar.firstDayOfTishrei(year: 3) == 348708)
		#expect(HebrewCalendar.firstDayOfTishrei(year: 4) == 349091)
		#expect(HebrewCalendar.firstDayOfTishrei(year: 5) == 349445)
		#expect(HebrewCalendar.firstDayOfTishrei(year: 6) == 349800)
		#expect(HebrewCalendar.firstDayOfTishrei(year: 7) == 350185)
		#expect(HebrewCalendar.firstDayOfTishrei(year: 8) == 350539)
		#expect(HebrewCalendar.firstDayOfTishrei(year: 9) == 350922)
		#expect(HebrewCalendar.firstDayOfTishrei(year: 10) == 351277)
		#expect(HebrewCalendar.firstDayOfTishrei(year: 11) == 351631)
		#expect(HebrewCalendar.firstDayOfTishrei(year: 12) == 352014)
		#expect(HebrewCalendar.firstDayOfTishrei(year: 13) == 352369)
		#expect(HebrewCalendar.firstDayOfTishrei(year: 14) == 352723)
		#expect(HebrewCalendar.firstDayOfTishrei(year: 15) == 353108)
		#expect(HebrewCalendar.firstDayOfTishrei(year: 16) == 353461)
		#expect(HebrewCalendar.firstDayOfTishrei(year: 17) == 353815)
		#expect(HebrewCalendar.firstDayOfTishrei(year: 18) == 354200)
		#expect(HebrewCalendar.firstDayOfTishrei(year: 19) == 354555)

//		#expect(HebrewCalendar.firstDayOfTishrei(year: 0) == 347614)
//		#expect(HebrewCalendar.firstDayOfTishrei(year: -1) == 347261)
//		#expect(HebrewCalendar.firstDayOfTishrei(year: -2) == 346876)
//		#expect(HebrewCalendar.firstDayOfTishrei(year: -3) == 346521)
//		#expect(HebrewCalendar.firstDayOfTishrei(year: -4) == 346167)
//		#expect(HebrewCalendar.firstDayOfTishrei(year: -951) == 276)
//		#expect(HebrewCalendar.firstDayOfTishrei(year: -952) == -109)
//		#expect(HebrewCalendar.firstDayOfTishrei(year: -953) == -462)

		#expect(HebrewCalendar.firstDayOfTishrei(year: 999999) == 365594080)
		#expect(HebrewCalendar.firstDayOfTishrei(year: 99999) == 36871940)
		#expect(HebrewCalendar.firstDayOfTishrei(year: 9999) == 3999723)
//		#expect(HebrewCalendar.firstDayOfTishrei(year: -9999) == -3304494)
//		#expect(HebrewCalendar.firstDayOfTishrei(year: -99999) == -36176711)
//		#expect(HebrewCalendar.firstDayOfTishrei(year: -999999) == -364898823)
	}

	@Test func yearContaining() {
		#expect(HebrewCalendar.yearContaining(julianDayNumber: 347998) == 1)
		#expect(HebrewCalendar.yearContaining(julianDayNumber: 348353) == 2)
		#expect(HebrewCalendar.yearContaining(julianDayNumber: 348708) == 3)
		#expect(HebrewCalendar.yearContaining(julianDayNumber: 349091) == 4)
		#expect(HebrewCalendar.yearContaining(julianDayNumber: 349445) == 5)
		#expect(HebrewCalendar.yearContaining(julianDayNumber: 349800) == 6)
		#expect(HebrewCalendar.yearContaining(julianDayNumber: 350185) == 7)
		#expect(HebrewCalendar.yearContaining(julianDayNumber: 350539) == 8)
		#expect(HebrewCalendar.yearContaining(julianDayNumber: 350922) == 9)
		#expect(HebrewCalendar.yearContaining(julianDayNumber: 351277) == 10)
		#expect(HebrewCalendar.yearContaining(julianDayNumber: 351631) == 11)
		#expect(HebrewCalendar.yearContaining(julianDayNumber: 352014) == 12)
		#expect(HebrewCalendar.yearContaining(julianDayNumber: 352369) == 13)
		#expect(HebrewCalendar.yearContaining(julianDayNumber: 352723) == 14)
		#expect(HebrewCalendar.yearContaining(julianDayNumber: 353108) == 15)
		#expect(HebrewCalendar.yearContaining(julianDayNumber: 353461) == 16)
		#expect(HebrewCalendar.yearContaining(julianDayNumber: 353815) == 17)
		#expect(HebrewCalendar.yearContaining(julianDayNumber: 354200) == 18)
		#expect(HebrewCalendar.yearContaining(julianDayNumber: 354555) == 19)

//		#expect(HebrewCalendar.yearContaining(julianDayNumber: 347614) == 0)
//		#expect(HebrewCalendar.yearContaining(julianDayNumber: 347261) == -1)
//		#expect(HebrewCalendar.yearContaining(julianDayNumber: 346876) == -2)
//		#expect(HebrewCalendar.yearContaining(julianDayNumber: 346521) == -3)
//		#expect(HebrewCalendar.yearContaining(julianDayNumber: 346167) == -4)
//		#expect(HebrewCalendar.yearContaining(julianDayNumber: 276) == -951)
//		#expect(HebrewCalendar.yearContaining(julianDayNumber: -109) == -952)
//		#expect(HebrewCalendar.yearContaining(julianDayNumber: -462) == -953)

		#expect(HebrewCalendar.yearContaining(julianDayNumber: 365594080) == 999999)
		#expect(HebrewCalendar.yearContaining(julianDayNumber: 36871940) == 99999)
		#expect(HebrewCalendar.yearContaining(julianDayNumber: 3999723) == 9999)
//		#expect(HebrewCalendar.yearContaining(julianDayNumber: -3304494) == -9999)
//		#expect(HebrewCalendar.yearContaining(julianDayNumber: -36176711) == -99999)
//		#expect(HebrewCalendar.yearContaining(julianDayNumber: -364898823) == -999999)
	}

	@Test func epoch() {
		#expect(HebrewCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == HebrewCalendar.epoch)
		#expect(HebrewCalendar.dateFromJulianDayNumber(HebrewCalendar.epoch) == (1, 1, 1))
	}

	@Test func dateValidation() {
		#expect(HebrewCalendar.isValidDate(year: 3, month: 6, day: 30))
		#expect(!HebrewCalendar.isValidDate(year: 4, month: 6, day: 30))
	}

	@Test func leapYear() {
		#expect(!HebrewCalendar.isLeapYear(1))
		#expect(!HebrewCalendar.isLeapYear(2))
		#expect(HebrewCalendar.isLeapYear(3))
		#expect(!HebrewCalendar.isLeapYear(4))
		#expect(!HebrewCalendar.isLeapYear(5))
		#expect(HebrewCalendar.isLeapYear(6))
		#expect(!HebrewCalendar.isLeapYear(7))
		#expect(HebrewCalendar.isLeapYear(8))
		#expect(!HebrewCalendar.isLeapYear(9))
		#expect(!HebrewCalendar.isLeapYear(10))
		#expect(HebrewCalendar.isLeapYear(11))
		#expect(!HebrewCalendar.isLeapYear(12))
		#expect(!HebrewCalendar.isLeapYear(13))
		#expect(HebrewCalendar.isLeapYear(14))
		#expect(!HebrewCalendar.isLeapYear(15))
		#expect(!HebrewCalendar.isLeapYear(16))
		#expect(HebrewCalendar.isLeapYear(17))
		#expect(!HebrewCalendar.isLeapYear(18))
		#expect(HebrewCalendar.isLeapYear(19))

		#expect(HebrewCalendar.isLeapYear(0))
		#expect(!HebrewCalendar.isLeapYear(-1))
		#expect(HebrewCalendar.isLeapYear(-2))
		#expect(!HebrewCalendar.isLeapYear(-3))
		#expect(!HebrewCalendar.isLeapYear(-4))
		#expect(HebrewCalendar.isLeapYear(-5))
		#expect(!HebrewCalendar.isLeapYear(-6))
		#expect(!HebrewCalendar.isLeapYear(-7))
		#expect(HebrewCalendar.isLeapYear(-8))
		#expect(!HebrewCalendar.isLeapYear(-9))
		#expect(!HebrewCalendar.isLeapYear(-10))
		#expect(HebrewCalendar.isLeapYear(-11))
		#expect(!HebrewCalendar.isLeapYear(-12))
		#expect(HebrewCalendar.isLeapYear(-13))
		#expect(!HebrewCalendar.isLeapYear(-14))
		#expect(!HebrewCalendar.isLeapYear(-15))
		#expect(HebrewCalendar.isLeapYear(-16))
		#expect(!HebrewCalendar.isLeapYear(-17))
		#expect(!HebrewCalendar.isLeapYear(-18))

		#expect(HebrewCalendar.isLeapYear(-100))
	}

	@Test func monthCount() {
		#expect(HebrewCalendar.numberOfMonths(inYear: 1) == 12)
		#expect(HebrewCalendar.numberOfMonths(inYear: 2) == 12)
		#expect(HebrewCalendar.numberOfMonths(inYear: 3) == 13)
		#expect(HebrewCalendar.numberOfMonths(inYear: 4) == 12)
		#expect(HebrewCalendar.numberOfMonths(inYear: 5) == 12)
		#expect(HebrewCalendar.numberOfMonths(inYear: 6) == 13)
		#expect(HebrewCalendar.numberOfMonths(inYear: 7) == 12)
		#expect(HebrewCalendar.numberOfMonths(inYear: 8) == 13)
		#expect(HebrewCalendar.numberOfMonths(inYear: 9) == 12)
		#expect(HebrewCalendar.numberOfMonths(inYear: 10) == 12)
		#expect(HebrewCalendar.numberOfMonths(inYear: 11) == 13)
		#expect(HebrewCalendar.numberOfMonths(inYear: 12) == 12)
		#expect(HebrewCalendar.numberOfMonths(inYear: 13) == 12)
		#expect(HebrewCalendar.numberOfMonths(inYear: 14) == 13)
		#expect(HebrewCalendar.numberOfMonths(inYear: 15) == 12)
		#expect(HebrewCalendar.numberOfMonths(inYear: 16) == 12)
		#expect(HebrewCalendar.numberOfMonths(inYear: 17) == 13)
		#expect(HebrewCalendar.numberOfMonths(inYear: 18) == 12)
		#expect(HebrewCalendar.numberOfMonths(inYear: 19) == 13)

		#expect(HebrewCalendar.numberOfMonths(inYear: 0) == 13)
		#expect(HebrewCalendar.numberOfMonths(inYear: -1) == 12)
		#expect(HebrewCalendar.numberOfMonths(inYear: -2) == 13)
		#expect(HebrewCalendar.numberOfMonths(inYear: -3) == 12)
		#expect(HebrewCalendar.numberOfMonths(inYear: -4) == 12)
		#expect(HebrewCalendar.numberOfMonths(inYear: -5) == 13)
		#expect(HebrewCalendar.numberOfMonths(inYear: -6) == 12)
		#expect(HebrewCalendar.numberOfMonths(inYear: -7) == 12)
		#expect(HebrewCalendar.numberOfMonths(inYear: -8) == 13)
		#expect(HebrewCalendar.numberOfMonths(inYear: -9) == 12)
		#expect(HebrewCalendar.numberOfMonths(inYear: -10) == 12)
		#expect(HebrewCalendar.numberOfMonths(inYear: -11) == 13)
		#expect(HebrewCalendar.numberOfMonths(inYear: -12) == 12)
		#expect(HebrewCalendar.numberOfMonths(inYear: -13) == 13)
		#expect(HebrewCalendar.numberOfMonths(inYear: -14) == 12)
		#expect(HebrewCalendar.numberOfMonths(inYear: -15) == 12)
		#expect(HebrewCalendar.numberOfMonths(inYear: -16) == 13)
		#expect(HebrewCalendar.numberOfMonths(inYear: -17) == 12)
		#expect(HebrewCalendar.numberOfMonths(inYear: -18) == 12)
	}

	@Test func monthLength() {
		#expect(HebrewCalendar.numberOfDaysIn(month: 6, year: 3) == 30)
		#expect(HebrewCalendar.numberOfDaysIn(month: 6, year: 4) == 29)
	}

	@Test func yearLength() {
		#expect(HebrewCalendar.numberOfDays(inYear: 1) == 355)
		#expect(HebrewCalendar.numberOfDays(inYear: 2) == 355)
		#expect(HebrewCalendar.numberOfDays(inYear: 3) == 383)
		#expect(HebrewCalendar.numberOfDays(inYear: 4) == 354)
		#expect(HebrewCalendar.numberOfDays(inYear: 5) == 355)
		#expect(HebrewCalendar.numberOfDays(inYear: 6) == 385)
		#expect(HebrewCalendar.numberOfDays(inYear: 7) == 354)
		#expect(HebrewCalendar.numberOfDays(inYear: 8) == 383)
		#expect(HebrewCalendar.numberOfDays(inYear: 9) == 355)
		#expect(HebrewCalendar.numberOfDays(inYear: 10) == 354)
		#expect(HebrewCalendar.numberOfDays(inYear: 11) == 383)
		#expect(HebrewCalendar.numberOfDays(inYear: 12) == 355)
		#expect(HebrewCalendar.numberOfDays(inYear: 13) == 354)
		#expect(HebrewCalendar.numberOfDays(inYear: 14) == 385)
		#expect(HebrewCalendar.numberOfDays(inYear: 15) == 353)
		#expect(HebrewCalendar.numberOfDays(inYear: 16) == 354)
		#expect(HebrewCalendar.numberOfDays(inYear: 17) == 385)
		#expect(HebrewCalendar.numberOfDays(inYear: 18) == 355)
		#expect(HebrewCalendar.numberOfDays(inYear: 19) == 383)
	}

	@Test func julianDayNumber() {
		#expect(HebrewCalendar.julianDayNumberFrom(year: -999999, month: 1, day: 1) == -364898823)
		#expect(HebrewCalendar.julianDayNumberFrom(year: -99999, month: 1, day: 1) == -36176711)
		#expect(HebrewCalendar.julianDayNumberFrom(year: -9999, month: 1, day: 1) == -3304494)
		#expect(HebrewCalendar.julianDayNumberFrom(year: 9999, month: 12, day: 29) == 4000075)
		#expect(HebrewCalendar.julianDayNumberFrom(year: 99999, month: 12, day: 29) == 36872292)
		#expect(HebrewCalendar.julianDayNumberFrom(year: 999999, month: 12, day: 29) == 365594434)
		#expect(HebrewCalendar.julianDayNumberFrom(year: 2000, month: 1, day: 1) == 1078112)
		#expect(HebrewCalendar.julianDayNumberFrom(year: -5000, month: 1, day: 1) == -1478617)

		#expect(HebrewCalendar.dateFromJulianDayNumber(-364898823) == (-999999, 1, 1))
		#expect(HebrewCalendar.dateFromJulianDayNumber(-36176711) == (-99999, 1, 1))
		#expect(HebrewCalendar.dateFromJulianDayNumber(-3304494) == (-9999, 1, 1))
		#expect(HebrewCalendar.dateFromJulianDayNumber(4000075) == (9999, 12, 29))
		#expect(HebrewCalendar.dateFromJulianDayNumber(36872292) == (99999, 12, 29))
		#expect(HebrewCalendar.dateFromJulianDayNumber(365594434) == (999999, 12, 29))
		#expect(HebrewCalendar.dateFromJulianDayNumber(0) == (-952, 4, 20))
		#expect(HebrewCalendar.dateFromJulianDayNumber(1078112) == (2000, 1, 1))
		#expect(HebrewCalendar.dateFromJulianDayNumber(-1478617) == (-5000, 1, 1))
	}

	@Test func limits() {
		#expect(HebrewCalendar.julianDateFrom(year: -999999, month: 1, day: 1) == -364898823.5)
		#expect(HebrewCalendar.julianDateFrom(year: -99999, month: 1, day: 1) == -36176711.5)
		#expect(HebrewCalendar.julianDateFrom(year: -9999, month: 1, day: 1) == -3304494.5)
		#expect(HebrewCalendar.julianDateFrom(year: 9999, month: 12, day: 29) == 4000074.5)
		#expect(HebrewCalendar.julianDateFrom(year: 99999, month: 12, day: 29) == 36872291.5)
		#expect(HebrewCalendar.julianDateFrom(year: 999999, month: 12, day: 29) == 365594433.5)

		#expect(HebrewCalendar.dateAndTimeFromJulianDate(-364898823.5) == (-999999, 1, 1, 0, 0, 0))
		#expect(HebrewCalendar.dateAndTimeFromJulianDate(-36176711.5) == (-99999, 1, 1, 0, 0, 0))
		#expect(HebrewCalendar.dateAndTimeFromJulianDate(-3304494.5) == (-9999, 1, 1, 0, 0, 0))
		#expect(HebrewCalendar.dateAndTimeFromJulianDate(4000074.5) == (9999, 12, 29, 0, 0, 0))
		#expect(HebrewCalendar.dateAndTimeFromJulianDate(36872291.5) == (99999, 12, 29, 0, 0, 0))
		#expect(HebrewCalendar.dateAndTimeFromJulianDate(365594433.5) == (999999, 12, 29, 0, 0, 0))
	}

	@Test func arithmeticLimits() {
		// Values smaller than this cause an arithmetic overflow in dateFromJulianDayNumber
//		let smallestJDNForHebrewCalendar = Int.min + 106959827
		// Values smaller than this cause an arithmetic overflow in julianDayNumberFrom
		let smallestJDNForHebrewCalendar = Int.min + 106960181
		var (Y, M, D) = HebrewCalendar.dateFromJulianDayNumber(smallestJDNForHebrewCalendar)
		var jdn = HebrewCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		#expect(smallestJDNForHebrewCalendar == jdn)

		// Values larger than this cause an arithmetic overflow in dateFromJulianDayNumber
		let largestJDNForHebrewCalendar = 355839970905570
		(Y, M, D) = HebrewCalendar.dateFromJulianDayNumber(largestJDNForHebrewCalendar)
		jdn = HebrewCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		#expect(largestJDNForHebrewCalendar == jdn)
	}
}
