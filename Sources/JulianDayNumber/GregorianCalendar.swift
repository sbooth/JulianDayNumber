//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// The year, month, and day of the changeover from Julian to Gregorian calendars.
///
/// The Julian to Gregorian calendar changeover occurred on 1582-10-15.
/// Julian Thursday 1582-10-04 was followed by Gregorian Friday 1582-10-15.
///
/// Dates earlier than this value are typically interpreted in the Julian calendar while equal or later dates are typically interpreted in the Gregorian calendar.
///
/// - note: The actual adoption date of the Gregorian calendar varies by country.
public let gregorianCalendarChangeoverDate = (year: 1582, month: 10, day: 15)

/// The Julian day number of the changeover from Julian to Gregorian calendars.
///
/// The Julian to Gregorian calendar changeover occurred on 1582-10-15.
/// Julian Thursday 1582-10-04 was followed by Gregorian Friday 1582-10-15.
///
/// Julian day numbers less than this value are typically interpreted in the Julian calendar while equal or greater Julian day numbers are typically interpreted in the Gregorian calendar.
///
/// This JDN corresponds to 1582-10-15 12:00 in the Gregorian calendar.
///
/// - note: The actual adoption date of the Gregorian calendar varies by country.
public let gregorianCalendarChangeoverJDN = 2299161

/// The Julian date of the changeover from Julian to Gregorian calendars.
///
/// The Julian to Gregorian calendar changeover occurred on 1582-10-15.
/// Julian Thursday 1582-10-04 was followed by Gregorian Friday 1582-10-15.
///
/// Julian dates less than this value are typically interpreted in the Julian calendar while equal or greater Julian dates are typically interpreted in the Gregorian calendar.
///
/// This JD corresponds to 1582-10-15 00:00 in the Gregorian calendar.
///
/// - note: The actual adoption date of the Gregorian calendar varies by country.
public let gregorianCalendarChangeoverJD = 2299160.5

/// The Gregorian calendar.
///
/// The Gregorian calendar was officially introduced on 1582-10-15.
/// Julian Thursday 1582-10-04 was followed by Gregorian Friday 1582-10-15.
public enum GregorianCalendar {
	/// Returns `true` if the specified year, month, and day form a valid date in the Gregorian calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number between `1` (January) and `12` (December).
	/// - parameter D: A day number between `1` and the maximum number of days in month `M` for year `Y`.
	///
	/// - returns: `true` if the specified year, month, and day form a valid date in the Gregorian calendar.
	static public func isValid(year Y: Int, month M: Int, day D: Int) -> Bool {
		M > 0 && M <= 12 && D > 0 && D <= daysInMonth(year: Y, month: M)
	}

	/// Returns `true` if the specified year, month, and day occurred before the official introduction of the Gregorian calendar.
	///
	/// The Gregorian calendar was officially introduced on 1582-10-15.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number between `1` (January) and `12` (December).
	/// - parameter D: A day number between `1` and the maximum number of days in month `M` for year `Y`.
	///
	/// - returns: `true` if the specified year, month, and day occurred before the official introduction of the Gregorian calendar.
	static public func isProleptic(year Y: Int, month M: Int, day D: Int) -> Bool {
		(Y, M, D) < gregorianCalendarChangeoverDate
	}

	/// Returns `true` if the specified Julian day number occurred before the official introduction of the Gregorian calendar.
	///
	/// The Gregorian calendar was officially introduced on JDN 2299161.
	///
	/// - parameter julianDayNumber: A Julian day number.
	///
	/// - returns: `true` if the specified specified Julian day number occurred before the official introduction of the Gregorian calendar.
	static public func isProleptic(julianDayNumber: Int) -> Bool {
		julianDayNumber < gregorianCalendarChangeoverJDN
	}

	/// Returns `true` if the specified Julian date occurred before the official introduction of the Gregorian calendar.
	///
	/// The Gregorian calendar was officially introduced on JD 2299160.5.
	///
	/// - parameter julianDate: A Julian date.
	///
	/// - returns: `true` if the specified specified Julian date occurred before the official introduction of the Gregorian calendar.
	static public func isProleptic(julianDate: Double) -> Bool {
		julianDate < gregorianCalendarChangeoverJD
	}

	/// Returns `true` if the specified year is a leap year in the Gregorian calendar.
	///
	/// A Gregorian year is a leap (bissextile) year if its numerical designation is divisible by 4
	/// excluding centurial years *not* divisible by 400.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: `true` if the specified year is a leap year in the Gregorian calendar.
	static public func isLeapYear(_ Y: Int) -> Bool {
		Y % 100 == 0 ? Y % 400 == 0 : Y % 4 == 0
	}

	/// The number of days in each month indexed from `0` (January) to `11` (December).
	static let monthLengths = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ]

	/// Returns the number of days in the specified month and year in the Gregorian calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number between `1` (January) and `12` (December).
	///
	/// - returns: The number of days in the specified month and year.
	static public func daysInMonth(year Y: Int, month M: Int) -> Int {
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
	static public func easter(year Y: Int) -> (month: Int, day: Int) {
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
