//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// The Ethiopian calendar.
///
/// The Ethiopian calendar is a solar calendar of 365 days in every year with an additional leap day every fourth year.
///
/// The Ethiopian calendar epoch in the Ethiopian calendar is 1 Mäskäräm 1.
/// The Ethiopian calendar epoch in the Julian calendar is August 29, 8 AD.
///
/// - seealso: [Ethiopian calendar](https://en.wikipedia.org/wiki/Ethiopian_calendar)
public struct EthiopianCalendar {
	/// The year, month, and day of the epoch of the Ethiopian calendar.
	///
	/// The Ethiopian calendar epoch in the Ethiopian calendar is 1 Mäskäräm 1.
	/// The Ethiopian calendar epoch in the Julian calendar is August 29, 8 AD.
	public static let epochDate = (year: 1, month: 1, day: 1)

	/// The Julian day number of the epoch of the Ethiopian calendar.
	///
	/// This JDN corresponds to noon on 1 Mäskäräm 1 in the Ethiopian calendar.
	public static let epochJulianDayNumber: JulianDayNumber = 1724221

	/// The Julian date of the epoch of the Ethiopian calendar.
	///
	/// This JD corresponds to midnight on 1 Mäskäräm 1 in the Ethiopian calendar.
	public static let epochJulianDate: JulianDate = 1724220.5

	/// Returns `true` if the specified year, month, and day form a valid date in the Ethiopian calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number between `1` (Mäskäräm) and `13` (Ṗagumen).
	/// - parameter D: A day number between `1` and the maximum number of days in month `M` for year `Y`.
	///
	/// - returns: `true` if the specified year, month, and day form a valid date in the Ethiopian calendar.
	public static func isDateValid(year Y: Int, month M: Int, day D: Int) -> Bool {
		M > 0 && M <= 13 && D > 0 && D <= daysInMonth(year: Y, month: M)
	}

	/// Returns `true` if the specified year is a leap year in the Ethiopian calendar.
	///
	/// An Ethiopian year is a leap year if its numerical designation is divisible by 4.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: `true` if the specified year is a leap year in the Ethiopian calendar.
	public static func isLeapYear(_ Y: Int) -> Bool {
		Y % 4 == 0
	}

	/// The number of days in each month indexed from `0` (Mäskäräm) to `12` (Ṗagumen).
	static let monthLengths = [ 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 5 ]

	/// Returns the number of days in the specified month and year in the Ethiopian calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number between `1` (Mäskäräm) and `13` (Ṗagumen).
	///
	/// - returns: The number of days in the specified month and year.
	public static func daysInMonth(year Y: Int, month M: Int) -> Int {
		guard M > 0, M <= 13 else {
			return 0
		}

		if M == 13 {
			return isLeapYear(Y) ? 6 : 5
		} else {
			return monthLengths[M - 1]
		}
	}
}
