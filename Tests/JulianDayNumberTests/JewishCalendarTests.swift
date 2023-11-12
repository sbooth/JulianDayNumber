//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import XCTest
@testable import JulianDayNumber

final class JewishCalendarTests: XCTestCase {
	func testFirstDayOfTishri() {
		XCTAssertEqual(JewishCalendar.firstDayOfTishri(year: 1), 347998)
		XCTAssertEqual(JewishCalendar.firstDayOfTishri(year: 2), 348353)
		XCTAssertEqual(JewishCalendar.firstDayOfTishri(year: 3), 348708)
		XCTAssertEqual(JewishCalendar.firstDayOfTishri(year: 4), 349091)
		XCTAssertEqual(JewishCalendar.firstDayOfTishri(year: 5), 349445)
		XCTAssertEqual(JewishCalendar.firstDayOfTishri(year: 6), 349800)
		XCTAssertEqual(JewishCalendar.firstDayOfTishri(year: 7), 350185)
		XCTAssertEqual(JewishCalendar.firstDayOfTishri(year: 8), 350539)
		XCTAssertEqual(JewishCalendar.firstDayOfTishri(year: 9), 350922)
		XCTAssertEqual(JewishCalendar.firstDayOfTishri(year: 10), 351277)
		XCTAssertEqual(JewishCalendar.firstDayOfTishri(year: 11), 351631)
		XCTAssertEqual(JewishCalendar.firstDayOfTishri(year: 12), 352014)
		XCTAssertEqual(JewishCalendar.firstDayOfTishri(year: 13), 352369)
		XCTAssertEqual(JewishCalendar.firstDayOfTishri(year: 14), 352723)
		XCTAssertEqual(JewishCalendar.firstDayOfTishri(year: 15), 353108)
		XCTAssertEqual(JewishCalendar.firstDayOfTishri(year: 16), 353461)
		XCTAssertEqual(JewishCalendar.firstDayOfTishri(year: 17), 353815)
		XCTAssertEqual(JewishCalendar.firstDayOfTishri(year: 18), 354200)
		XCTAssertEqual(JewishCalendar.firstDayOfTishri(year: 19), 354555)

//		XCTAssertEqual(JewishCalendar.firstDayOfTishri(year: 0), 347614)
//		XCTAssertEqual(JewishCalendar.firstDayOfTishri(year: -1), 347261)
//		XCTAssertEqual(JewishCalendar.firstDayOfTishri(year: -2), 346876)
//		XCTAssertEqual(JewishCalendar.firstDayOfTishri(year: -3), 346521)
//		XCTAssertEqual(JewishCalendar.firstDayOfTishri(year: -4), 346167)
//		XCTAssertEqual(JewishCalendar.firstDayOfTishri(year: -951), 276)
//		XCTAssertEqual(JewishCalendar.firstDayOfTishri(year: -952), -109)
//		XCTAssertEqual(JewishCalendar.firstDayOfTishri(year: -953), -462)

		XCTAssertEqual(JewishCalendar.firstDayOfTishri(year: 999999), 365594080)
		XCTAssertEqual(JewishCalendar.firstDayOfTishri(year: 99999), 36871940)
		XCTAssertEqual(JewishCalendar.firstDayOfTishri(year: 9999), 3999723)
//		XCTAssertEqual(JewishCalendar.firstDayOfTishri(year: -9999), -3304494)
//		XCTAssertEqual(JewishCalendar.firstDayOfTishri(year: -99999), -36176711)
//		XCTAssertEqual(JewishCalendar.firstDayOfTishri(year: -999999), -364898823)
	}

	func testYearContaining() {
		XCTAssertEqual(JewishCalendar.yearContaining(julianDayNumber: 347998), 1)
		XCTAssertEqual(JewishCalendar.yearContaining(julianDayNumber: 348353), 2)
		XCTAssertEqual(JewishCalendar.yearContaining(julianDayNumber: 348708), 3)
		XCTAssertEqual(JewishCalendar.yearContaining(julianDayNumber: 349091), 4)
		XCTAssertEqual(JewishCalendar.yearContaining(julianDayNumber: 349445), 5)
		XCTAssertEqual(JewishCalendar.yearContaining(julianDayNumber: 349800), 6)
		XCTAssertEqual(JewishCalendar.yearContaining(julianDayNumber: 350185), 7)
		XCTAssertEqual(JewishCalendar.yearContaining(julianDayNumber: 350539), 8)
		XCTAssertEqual(JewishCalendar.yearContaining(julianDayNumber: 350922), 9)
		XCTAssertEqual(JewishCalendar.yearContaining(julianDayNumber: 351277), 10)
		XCTAssertEqual(JewishCalendar.yearContaining(julianDayNumber: 351631), 11)
		XCTAssertEqual(JewishCalendar.yearContaining(julianDayNumber: 352014), 12)
		XCTAssertEqual(JewishCalendar.yearContaining(julianDayNumber: 352369), 13)
		XCTAssertEqual(JewishCalendar.yearContaining(julianDayNumber: 352723), 14)
		XCTAssertEqual(JewishCalendar.yearContaining(julianDayNumber: 353108), 15)
		XCTAssertEqual(JewishCalendar.yearContaining(julianDayNumber: 353461), 16)
		XCTAssertEqual(JewishCalendar.yearContaining(julianDayNumber: 353815), 17)
		XCTAssertEqual(JewishCalendar.yearContaining(julianDayNumber: 354200), 18)
		XCTAssertEqual(JewishCalendar.yearContaining(julianDayNumber: 354555), 19)

//		XCTAssertEqual(JewishCalendar.yearContaining(julianDayNumber: 347614), 0)
//		XCTAssertEqual(JewishCalendar.yearContaining(julianDayNumber: 347261), -1)
//		XCTAssertEqual(JewishCalendar.yearContaining(julianDayNumber: 346876), -2)
//		XCTAssertEqual(JewishCalendar.yearContaining(julianDayNumber: 346521), -3)
//		XCTAssertEqual(JewishCalendar.yearContaining(julianDayNumber: 346167), -4)
//		XCTAssertEqual(JewishCalendar.yearContaining(julianDayNumber: 276), -951)
//		XCTAssertEqual(JewishCalendar.yearContaining(julianDayNumber: -109), -952)
//		XCTAssertEqual(JewishCalendar.yearContaining(julianDayNumber: -462), -953)

		XCTAssertEqual(JewishCalendar.yearContaining(julianDayNumber: 365594080), 999999)
		XCTAssertEqual(JewishCalendar.yearContaining(julianDayNumber: 36871940), 99999)
		XCTAssertEqual(JewishCalendar.yearContaining(julianDayNumber: 3999723), 9999)
//		XCTAssertEqual(JewishCalendar.yearContaining(julianDayNumber: -3304494), -9999)
//		XCTAssertEqual(JewishCalendar.yearContaining(julianDayNumber: -36176711), -99999)
//		XCTAssertEqual(JewishCalendar.yearContaining(julianDayNumber: -364898823), -999999)
	}

	func testDateValidation() {
		XCTAssertTrue(JewishCalendar.isDateValid(year: 3, month: 6, day: 30))
		XCTAssertFalse(JewishCalendar.isDateValid(year: 4, month: 6, day: 30))
	}

	func testLeapYear() {
		XCTAssertFalse(JewishCalendar.isLeapYear(1))
		XCTAssertFalse(JewishCalendar.isLeapYear(2))
		XCTAssertTrue(JewishCalendar.isLeapYear(3))
		XCTAssertFalse(JewishCalendar.isLeapYear(4))
		XCTAssertFalse(JewishCalendar.isLeapYear(5))
		XCTAssertTrue(JewishCalendar.isLeapYear(6))
		XCTAssertFalse(JewishCalendar.isLeapYear(7))
		XCTAssertTrue(JewishCalendar.isLeapYear(8))
		XCTAssertFalse(JewishCalendar.isLeapYear(9))
		XCTAssertFalse(JewishCalendar.isLeapYear(10))
		XCTAssertTrue(JewishCalendar.isLeapYear(11))
		XCTAssertFalse(JewishCalendar.isLeapYear(12))
		XCTAssertFalse(JewishCalendar.isLeapYear(13))
		XCTAssertTrue(JewishCalendar.isLeapYear(14))
		XCTAssertFalse(JewishCalendar.isLeapYear(15))
		XCTAssertFalse(JewishCalendar.isLeapYear(16))
		XCTAssertTrue(JewishCalendar.isLeapYear(17))
		XCTAssertFalse(JewishCalendar.isLeapYear(18))
		XCTAssertTrue(JewishCalendar.isLeapYear(19))

		XCTAssertTrue(JewishCalendar.isLeapYear(0))
		XCTAssertFalse(JewishCalendar.isLeapYear(-1))
		XCTAssertTrue(JewishCalendar.isLeapYear(-2))
		XCTAssertFalse(JewishCalendar.isLeapYear(-3))
		XCTAssertFalse(JewishCalendar.isLeapYear(-4))
		XCTAssertTrue(JewishCalendar.isLeapYear(-5))
		XCTAssertFalse(JewishCalendar.isLeapYear(-6))
		XCTAssertFalse(JewishCalendar.isLeapYear(-7))
		XCTAssertTrue(JewishCalendar.isLeapYear(-8))
		XCTAssertFalse(JewishCalendar.isLeapYear(-9))
		XCTAssertFalse(JewishCalendar.isLeapYear(-10))
		XCTAssertTrue(JewishCalendar.isLeapYear(-11))
		XCTAssertFalse(JewishCalendar.isLeapYear(-12))
		XCTAssertTrue(JewishCalendar.isLeapYear(-13))
		XCTAssertFalse(JewishCalendar.isLeapYear(-14))
		XCTAssertFalse(JewishCalendar.isLeapYear(-15))
		XCTAssertTrue(JewishCalendar.isLeapYear(-16))
		XCTAssertFalse(JewishCalendar.isLeapYear(-17))
		XCTAssertFalse(JewishCalendar.isLeapYear(-18))

		XCTAssertTrue(JewishCalendar.isLeapYear(-100))
	}

	func testMonthCount() {
		XCTAssertEqual(JewishCalendar.monthsInYear(1), 12)
		XCTAssertEqual(JewishCalendar.monthsInYear(2), 12)
		XCTAssertEqual(JewishCalendar.monthsInYear(3), 13)
		XCTAssertEqual(JewishCalendar.monthsInYear(4), 12)
		XCTAssertEqual(JewishCalendar.monthsInYear(5), 12)
		XCTAssertEqual(JewishCalendar.monthsInYear(6), 13)
		XCTAssertEqual(JewishCalendar.monthsInYear(7), 12)
		XCTAssertEqual(JewishCalendar.monthsInYear(8), 13)
		XCTAssertEqual(JewishCalendar.monthsInYear(9), 12)
		XCTAssertEqual(JewishCalendar.monthsInYear(10), 12)
		XCTAssertEqual(JewishCalendar.monthsInYear(11), 13)
		XCTAssertEqual(JewishCalendar.monthsInYear(12), 12)
		XCTAssertEqual(JewishCalendar.monthsInYear(13), 12)
		XCTAssertEqual(JewishCalendar.monthsInYear(14), 13)
		XCTAssertEqual(JewishCalendar.monthsInYear(15), 12)
		XCTAssertEqual(JewishCalendar.monthsInYear(16), 12)
		XCTAssertEqual(JewishCalendar.monthsInYear(17), 13)
		XCTAssertEqual(JewishCalendar.monthsInYear(18), 12)
		XCTAssertEqual(JewishCalendar.monthsInYear(19), 13)

		XCTAssertEqual(JewishCalendar.monthsInYear(0), 13)
		XCTAssertEqual(JewishCalendar.monthsInYear(-1), 12)
		XCTAssertEqual(JewishCalendar.monthsInYear(-2), 13)
		XCTAssertEqual(JewishCalendar.monthsInYear(-3), 12)
		XCTAssertEqual(JewishCalendar.monthsInYear(-4), 12)
		XCTAssertEqual(JewishCalendar.monthsInYear(-5), 13)
		XCTAssertEqual(JewishCalendar.monthsInYear(-6), 12)
		XCTAssertEqual(JewishCalendar.monthsInYear(-7), 12)
		XCTAssertEqual(JewishCalendar.monthsInYear(-8), 13)
		XCTAssertEqual(JewishCalendar.monthsInYear(-9), 12)
		XCTAssertEqual(JewishCalendar.monthsInYear(-10), 12)
		XCTAssertEqual(JewishCalendar.monthsInYear(-11), 13)
		XCTAssertEqual(JewishCalendar.monthsInYear(-12), 12)
		XCTAssertEqual(JewishCalendar.monthsInYear(-13), 13)
		XCTAssertEqual(JewishCalendar.monthsInYear(-14), 12)
		XCTAssertEqual(JewishCalendar.monthsInYear(-15), 12)
		XCTAssertEqual(JewishCalendar.monthsInYear(-16), 13)
		XCTAssertEqual(JewishCalendar.monthsInYear(-17), 12)
		XCTAssertEqual(JewishCalendar.monthsInYear(-18), 12)
	}

	func testMonthLength() {
		XCTAssertEqual(JewishCalendar.daysInMonth(year: 3, month: 6), 30)
		XCTAssertEqual(JewishCalendar.daysInMonth(year: 4, month: 6), 29)
	}

	func testJulianDayNumber() {
		XCTAssertEqual(JewishCalendar.julianDayNumberFrom(year: -999999, month: 1, day: 1), -364898823)
		XCTAssertEqual(JewishCalendar.julianDayNumberFrom(year: -99999, month: 1, day: 1), -36176711)
		XCTAssertEqual(JewishCalendar.julianDayNumberFrom(year: -9999, month: 1, day: 1), -3304494)
		XCTAssertEqual(JewishCalendar.julianDayNumberFrom(year: 9999, month: 12, day: 29), 4000075)
		XCTAssertEqual(JewishCalendar.julianDayNumberFrom(year: 99999, month: 12, day: 29), 36872292)
		XCTAssertEqual(JewishCalendar.julianDayNumberFrom(year: 999999, month: 12, day: 29), 365594434)
		XCTAssertEqual(JewishCalendar.julianDayNumberFrom(year: 2000, month: 1, day: 1), 1078112)
		XCTAssertEqual(JewishCalendar.julianDayNumberFrom(year: -5000, month: 1, day: 1), -1478617)

		XCTAssertTrue(JewishCalendar.dateFromJulianDayNumber(-364898823) == (-999999, 1, 1))
		XCTAssertTrue(JewishCalendar.dateFromJulianDayNumber(-36176711) == (-99999, 1, 1))
		XCTAssertTrue(JewishCalendar.dateFromJulianDayNumber(-3304494) == (-9999, 1, 1))
		XCTAssertTrue(JewishCalendar.dateFromJulianDayNumber(4000075) == (9999, 12, 29))
		XCTAssertTrue(JewishCalendar.dateFromJulianDayNumber(36872292) == (99999, 12, 29))
		XCTAssertTrue(JewishCalendar.dateFromJulianDayNumber(365594434) == (999999, 12, 29))
		XCTAssertTrue(JewishCalendar.dateFromJulianDayNumber(0) == (-952, 4, 20))
		XCTAssertTrue(JewishCalendar.dateFromJulianDayNumber(1078112) == (2000, 1, 1))
		XCTAssertTrue(JewishCalendar.dateFromJulianDayNumber(-1478617) == (-5000, 1, 1))
	}

	func testLimits() {
		XCTAssertEqual(JewishCalendar.julianDateFrom(year: -999999, month: 1, day: 1), -364898823.5)
		XCTAssertEqual(JewishCalendar.julianDateFrom(year: -99999, month: 1, day: 1), -36176711.5)
		XCTAssertEqual(JewishCalendar.julianDateFrom(year: -9999, month: 1, day: 1), -3304494.5)
		XCTAssertEqual(JewishCalendar.julianDateFrom(year: 9999, month: 12, day: 29), 4000074.5)
		XCTAssertEqual(JewishCalendar.julianDateFrom(year: 99999, month: 12, day: 29), 36872291.5)
		XCTAssertEqual(JewishCalendar.julianDateFrom(year: 999999, month: 12, day: 29), 365594433.5)

		XCTAssertTrue(JewishCalendar.dateAndTimeFromJulianDate(-364898823.5) == (-999999, 1, 1, 0, 0, 0))
		XCTAssertTrue(JewishCalendar.dateAndTimeFromJulianDate(-36176711.5) == (-99999, 1, 1, 0, 0, 0))
		XCTAssertTrue(JewishCalendar.dateAndTimeFromJulianDate(-3304494.5) == (-9999, 1, 1, 0, 0, 0))
		XCTAssertTrue(JewishCalendar.dateAndTimeFromJulianDate(4000074.5) == (9999, 12, 29, 0, 0, 0))
		XCTAssertTrue(JewishCalendar.dateAndTimeFromJulianDate(36872291.5) == (99999, 12, 29, 0, 0, 0))
		XCTAssertTrue(JewishCalendar.dateAndTimeFromJulianDate(365594433.5) == (999999, 12, 29, 0, 0, 0))
	}

	func testArithmeticLimits() {
		var Y, M, D, h, m: Int
		var s: Double

		// Values smaller than this cause an arithmetic overflow in dateFromJulianDayNumber
//		let smallestJDNForJewishCalendar = -9223372036747815981
		// JDN -9223372036747815627 equals date (-25252436095246078-01-01) which is the smallest round-trippable value
		// Values smaller than this cause an arithmetic overflow in julianDayNumberFrom
		let smallestJDNForJewishCalendar = -9223372036747815627
		(Y, M, D) = JewishCalendar.dateFromJulianDayNumber(smallestJDNForJewishCalendar)
		var jdn = JewishCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		XCTAssertEqual(smallestJDNForJewishCalendar, jdn)

		// Values larger than this cause an arithmetic overflow in dateFromJulianDayNumber
		
		let largestJDNForJewishCalendar = 355839970905570
		(Y, M, D) = JewishCalendar.dateFromJulianDayNumber(largestJDNForJewishCalendar)
		jdn = JewishCalendar.julianDayNumberFrom(year: Y, month: M, day: D)
		XCTAssertEqual(largestJDNForJewishCalendar, jdn)

		// Values smaller than this cause an arithmetic overflow in dateAndTimeFromJulianDate
//		let smallestJDForJewishCalendar = -0x1.ffffffffe67fbp+62
		// JD -0x1.ffffffffe67fap+62 equals date (-25252436095246077-13-07 00:00:00) which is the smallest round-trippable value
		// Values smaller than this cause an arithmetic overflow in julianDateFrom
		let smallestJDForJewishCalendar = -0x1.ffffffffe67fap+62
		(Y, M, D, h, m, s) = JewishCalendar.dateAndTimeFromJulianDate(smallestJDForJewishCalendar)
		var jd = JewishCalendar.julianDateFrom(year: Y, month: M, day: D, hour: h, minute: m, second: s)
		XCTAssertEqual(smallestJDForJewishCalendar, jd)

		// Values larger than this cause an arithmetic overflow in dateAndTimeFromJulianDate
		let largestJDForJewishCalendar = 0x1.43a273100de27p+48
		(Y, M, D, h, m, s) = JewishCalendar.dateAndTimeFromJulianDate(largestJDForJewishCalendar)
		jd = JewishCalendar.julianDateFrom(year: Y, month: M, day: D, hour: h, minute: m, second: s)
		XCTAssertEqual(largestJDForJewishCalendar, jd)
	}
}
