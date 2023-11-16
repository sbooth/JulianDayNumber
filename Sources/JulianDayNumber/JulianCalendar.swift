//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// The Julian calendar is a solar calendar with 365 days in the year plus an additional leap day every fourth year.
///
/// The year consists of twelve months. The second month contains an additional day in leap years.
///
/// | Month | Name | Days |
/// | ---: | --- | --- |
/// | 1 | January | 31 |
/// | 2 | February | 28 (29 in leap years) |
/// | 3 | March | 31 |
/// | 4 | April | 30 |
/// | 5 | May | 31 |
/// | 6 | June | 30 |
/// | 7 | July | 31 |
/// | 8 | August | 31 |
/// | 9 | September | 30 |
/// | 19 | October | 31 |
/// | 11 | November | 30 |
/// | 12 | December | 31 |
///
/// The Julian calendar took effect on January 1, 45 BCE.
///
/// The Julian calendar epoch in the Julian calendar is January 1, 1 CE.
///
/// - seealso: [Julian calendar](https://en.wikipedia.org/wiki/Julian_calendar)
public struct JulianCalendar {
	/// The Julian day number when the Julian calendar took effect.
	///
	/// This JDN corresponds to noon on January 1, 45 BCE in the Julian calendar.
	public static let effectiveJulianDayNumber: JulianDayNumber = 1704987

	/// The Julian date when the Julian calendar took effect.
	///
	/// This JD corresponds to midnight on January 1, 45 BCE in the Julian calendar.
	public static let effectiveJulianDate: JulianDate = 1704986.5

	/// The Julian day number of the epoch of the Julian calendar.
	///
	/// This JDN corresponds to noon on January 1, 1 CE in the Julian calendar.
	public static let epochJulianDayNumber: JulianDayNumber = 1721424

	/// The Julian date of the epoch of the Julian calendar.
	///
	/// This JD corresponds to midnight on January 1, 1 CE in the Julian calendar.
	public static let epochJulianDate: JulianDate = 1721423.5

	/// A year in the Julian calendar.
	///
	/// - important: The year preceding CE 1, commonly referred to as 1 BCE, is year `0`.
	public typealias Year = Int

	/// A month in the Julian calendar numbered from `1` (January) to `12` (December).
	public typealias Month = Int

	/// A day in the Julian calendar numbered starting from `1`.
	public typealias Day = Int

	/// Returns `true` if the specified year, month, and day form a valid date in the Julian calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	/// - parameter D: A day number.
	///
	/// - returns: `true` if the specified year, month, and day form a valid date in the Julian calendar.
	public static func isDateValid(year Y: Year, month M: Month, day D: Day) -> Bool {
		M > 0 && M <= 12 && D > 0 && D <= daysInMonth(year: Y, month: M)
	}

	/// Returns `true` if the specified Julian day number occurred before the Julian calendar took effect.
	///
	/// The Julian calendar took effect on JDN 1704987.
	///
	/// - parameter julianDayNumber: A Julian day number.
	///
	/// - returns: `true` if the specified specified Julian day number occurred before the Julian calendar took effect.
	public static func isProleptic(julianDayNumber: JulianDayNumber) -> Bool {
		julianDayNumber < effectiveJulianDayNumber
	}

	/// Returns `true` if the specified Julian date occurred before the Julian calendar took effect.
	///
	/// The Julian calendar took effect on JD 1704986.5.
	///
	/// - parameter julianDate: A Julian date.
	///
	/// - returns: `true` if the specified specified Julian date occurred before the Julian calendar took effect.
	public static func isProleptic(julianDate: JulianDate) -> Bool {
		julianDate < effectiveJulianDate
	}

	/// Returns `true` if the specified year is a leap year in the Julian calendar.
	///
	/// A Julian year is a leap (bissextile) year if its numerical designation is divisible by 4.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: `true` if the specified year is a leap year in the Julian calendar.
	public static func isLeapYear(_ Y: Year) -> Bool {
		Y % 4 == 0
	}

	/// The number of months in one year.
	public static let monthsInYear = 12

	/// The number of days in each month indexed from `0` (January) to `11` (December).
	static let monthLengths = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ]

	/// Returns the number of days in the specified month and year in the Julian calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	///
	/// - returns: The number of days in the specified month and year.
	public static func daysInMonth(year Y: Year, month M: Month) -> Int {
		guard M > 0, M <= 12 else {
			return 0
		}

		if M == 2 {
			return isLeapYear(Y) ? 29 : 28
		} else {
			return monthLengths[M - 1]
		}
	}

	/// Returns the day of the week for the specified Julian day number.
	///
	/// - parameter J: A Julian day number.
	///
	/// - returns: The day of week from `1` (Sunday) to `7` (Saturday) correponding to the specified Julian day number.
	public static func dayOfWeek(_ J: JulianDayNumber) -> Int {
		1 + (J + 1) % 7
	}

	/// Returns the month and day of Easter in the specified year in the Julian calendar.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: The month and day of Easter in the specified year.
	public static func easter(year Y: Year) -> (month: Month, day: Day) {
		// Algorithm from the Explanatory Supplement to the Astronomical Almanac, 3rd edition, S.E Urban and P.K. Seidelmann eds., (Mill Valley, CA: University Science Books), Chapter 15, pp. 585-624.
		let a = 22 + ((225 - 11 * (Y % 19)) % 30)
		let g = a + ((56 + 6 * Y - Y / 4 - a) % 7)
		let M = 3 + g / 32
		let D = 1 + ((g - 1) % 31)
		return (M, D)
	}
}

extension JulianCalendar: JulianDayNumberConverting {
	/// A date in the Julian calendar consists of a year, month, and day.
	public typealias DateType = (year: Year, month: Month, day: Day)

	/// The converter for the Julian calendar.
	static let converter = JulianDayNumberConverter(y: 4716, j: 1401, m: 2, n: 12, r: 4, p: 1461, q: 0, v: 3, u: 5, s: 153, t: 2, w: 2)

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		converter.julianDayNumberFromDate(date)
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		converter.dateFromJulianDayNumber(J)
	}
}
