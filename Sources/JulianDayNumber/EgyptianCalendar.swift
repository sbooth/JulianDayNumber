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
/// The Egyptian calendar epoch in the Julian calendar is February 26, 747 BC.
///
/// - seealso: [Egyptian calendar](https://en.wikipedia.org/wiki/Egyptian_calendar)
public struct EgyptianCalendar {
	/// The Julian day number of the epoch of the Egyptian calendar.
	///
	/// This JDN corresponds to noon on February 26, 747 BC in the Julian calendar.
	public static let epochJulianDayNumber: JulianDayNumber = 1448638

	/// The Julian date of the epoch of the Egyptian calendar.
	///
	/// This JD corresponds to midnight on February 26, 747 BC in the Julian calendar.
	public static let epochJulianDate: JulianDate = 1448637.5

	/// A year in the Egyptian calendar.
	public typealias Year = Int

	/// A month in the Egyptian calendar numbered from `1` (Thoth) to `12` (Mesore) with the five epagomenal days treated as month `13`.
	public typealias Month = Int

	/// A day in the Egyptian calendar numbered starting from `1`.
	public typealias Day = Int

	/// Returns `true` if the specified year, month, and day form a valid date in the Egyptian calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	/// - parameter D: A day number.
	///
	/// - returns: `true` if the specified year, month, and day form a valid date in the Egyptian calendar.
	public static func isDateValid(year Y: Year, month M: Month, day D: Day) -> Bool {
		M > 0 && M <= 13 && D > 0 && D <= daysInMonth(month: M)
	}

	/// The number of months in one year.
	public static let monthsInYear = 13

	/// The number of days in each month indexed from `0` (Thoth) to `11` (Mesore), with the 5 epagomenal days treated as month `12`.
	static let monthLengths = [ 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 5 ]

	/// Returns the number of days in the specified month in the Egyptian calendar.
	///
	/// - parameter M: A month number.
	///
	/// - returns: The number of days in the specified month.
	public static func daysInMonth(month M: Month) -> Int {
		guard M > 0, M <= 13 else {
			return 0
		}

		return monthLengths[M - 1]
	}
}

extension EgyptianCalendar {
	/// The names of the months in the Egyptian calendar.
	///
	/// - attention: The array uses 1-based indexing. The first month has index `1`.
	public static let monthNames = [
		"",
		"Thoth",
		"Phaophi",
		"Athyr",
		"Choiak",
		"Tybi",
		"Mechir",
		"Phamenoth",
		"Pharmuthi",
		"Pachons",
		"Payni",
		"Epiphi",
		"Mesore",
		"Five Days",
	]
}
