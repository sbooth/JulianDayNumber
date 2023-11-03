//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// A hybrid calendar that uses the Julian calendar for dates before October 15, 1582 and the Gregorian calendar for later dates.
enum AstronomicalCalendar {
	/// Returns `true` if the specified year, month, and day form a valid date in the astromical calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number between `1` (January) and `12` (December).
	/// - parameter D: A day number between `1` and the maximum number of days in month `M` for year `Y`.
	///
	/// - returns: `true` if the specified year, month, and day form a valid date in the astromical calendar.
	public static func isDateValid(year Y: Int, month M: Int, day D: Int) -> Bool {
		(Y, M, D) < GregorianCalendar.effectiveDate ? JulianCalendar.isDateValid(year: Y, month: M, day: D) : GregorianCalendar.isDateValid(year: Y, month: M, day: D)
	}

	/// Returns `true` if the specified year, month, and day occurred before the Gregorian calendar took effect.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number between `1` (January) and `12` (December).
	/// - parameter D: A day number between `1` and the maximum number of days in month `M` for year `Y`.
	///
	/// - returns: `true` if the specified year, month, and day occurred before the Gregorian calendar took effect.
	public static func isJulian(year Y: Int, month M: Int, day D: Int) -> Bool {
		(Y, M, D) < GregorianCalendar.effectiveDate
	}

	/// Returns `true` if the specified Julian day number occurred before the Gregorian calendar took effect.
	///
	/// - parameter julianDayNumber: A Julian day number.
	///
	/// - returns: `true` if the specified specified Julian day number occurred before the Gregorian calendar took effect.
	public static func isJulian(julianDayNumber: Int) -> Bool {
		julianDayNumber < GregorianCalendar.effectiveJulianDayNumber
	}

	/// Returns `true` if the specified Julian date occurred before the Gregorian calendar took effect.
	///
	/// - parameter julianDate: A Julian date.
	///
	/// - returns: `true` if the specified specified Julian date occurred before the Gregorian calendar took effect.
	public static func isJulian(julianDate: Double) -> Bool {
		julianDate < GregorianCalendar.effectiveJulianDate
	}

	/// Returns `true` if the specified year is a leap year in the astromical calendar.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: `true` if the specified year is a leap year in the astromical calendar.
	public static func isLeapYear(_ Y: Int) -> Bool {
		Y < GregorianCalendar.effectiveDate.year ? JulianCalendar.isLeapYear(Y) : GregorianCalendar.isLeapYear(Y)
	}

	/// The number of days in each month indexed from `0` (January) to `11` (December).
	static let monthLengths = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ]

	/// Returns the number of days in the specified month and year in the astromical calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number between `1` (January) and `12` (December).
	///
	/// - returns: The number of days in the specified month and year.
	public static func daysInMonth(year Y: Int, month M: Int) -> Int {
		Y < GregorianCalendar.effectiveDate.year ? JulianCalendar.daysInMonth(year: Y, month: M) : GregorianCalendar.daysInMonth(year: Y, month: M)
	}

	/// Returns the month and day of Easter in the specified year in the astromical calendar.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: The month and day of Easter in the specified year.
	public static func easter(year Y: Int) -> (month: Int, day: Int) {
		Y < GregorianCalendar.effectiveDate.year ? JulianCalendar.easter(year: Y) : GregorianCalendar.easter(year: Y)
	}
}

