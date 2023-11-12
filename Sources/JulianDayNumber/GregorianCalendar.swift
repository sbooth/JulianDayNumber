//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// The Gregorian calendar.
///
/// The Gregorian calendar, like the Julian calendar, is a solar calendar with 12 months of 28–31 days each.
/// The year in both calendars consists of 365 days, with a leap day being added to February in the leap years.
/// The months and length of months in the Gregorian calendar are the same as for the Julian calendar.
/// The only difference is that the Gregorian reform omitted a leap day in three centurial years every 400 years and left the leap day unchanged.
///
/// The Gregorian calendar took effect on October 15, 1582. Julian Thursday, October 4 was followed by Gregorian Friday, October 15.
///
/// The Gregorian calendar epoch in the Julian calendar is January 1, 1 AD.
///
/// - note: The actual adoption date of the Gregorian calendar varies by country.
///
/// - seealso: [Gregorian calendar](https://en.wikipedia.org/wiki/Gregorian_calendar)
public struct GregorianCalendar {
	/// The Julian day number when the Gregorian calendar took effect.
	///
	/// This JDN corresponds to noon on October 15, 1582 in the Gregorian calendar.
	public static let effectiveJulianDayNumber: JulianDayNumber = 2299161

	/// The Julian date when the Gregorian calendar took effect.
	///
	/// This JD corresponds to midnight on October 15, 1582 in the Gregorian calendar.
	public static let effectiveJulianDate: JulianDate = 2299160.5

	/// The Julian day number of the epoch of the Gregorian calendar.
	///
	/// This JDN corresponds to noon on January 1, 1 AD in the Julian calendar.
	public static let epochJulianDayNumber = JulianCalendar.epochJulianDayNumber

	/// The Julian date of the epoch of the Gregorian calendar.
	///
	/// This JD corresponds to midnight on January 1, 1 AD in the Julian calendar.
	public static let epochJulianDate = JulianCalendar.epochJulianDate

	/// A year in the Gregorian calendar.
	public typealias Year = JulianCalendar.Year

	/// A month in the Gregorian calendar numbered from `1` (January) to `12` (December).
	public typealias Month = JulianCalendar.Month

	/// A day in the Gregorian calendar numbered starting from `1`.
	public typealias Day = JulianCalendar.Day

	/// Returns `true` if the specified year, month, and day form a valid date in the Gregorian calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	/// - parameter D: A day number.
	///
	/// - returns: `true` if the specified year, month, and day form a valid date in the Gregorian calendar.
	public static func isDateValid(year Y: Year, month M: Month, day D: Day) -> Bool {
		M > 0 && M <= 12 && D > 0 && D <= daysInMonth(year: Y, month: M)
	}

	/// Returns `true` if the specified Julian day number occurred before the Gregorian calendar took effect.
	///
	/// The Gregorian calendar took effect on JDN 2299161.
	///
	/// - parameter julianDayNumber: A Julian day number.
	///
	/// - returns: `true` if the specified specified Julian day number occurred before the Gregorian calendar took effect.
	public static func isProleptic(julianDayNumber: JulianDayNumber) -> Bool {
		julianDayNumber < effectiveJulianDayNumber
	}

	/// Returns `true` if the specified Julian date occurred before the Gregorian calendar took effect.
	///
	/// The Gregorian calendar took effect on JD 2299160.5.
	///
	/// - parameter julianDate: A Julian date.
	///
	/// - returns: `true` if the specified specified Julian date occurred before the Gregorian calendar took effect.
	public static func isProleptic(julianDate: JulianDate) -> Bool {
		julianDate < effectiveJulianDate
	}

	/// Returns `true` if the specified year is a leap year in the Gregorian calendar.
	///
	/// A Gregorian year is a leap (bissextile) year if its numerical designation is divisible by 4
	/// excluding centurial years *not* divisible by 400.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: `true` if the specified year is a leap year in the Gregorian calendar.
	public static func isLeapYear(_ Y: Year) -> Bool {
		Y % 100 == 0 ? Y % 400 == 0 : Y % 4 == 0
	}

	/// The number of months in one year.
	public static let monthsInYear = 12

	/// The number of days in each month indexed from `0` (January) to `11` (December).
	static let monthLengths = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ]

	/// Returns the number of days in the specified month and year in the Gregorian calendar.
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

	/// Returns the month and day of Easter in the specified year in the Gregorian calendar.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: The month and day of Easter in the specified year.
	public static func easter(year Y: Year) -> (month: Month, day: Day) {
		// Algorithm from the Explanatory Supplement to the Astronomical Almanac, 3rd edition, S.E Urban and P.K. Seidelmann eds., (Mill Valley, CA: University Science Books), Chapter 15, pp. 585-624.
		let a = Y / 100
		let b = a - a / 4
		let c = (Y % 19)
		let e = ((15 + 19 * c + b - (a - (a - 17) / 25) / 3) % 30)
		let f = e - (c + 11 * e) / 319
		let g = 22 + f + ((140004 - Y - Y / 4 + b - f) % 7)
		let M = 3 + g / 32
		let D = 1 + ((g - 1) % 31)
		return (M, D)
	}
}
