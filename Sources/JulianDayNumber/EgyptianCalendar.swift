//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// The Egyptian calendar.
///
/// The Egyptian calendar is a solar calendar of 365 days in every year.
///
/// - seealso: [Egyptian calendar](https://en.wikipedia.org/wiki/Egyptian_calendar)
public struct EgyptianCalendar {
	/// Returns `true` if the specified year, month, and day form a valid date in the Egyptian calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number between `1` (Thoth) and `12` (Mesori). The five epagomenal days are treated as month `13`.
	/// - parameter D: A day number between `1` and the maximum number of days in month `M` for year `Y`.
	///
	/// - returns: `true` if the specified year, month, and day form a valid date in the Egyptian calendar.
	public static func isDateValid(year Y: Int, month M: Int, day D: Int) -> Bool {
		M > 0 && M <= 13 && D > 0 && D <= daysInMonth(month: M)
	}

	/// The number of days in each month indexed from `0` (Thoth) to `11` (Mesori), with the 5 epagomenal days treated as month `12`.
	static let monthLengths = [ 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 5 ]

	/// Returns the number of days in the specified month and year in the Egyptian calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number between `1` (Thoth) and `12` (Mesori). The five epagomenal days are treated as month `13`.
	///
	/// - returns: The number of days in the specified month and year.
	public static func daysInMonth(month M: Int) -> Int {
		guard M > 0, M <= 13 else {
			return 0
		}

		return monthLengths[M - 1]
	}
}
