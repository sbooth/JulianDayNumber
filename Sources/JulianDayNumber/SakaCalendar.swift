//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// The Śaka calendar.
///
/// The Śaka calendar is a solar calendar of 365 days in every year with an additional leap day in certain years.
///
/// The Śaka calendar epoch in the Julian calendar is March 24, 79.
///
/// - seealso: [Śaka calendar](https://en.wikipedia.org/wiki/Indian_national_calendar)
public struct SakaCalendar {
	/// The Julian day number when the Śaka calendar took effect.
	///
	/// This JDN corresponds to noon on March 24, 79 in the Julian calendar.
	public static let effectiveJulianDayNumber = epochJulianDayNumber

	/// The Julian date when the Śaka calendar took effect.
	///
	/// This JD corresponds to midnight on March 24, 79 in the Julian calendar.
	public static let effectiveJulianDate = epochJulianDate

	/// The Julian day number of the epoch of the Śaka calendar.
	///
	/// This JDN corresponds to noon on March 24, 79 in the Julian calendar.
	public static let epochJulianDayNumber = 1749995

	/// The Julian date of the epoch of the Śaka calendar.
	///
	/// This JD corresponds to midnight on March 24, 79 in the Julian calendar.
	public static let epochJulianDate = 1749994.5

	/// Returns `true` if the specified year, month, and day form a valid date in the Śaka calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number between `1` (Chaitra) and `12` (Phālguna).
	/// - parameter D: A day number between `1` and the maximum number of days in month `M` for year `Y`.
	///
	/// - returns: `true` if the specified year, month, and day form a valid date in the Śaka calendar.
	public static func isDateValid(year Y: Int, month M: Int, day D: Int) -> Bool {
		M > 0 && M <= 12 && D > 0 && D <= daysInMonth(year: Y, month: M)
	}

	/// Returns `true` if the specified Julian day number occurred before the Śaka calendar took effect.
	///
	/// The Śaka calendar took effect on JDN 2394647.
	///
	/// - parameter julianDayNumber: A Julian day number.
	///
	/// - returns: `true` if the specified specified Julian day number occurred before the Śaka calendar took effect.
	public static func isProleptic(julianDayNumber: JulianDayNumber) -> Bool {
		julianDayNumber < effectiveJulianDayNumber
	}

	/// Returns `true` if the specified Julian date occurred before the Śaka calendar took effect.
	///
	/// The Śaka calendar took effect on JD 2394646.5.
	///
	/// - parameter julianDate: A Julian date.
	///
	/// - returns: `true` if the specified specified Julian date occurred before the Śaka calendar took effect.
	public static func isProleptic(julianDate: JulianDate) -> Bool {
		julianDate < effectiveJulianDate
	}

	/// Returns `true` if the specified year is a leap year in the Śaka calendar.
	///
	/// A Śaka year is a leap year if its numerical designation plus 78 would be a leap year in the Gregorian calendar.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: `true` if the specified year is a leap year in the Śaka calendar.
	public static func isLeapYear(_ Y: Int) -> Bool {
		GregorianCalendar.isLeapYear(Y + 78)
	}

	/// The number of months in one year.
	public static let monthsInYear = 12

	/// The number of days in each month indexed from `0` (Chaitra) to `11` (Phālguna).
	static let monthLengths = [ 30, 31, 31, 31, 31, 31, 30, 30, 30, 30, 30, 30 ]

	/// Returns the number of days in the specified month and year in the Śaka calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number between `1` (Chaitra) and `12` (Phālguna).
	///
	/// - returns: The number of days in the specified month and year.
	public static func daysInMonth(year Y: Int, month M: Int) -> Int {
		guard M > 0, M <= 12 else {
			return 0
		}

		if M == 1 {
			return isLeapYear(Y) ? 31 : 30
		} else {
			return monthLengths[M - 1]
		}
	}
}
