//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// The Islamic calendar.
///
/// The Islamic calendar is a lunar calendar consisting of 12 lunar months in a year of 354 or 355 days.
///
/// The Islamic calendar took effect on 1 Muharram 1, AH.
///
/// The Islamic calendar epoch in the Islamic calendar is 1 Muharram 1, AH.
/// The Islamic calendar epoch in the Julian calendar is July 16, 622 AD.
///
/// - seealso: [Islamic calendar](https://en.wikipedia.org/wiki/Islamic_calendar)
public struct IslamicCalendar {
	/// The year, month, and day when the Islamic calendar took effect.
	///
	/// The Islamic calendar took effect on 1 Muharram 1, AH.
	public static let effectiveDate = (year: 1, month: 1, day: 1)

	/// The Julian day number when the Islamic calendar took effect.
	///
	/// This JDN corresponds to noon on 1 Muharram 1, AH in the Islamic calendar.
	public static let effectiveJulianDayNumber: JulianDayNumber = 1948440

	/// The Julian date when the Islamic calendar took effect.
	///
	/// This JD corresponds to midnight on 1 Muharram 1, AH in the Islamic calendar.
	public static let effectiveJulianDate: JulianDate = 1948439.5

	/// The year, month, and day of the epoch of the Islamic calendar.
	///
	/// The Islamic calendar epoch in the Islamic calendar is 1 Muharram 1, AH.
	/// The Islamic calendar epoch in the Julian calendar is July 16, 622 AD.
	public static let epochDate = (year: 1, month: 1, day: 1)

	/// The Julian day number of the epoch of the Islamic calendar.
	///
	/// This JDN corresponds to noon on 1 Muharram 1, AH in the Islamic calendar.
	public static let epochJulianDayNumber: JulianDayNumber = 1948440

	/// The Julian date of the epoch of the Islamic calendar.
	///
	/// This JD corresponds to midnight on 1 Muharram 1, AH in the Islamic calendar.
	public static let epochJulianDate: JulianDate = 1948439.5

	/// Returns `true` if the specified year, month, and day form a valid date in the Islamic calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number between `1` (Muharram) and `12` (Dhú’l-Hijjab).
	/// - parameter D: A day number between `1` and the maximum number of days in month `M` for year `Y`.
	///
	/// - returns: `true` if the specified year, month, and day form a valid date in the Islamic calendar.
	public static func isDateValid(year Y: Int, month M: Int, day D: Int) -> Bool {
		M > 0 && M <= 12 && D > 0 && D <= daysInMonth(year: Y, month: M)
	}

	/// Returns `true` if the specified year, month, and day occurred before the Islamic calendar took effect.
	///
	/// The Islamic calendar took effect on 1 Muharram 1, AH.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number between `1` (Muharram) and `12` (Dhú’l-Hijjab).
	/// - parameter D: A day number between `1` and the maximum number of days in month `M` for year `Y`.
	///
	/// - returns: `true` if the specified year, month, and day occurred before the Islamic calendar took effect.
	public static func isProleptic(year Y: Int, month M: Int, day D: Int) -> Bool {
		(Y, M, D) < effectiveDate
	}

	/// Returns `true` if the specified Julian day number occurred before the Islamic calendar took effect.
	///
	/// The Islamic calendar took effect on JDN 1948440.
	///
	/// - parameter julianDayNumber: A Julian day number.
	///
	/// - returns: `true` if the specified specified Julian day number occurred before the Islamic calendar took effect.
	public static func isProleptic(julianDayNumber: JulianDayNumber) -> Bool {
		julianDayNumber < effectiveJulianDayNumber
	}

	/// Returns `true` if the specified Julian date occurred before the Islamic calendar took effect.
	///
	/// The Islamic calendar took effect on JD 1948439.5.
	///
	/// - parameter julianDate: A Julian date.
	///
	/// - returns: `true` if the specified specified Julian date occurred before the Islamic calendar took effect.
	public static func isProleptic(julianDate: JulianDate) -> Bool {
		julianDate < effectiveJulianDate
	}

	/// Returns `true` if the specified year is a leap year in the Islamic calendar.
	///
	/// There are eleven leap years in a cycle of thirty years.
	/// These are years 2, 5, 7, 10, 13, 16, 18, 21, 24, 26, and 29 of the cycle.
	/// The year 1 AH was the first of a cycle.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: `true` if `Y` is a leap year in the Islamic calendar.
	public static func isLeapYear(_ Y: Int) -> Bool {
		let yearInCycle = (Y - 1) % 30 + (Y < 1 ? 31 : 1)
		return yearInCycle == 2 || yearInCycle == 5 || yearInCycle == 7 || yearInCycle == 10 || yearInCycle == 13 || yearInCycle == 16 || yearInCycle == 18 || yearInCycle == 21 || yearInCycle == 24 || yearInCycle == 26 || yearInCycle == 29
	}

	/// The number of months in one year.
	public static let monthsInYear = 12

	/// The number of days in each month indexed from `0` (Muharram) to `11` (Dhú’l-Hijjab).
	static let monthLengths = [ 30, 29, 30, 29, 30, 29, 30, 29, 30, 29, 30, 29 ]

	/// Returns the number of days in the specified month and year in the Islamic calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number between `1` (Muharram) and `12` (Dhú’l-Hijjab).
	///
	/// - returns: The number of days in the specified month and year.
	public static func daysInMonth(year Y: Int, month M: Int) -> Int {
		guard M > 0, M <= 12 else {
			return 0
		}

		if M == 12 {
			return isLeapYear(Y) ? 30 : 29
		} else {
			return monthLengths[M - 1]
		}
	}
}
