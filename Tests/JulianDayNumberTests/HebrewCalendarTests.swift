//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import XCTest
@testable import JulianDayNumber

final class HebrewCalendarTests: XCTestCase {
	func testFirstDayOfTishrei() {
		XCTAssertEqual(HebrewCalendar.firstDayOfTishrei(year: 1), 347998)
		XCTAssertEqual(HebrewCalendar.firstDayOfTishrei(year: 2), 348353)
		XCTAssertEqual(HebrewCalendar.firstDayOfTishrei(year: 3), 348708)
		XCTAssertEqual(HebrewCalendar.firstDayOfTishrei(year: 4), 349091)
		XCTAssertEqual(HebrewCalendar.firstDayOfTishrei(year: 5), 349445)
		XCTAssertEqual(HebrewCalendar.firstDayOfTishrei(year: 6), 349800)
		XCTAssertEqual(HebrewCalendar.firstDayOfTishrei(year: 7), 350185)
		XCTAssertEqual(HebrewCalendar.firstDayOfTishrei(year: 8), 350539)
		XCTAssertEqual(HebrewCalendar.firstDayOfTishrei(year: 9), 350922)
		XCTAssertEqual(HebrewCalendar.firstDayOfTishrei(year: 10), 351277)
		XCTAssertEqual(HebrewCalendar.firstDayOfTishrei(year: 11), 351631)
		XCTAssertEqual(HebrewCalendar.firstDayOfTishrei(year: 12), 352014)
		XCTAssertEqual(HebrewCalendar.firstDayOfTishrei(year: 13), 352369)
		XCTAssertEqual(HebrewCalendar.firstDayOfTishrei(year: 14), 352723)
		XCTAssertEqual(HebrewCalendar.firstDayOfTishrei(year: 15), 353108)
		XCTAssertEqual(HebrewCalendar.firstDayOfTishrei(year: 16), 353461)
		XCTAssertEqual(HebrewCalendar.firstDayOfTishrei(year: 17), 353815)
		XCTAssertEqual(HebrewCalendar.firstDayOfTishrei(year: 18), 354200)
		XCTAssertEqual(HebrewCalendar.firstDayOfTishrei(year: 19), 354555)

//		XCTAssertEqual(HebrewCalendar.firstDayOfTishrei(year: 0), 347614)
//		XCTAssertEqual(HebrewCalendar.firstDayOfTishrei(year: -1), 347261)
//		XCTAssertEqual(HebrewCalendar.firstDayOfTishrei(year: -2), 346876)
//		XCTAssertEqual(HebrewCalendar.firstDayOfTishrei(year: -3), 346521)
//		XCTAssertEqual(HebrewCalendar.firstDayOfTishrei(year: -4), 346167)
//		XCTAssertEqual(HebrewCalendar.firstDayOfTishrei(year: -951), 276)
//		XCTAssertEqual(HebrewCalendar.firstDayOfTishrei(year: -952), -109)
//		XCTAssertEqual(HebrewCalendar.firstDayOfTishrei(year: -953), -462)

		XCTAssertEqual(HebrewCalendar.firstDayOfTishrei(year: 999999), 365594080)
		XCTAssertEqual(HebrewCalendar.firstDayOfTishrei(year: 99999), 36871940)
		XCTAssertEqual(HebrewCalendar.firstDayOfTishrei(year: 9999), 3999723)
//		XCTAssertEqual(HebrewCalendar.firstDayOfTishrei(year: -9999), -3304494)
//		XCTAssertEqual(HebrewCalendar.firstDayOfTishrei(year: -99999), -36176711)
//		XCTAssertEqual(HebrewCalendar.firstDayOfTishrei(year: -999999), -364898823)
	}

	func testYearContaining() {
		XCTAssertEqual(HebrewCalendar.yearContaining(julianDayNumber: 347998), 1)
		XCTAssertEqual(HebrewCalendar.yearContaining(julianDayNumber: 348353), 2)
		XCTAssertEqual(HebrewCalendar.yearContaining(julianDayNumber: 348708), 3)
		XCTAssertEqual(HebrewCalendar.yearContaining(julianDayNumber: 349091), 4)
		XCTAssertEqual(HebrewCalendar.yearContaining(julianDayNumber: 349445), 5)
		XCTAssertEqual(HebrewCalendar.yearContaining(julianDayNumber: 349800), 6)
		XCTAssertEqual(HebrewCalendar.yearContaining(julianDayNumber: 350185), 7)
		XCTAssertEqual(HebrewCalendar.yearContaining(julianDayNumber: 350539), 8)
		XCTAssertEqual(HebrewCalendar.yearContaining(julianDayNumber: 350922), 9)
		XCTAssertEqual(HebrewCalendar.yearContaining(julianDayNumber: 351277), 10)
		XCTAssertEqual(HebrewCalendar.yearContaining(julianDayNumber: 351631), 11)
		XCTAssertEqual(HebrewCalendar.yearContaining(julianDayNumber: 352014), 12)
		XCTAssertEqual(HebrewCalendar.yearContaining(julianDayNumber: 352369), 13)
		XCTAssertEqual(HebrewCalendar.yearContaining(julianDayNumber: 352723), 14)
		XCTAssertEqual(HebrewCalendar.yearContaining(julianDayNumber: 353108), 15)
		XCTAssertEqual(HebrewCalendar.yearContaining(julianDayNumber: 353461), 16)
		XCTAssertEqual(HebrewCalendar.yearContaining(julianDayNumber: 353815), 17)
		XCTAssertEqual(HebrewCalendar.yearContaining(julianDayNumber: 354200), 18)
		XCTAssertEqual(HebrewCalendar.yearContaining(julianDayNumber: 354555), 19)

//		XCTAssertEqual(HebrewCalendar.yearContaining(julianDayNumber: 347614), 0)
//		XCTAssertEqual(HebrewCalendar.yearContaining(julianDayNumber: 347261), -1)
//		XCTAssertEqual(HebrewCalendar.yearContaining(julianDayNumber: 346876), -2)
//		XCTAssertEqual(HebrewCalendar.yearContaining(julianDayNumber: 346521), -3)
//		XCTAssertEqual(HebrewCalendar.yearContaining(julianDayNumber: 346167), -4)
//		XCTAssertEqual(HebrewCalendar.yearContaining(julianDayNumber: 276), -951)
//		XCTAssertEqual(HebrewCalendar.yearContaining(julianDayNumber: -109), -952)
//		XCTAssertEqual(HebrewCalendar.yearContaining(julianDayNumber: -462), -953)

		XCTAssertEqual(HebrewCalendar.yearContaining(julianDayNumber: 365594080), 999999)
		XCTAssertEqual(HebrewCalendar.yearContaining(julianDayNumber: 36871940), 99999)
		XCTAssertEqual(HebrewCalendar.yearContaining(julianDayNumber: 3999723), 9999)
//		XCTAssertEqual(HebrewCalendar.yearContaining(julianDayNumber: -3304494), -9999)
//		XCTAssertEqual(HebrewCalendar.yearContaining(julianDayNumber: -36176711), -99999)
//		XCTAssertEqual(HebrewCalendar.yearContaining(julianDayNumber: -364898823), -999999)
	}

	func testDateValidation() {
		XCTAssertTrue(HebrewCalendar.isDateValid(year: 3, month: 6, day: 30))
		XCTAssertFalse(HebrewCalendar.isDateValid(year: 4, month: 6, day: 30))
	}

	func testLeapYear() {
		XCTAssertFalse(HebrewCalendar.isLeapYear(1))
		XCTAssertFalse(HebrewCalendar.isLeapYear(2))
		XCTAssertTrue(HebrewCalendar.isLeapYear(3))
		XCTAssertFalse(HebrewCalendar.isLeapYear(4))
		XCTAssertFalse(HebrewCalendar.isLeapYear(5))
		XCTAssertTrue(HebrewCalendar.isLeapYear(6))
		XCTAssertFalse(HebrewCalendar.isLeapYear(7))
		XCTAssertTrue(HebrewCalendar.isLeapYear(8))
		XCTAssertFalse(HebrewCalendar.isLeapYear(9))
		XCTAssertFalse(HebrewCalendar.isLeapYear(10))
		XCTAssertTrue(HebrewCalendar.isLeapYear(11))
		XCTAssertFalse(HebrewCalendar.isLeapYear(12))
		XCTAssertFalse(HebrewCalendar.isLeapYear(13))
		XCTAssertTrue(HebrewCalendar.isLeapYear(14))
		XCTAssertFalse(HebrewCalendar.isLeapYear(15))
		XCTAssertFalse(HebrewCalendar.isLeapYear(16))
		XCTAssertTrue(HebrewCalendar.isLeapYear(17))
		XCTAssertFalse(HebrewCalendar.isLeapYear(18))
		XCTAssertTrue(HebrewCalendar.isLeapYear(19))

		XCTAssertTrue(HebrewCalendar.isLeapYear(0))
		XCTAssertFalse(HebrewCalendar.isLeapYear(-1))
		XCTAssertTrue(HebrewCalendar.isLeapYear(-2))
		XCTAssertFalse(HebrewCalendar.isLeapYear(-3))
		XCTAssertFalse(HebrewCalendar.isLeapYear(-4))
		XCTAssertTrue(HebrewCalendar.isLeapYear(-5))
		XCTAssertFalse(HebrewCalendar.isLeapYear(-6))
		XCTAssertFalse(HebrewCalendar.isLeapYear(-7))
		XCTAssertTrue(HebrewCalendar.isLeapYear(-8))
		XCTAssertFalse(HebrewCalendar.isLeapYear(-9))
		XCTAssertFalse(HebrewCalendar.isLeapYear(-10))
		XCTAssertTrue(HebrewCalendar.isLeapYear(-11))
		XCTAssertFalse(HebrewCalendar.isLeapYear(-12))
		XCTAssertTrue(HebrewCalendar.isLeapYear(-13))
		XCTAssertFalse(HebrewCalendar.isLeapYear(-14))
		XCTAssertFalse(HebrewCalendar.isLeapYear(-15))
		XCTAssertTrue(HebrewCalendar.isLeapYear(-16))
		XCTAssertFalse(HebrewCalendar.isLeapYear(-17))
		XCTAssertFalse(HebrewCalendar.isLeapYear(-18))

		XCTAssertTrue(HebrewCalendar.isLeapYear(-100))
	}

	func testMonthCount() {
		XCTAssertEqual(HebrewCalendar.monthsInYear(1), 12)
		XCTAssertEqual(HebrewCalendar.monthsInYear(2), 12)
		XCTAssertEqual(HebrewCalendar.monthsInYear(3), 13)
		XCTAssertEqual(HebrewCalendar.monthsInYear(4), 12)
		XCTAssertEqual(HebrewCalendar.monthsInYear(5), 12)
		XCTAssertEqual(HebrewCalendar.monthsInYear(6), 13)
		XCTAssertEqual(HebrewCalendar.monthsInYear(7), 12)
		XCTAssertEqual(HebrewCalendar.monthsInYear(8), 13)
		XCTAssertEqual(HebrewCalendar.monthsInYear(9), 12)
		XCTAssertEqual(HebrewCalendar.monthsInYear(10), 12)
		XCTAssertEqual(HebrewCalendar.monthsInYear(11), 13)
		XCTAssertEqual(HebrewCalendar.monthsInYear(12), 12)
		XCTAssertEqual(HebrewCalendar.monthsInYear(13), 12)
		XCTAssertEqual(HebrewCalendar.monthsInYear(14), 13)
		XCTAssertEqual(HebrewCalendar.monthsInYear(15), 12)
		XCTAssertEqual(HebrewCalendar.monthsInYear(16), 12)
		XCTAssertEqual(HebrewCalendar.monthsInYear(17), 13)
		XCTAssertEqual(HebrewCalendar.monthsInYear(18), 12)
		XCTAssertEqual(HebrewCalendar.monthsInYear(19), 13)

		XCTAssertEqual(HebrewCalendar.monthsInYear(0), 13)
		XCTAssertEqual(HebrewCalendar.monthsInYear(-1), 12)
		XCTAssertEqual(HebrewCalendar.monthsInYear(-2), 13)
		XCTAssertEqual(HebrewCalendar.monthsInYear(-3), 12)
		XCTAssertEqual(HebrewCalendar.monthsInYear(-4), 12)
		XCTAssertEqual(HebrewCalendar.monthsInYear(-5), 13)
		XCTAssertEqual(HebrewCalendar.monthsInYear(-6), 12)
		XCTAssertEqual(HebrewCalendar.monthsInYear(-7), 12)
		XCTAssertEqual(HebrewCalendar.monthsInYear(-8), 13)
		XCTAssertEqual(HebrewCalendar.monthsInYear(-9), 12)
		XCTAssertEqual(HebrewCalendar.monthsInYear(-10), 12)
		XCTAssertEqual(HebrewCalendar.monthsInYear(-11), 13)
		XCTAssertEqual(HebrewCalendar.monthsInYear(-12), 12)
		XCTAssertEqual(HebrewCalendar.monthsInYear(-13), 13)
		XCTAssertEqual(HebrewCalendar.monthsInYear(-14), 12)
		XCTAssertEqual(HebrewCalendar.monthsInYear(-15), 12)
		XCTAssertEqual(HebrewCalendar.monthsInYear(-16), 13)
		XCTAssertEqual(HebrewCalendar.monthsInYear(-17), 12)
		XCTAssertEqual(HebrewCalendar.monthsInYear(-18), 12)
	}

	func testMonthLength() {
		XCTAssertEqual(HebrewCalendar.daysInMonth(year: 3, month: 6), 30)
		XCTAssertEqual(HebrewCalendar.daysInMonth(year: 4, month: 6), 29)
	}

	func testJulianDayNumber() {
		XCTAssertEqual(HebrewCalendar.julianDayNumberFrom(year: -999999, month: 1, day: 1), -364898823)
		XCTAssertEqual(HebrewCalendar.julianDayNumberFrom(year: -99999, month: 1, day: 1), -36176711)
		XCTAssertEqual(HebrewCalendar.julianDayNumberFrom(year: -9999, month: 1, day: 1), -3304494)
		XCTAssertEqual(HebrewCalendar.julianDayNumberFrom(year: 9999, month: 12, day: 29), 4000075)
		XCTAssertEqual(HebrewCalendar.julianDayNumberFrom(year: 99999, month: 12, day: 29), 36872292)
		XCTAssertEqual(HebrewCalendar.julianDayNumberFrom(year: 999999, month: 12, day: 29), 365594434)
		XCTAssertEqual(HebrewCalendar.julianDayNumberFrom(year: 2000, month: 1, day: 1), 1078112)
		XCTAssertEqual(HebrewCalendar.julianDayNumberFrom(year: -5000, month: 1, day: 1), -1478617)

		XCTAssertTrue(HebrewCalendar.dateFromJulianDayNumber(-364898823) == (-999999, 1, 1))
		XCTAssertTrue(HebrewCalendar.dateFromJulianDayNumber(-36176711) == (-99999, 1, 1))
		XCTAssertTrue(HebrewCalendar.dateFromJulianDayNumber(-3304494) == (-9999, 1, 1))
		XCTAssertTrue(HebrewCalendar.dateFromJulianDayNumber(4000075) == (9999, 12, 29))
		XCTAssertTrue(HebrewCalendar.dateFromJulianDayNumber(36872292) == (99999, 12, 29))
		XCTAssertTrue(HebrewCalendar.dateFromJulianDayNumber(365594434) == (999999, 12, 29))
		XCTAssertTrue(HebrewCalendar.dateFromJulianDayNumber(0) == (-952, 4, 20))
		XCTAssertTrue(HebrewCalendar.dateFromJulianDayNumber(1078112) == (2000, 1, 1))
		XCTAssertTrue(HebrewCalendar.dateFromJulianDayNumber(-1478617) == (-5000, 1, 1))
	}

	func testLimits() {
		XCTAssertEqual(HebrewCalendar.julianDateFrom(year: -999999, month: 1, day: 1), -364898823.5)
		XCTAssertEqual(HebrewCalendar.julianDateFrom(year: -99999, month: 1, day: 1), -36176711.5)
		XCTAssertEqual(HebrewCalendar.julianDateFrom(year: -9999, month: 1, day: 1), -3304494.5)
		XCTAssertEqual(HebrewCalendar.julianDateFrom(year: 9999, month: 12, day: 29), 4000074.5)
		XCTAssertEqual(HebrewCalendar.julianDateFrom(year: 99999, month: 12, day: 29), 36872291.5)
		XCTAssertEqual(HebrewCalendar.julianDateFrom(year: 999999, month: 12, day: 29), 365594433.5)

		XCTAssertTrue(HebrewCalendar.dateAndTimeFromJulianDate(-364898823.5) == (-999999, 1, 1, 0, 0, 0))
		XCTAssertTrue(HebrewCalendar.dateAndTimeFromJulianDate(-36176711.5) == (-99999, 1, 1, 0, 0, 0))
		XCTAssertTrue(HebrewCalendar.dateAndTimeFromJulianDate(-3304494.5) == (-9999, 1, 1, 0, 0, 0))
		XCTAssertTrue(HebrewCalendar.dateAndTimeFromJulianDate(4000074.5) == (9999, 12, 29, 0, 0, 0))
		XCTAssertTrue(HebrewCalendar.dateAndTimeFromJulianDate(36872291.5) == (99999, 12, 29, 0, 0, 0))
		XCTAssertTrue(HebrewCalendar.dateAndTimeFromJulianDate(365594433.5) == (999999, 12, 29, 0, 0, 0))
	}

	func testArithmeticLimits() {
		var Y, M, D, h, m: Int
		var s: Double

		// Values smaller than this cause an arithmetic overflow in dateFromJulianDayNumber
//		let smallestJDNForHebrewCalendar = -9223372036747815981
		// JDN -9223372036747815627 equals date (-25252436095246078-01-01) which is the smallest round-trippable value
		// Values smaller than this cause an arithmetic overflow in julianDayNumberFrom
		let smallestJDNForHebrewCalendar = -9223372036747815627
		(Y, M, D) = HebrewCalendar.dateFromJulianDayNumber(smallestJDNForHebrewCalendar)
		var jdn = HebrewCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		XCTAssertEqual(smallestJDNForHebrewCalendar, jdn)

		// Values larger than this cause an arithmetic overflow in dateFromJulianDayNumber
		
		let largestJDNForHebrewCalendar = 355839970905570
		(Y, M, D) = HebrewCalendar.dateFromJulianDayNumber(largestJDNForHebrewCalendar)
		jdn = HebrewCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		XCTAssertEqual(largestJDNForHebrewCalendar, jdn)

		// Values smaller than this cause an arithmetic overflow in dateAndTimeFromJulianDate
//		let smallestJDForHebrewCalendar = -0x1.ffffffffe67fbp+62
		// JD -0x1.ffffffffe67fap+62 equals date (-25252436095246077-13-07 00:00:00) which is the smallest round-trippable value
		// Values smaller than this cause an arithmetic overflow in julianDateFrom
		let smallestJDForHebrewCalendar = -0x1.ffffffffe67fap+62
		(Y, M, D, h, m, s) = HebrewCalendar.dateAndTimeFromJulianDate(smallestJDForHebrewCalendar)
		var jd = HebrewCalendar.julianDateFrom(year: Y, month: M, day: D, hour: h, minute: m, second: s)
		XCTAssertEqual(smallestJDForHebrewCalendar, jd)

		// Values larger than this cause an arithmetic overflow in dateAndTimeFromJulianDate
		let largestJDForHebrewCalendar = 0x1.43a273100de27p+48
		(Y, M, D, h, m, s) = HebrewCalendar.dateAndTimeFromJulianDate(largestJDForHebrewCalendar)
		jd = HebrewCalendar.julianDateFrom(year: Y, month: M, day: D, hour: h, minute: m, second: s)
		XCTAssertEqual(largestJDForHebrewCalendar, jd)
	}
}
