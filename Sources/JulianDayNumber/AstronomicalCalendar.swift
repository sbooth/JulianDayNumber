//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// A calendar that uses the Julian calendar for dates before 1582-10-15 and the Gregorian calendar for equal or later dates.
enum AstronomicalCalendar {
	/// Returns `true` if the specified year, month, and day form a valid date in the astromical calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number between `1` (January) and `12` (December).
	/// - parameter D: A day number between `1` and the maximum number of days in month `M` for year `Y`.
	///
	/// - returns: `true` if the specified year, month, and day form a valid date in the astromical calendar.
	public static func isValid(year Y: Int, month M: Int, day D: Int) -> Bool {
		(Y, M, D) < GregorianCalendar.changeoverDate ? JulianCalendar.isValid(year: Y, month: M, day: D) : GregorianCalendar.isValid(year: Y, month: M, day: D)
	}

	/// Returns `true` if the specified year, month, and day occurred before the introduction of the Gregorian calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number between `1` (January) and `12` (December).
	/// - parameter D: A day number between `1` and the maximum number of days in month `M` for year `Y`.
	///
	/// - returns: `true` if the specified year, month, and day occurred before the introduction of the Gregorian calendar.
	public static func isJulian(year Y: Int, month M: Int, day D: Int) -> Bool {
		(Y, M, D) < GregorianCalendar.changeoverDate
	}

	/// Returns `true` if the specified Julian day number occurred before the introduction of the Gregorian calendar.
	///
	/// - parameter julianDayNumber: A Julian day number.
	///
	/// - returns: `true` if the specified specified Julian day number occurred before the introduction of the Gregorian calendar.
	public static func isJulian(julianDayNumber: Int) -> Bool {
		julianDayNumber < GregorianCalendar.changeoverJulianDayNumber
	}

	/// Returns `true` if the specified Julian date occurred before the introduction of the Gregorian calendar.
	///
	/// - parameter julianDate: A Julian date.
	///
	/// - returns: `true` if the specified specified Julian date occurred before the introduction of the Gregorian calendar.
	public static func isJulian(julianDate: Double) -> Bool {
		julianDate < GregorianCalendar.changeoverJulianDate
	}

	/// Returns `true` if the specified year is a leap year in the astromical calendar.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: `true` if the specified year is a leap year in the astromical calendar.
	public static func isLeapYear(_ Y: Int) -> Bool {
		Y < GregorianCalendar.changeoverDate.year ? JulianCalendar.isLeapYear(Y) : GregorianCalendar.isLeapYear(Y)
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
		Y < GregorianCalendar.changeoverDate.year ? JulianCalendar.daysInMonth(year: Y, month: M) : GregorianCalendar.daysInMonth(year: Y, month: M)
	}

	/// Returns the month and day of Easter in the specified year in the astromical calendar.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: The month and day of Easter in the specified year.
	public static func easter(year Y: Int) -> (month: Int, day: Int) {
		Y < GregorianCalendar.changeoverDate.year ? JulianCalendar.easter(year: Y) : GregorianCalendar.easter(year: Y)
	}
}

