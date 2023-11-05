//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// The Coptic calendar.
///
/// The Coptic calendar is a solar calendar of 365 days in every year.
///
/// The Coptic calendar epoch in the Coptic calendar is 1 Tut 1.
/// The Coptic calendar epoch in the Julian calendar is August 29, 284 AD.
///
/// - seealso: [Coptic calendar](https://en.wikipedia.org/wiki/Coptic_calendar)
public struct CopticCalendar {
	/// The year, month, and day of the epoch of the Coptic calendar.
	///
	/// The Coptic calendar epoch in the Coptic calendar is 1 Tut 1.
	/// The Coptic calendar epoch in the Julian calendar is August 29, 284 AD.
	public static let epochDate = (year: 1, month: 1, day: 1)

	/// The Julian day number of the epoch of the Coptic calendar.
	///
	/// This JDN corresponds to noon on 1 Tut 1 in the Coptic calendar.
	public static let epochJulianDayNumber: JulianDayNumber = 1825030

	/// The Julian date of the epoch of the Coptic calendar.
	///
	/// This JD corresponds to midnight on 1 Tut 1 in the Coptic calendar.
	public static let epochJulianDate: JulianDate = 1825029.5

	/// Returns `true` if the specified year, month, and day form a valid date in the Coptic calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number between `1` (Tut) and `13` (Nissieh).
	/// - parameter D: A day number between `1` and the maximum number of days in month `M` for year `Y`.
	///
	/// - returns: `true` if the specified year, month, and day form a valid date in the Coptic calendar.
	public static func isDateValid(year Y: Int, month M: Int, day D: Int) -> Bool {
		M > 0 && M <= 13 && D > 0 && D <= daysInMonth(year: Y, month: M)
	}

	/// Returns `true` if the specified year is a leap year in the Coptic calendar.
	///
	/// A Coptic year is a leap year if its numerical designation plus one is divisible by 4.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: `true` if the specified year is a leap year in the Coptic calendar.
	public static func isLeapYear(_ Y: Int) -> Bool {
		(Y + 1) % 4 == 0
	}

	/// The number of months in one year.
	public static let monthsInYear = 13

	/// The number of days in each month indexed from `0` (Tut) to `12` (Nissieh).
	static let monthLengths = [ 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 5 ]

	/// Returns the number of days in the specified month and year in the Coptic calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number between `1` (Tut) and `13` (Nissieh).
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
