//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// The Jewish calendar.
///
/// The Jewish calendar is a lunisolar calendar.
///
/// The Jewish calendar epoch in the Julian calendar is October 7, 3761 BC.
///
/// - seealso: [Hebrew calendar](https://en.wikipedia.org/wiki/Hebrew_calendar)
public struct JewishCalendar {
	/// The Julian day number of the epoch of the Jewish calendar.
	///
	/// This JDN corresponds to noon on October 7, 3761 BC in the Julian calendar.
	public static let epochJulianDayNumber: JulianDayNumber = 347998

	/// The Julian date of the epoch of the Jewish calendar.
	///
	/// This JD corresponds to midnight on October 7, 3761 BC in the Julian calendar.
	public static let epochJulianDate: JulianDate = 347997.5

	/// Returns `true` if the specified year, month, and day form a valid date in the Jewish calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number between `1` (Tishri) and `12` (Elul) for common years and `1` (Tishri) and `13` (Elul) for leap years.
	/// - parameter D: A day number between `1` and the maximum number of days in month `M` for year `Y`.
	///
	/// - returns: `true` if the specified year, month, and day form a valid date in the Jewish calendar.
	public static func isDateValid(year Y: Int, month M: Int, day D: Int) -> Bool {
		M > 0 && M <= monthsInYear(Y) && D > 0 && D <= daysInMonth(year: Y, month: M)
	}

	/// Returns `true` if the specified year is an embolismic (leap) year in the Jewish calendar.
	///
	/// There are seven embolismic years in a cycle of nineteen years.
	/// These are years 3, 6, 8, 11, 14, 17, and 19 of the cycle.
	/// The year 1 AM was the first of a cycle.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: `true` if the specified year is an embolismic (leap) year in the Jewish calendar.
	public static func isLeapYear(_ Y: Int) -> Bool {
		if Y > 0 {
			return (7 * Y + 1) % 19 < 7
		}
		let yearInCycle = (Y - 1) % 19 + (Y < 1 ? 20 : 1)
		return yearInCycle == 3 || yearInCycle == 6 || yearInCycle == 8 || yearInCycle == 11 || yearInCycle == 14 || yearInCycle == 17 || yearInCycle == 19
	}

#if false
	/// A category of year in the Jewish calendar.
	public enum YearCategory {
		/// A deficient common year consisting of 12 months and 353 days.
		case deficientCommon
		/// A regular common year consisting of 12 months and 354 days.
		case regularCommon
		/// An abundant common year consisting of 12 months and 355 days.
		case abundantCommon
		/// A deficient leap year consisting of 13 months and 383 days.
		case deficientLeap
		/// A regular leap year consisting of 13 months and 384 days.
		case regularLeap
		/// An abundant leap year consisting of 13 months and 385 days.
		case abundantLeap
	}

	/// Returns the category of the specified year.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: The category of the specified year.
	public static func categoryOfYear(_ Y: Int) -> YearCategory {
		var Y = Y
		var ΔcalendarCycles = 0

		if Y < 1 {
			ΔcalendarCycles = -Y / jewishCalendarCycleYears + 1
			Y += ΔcalendarCycles * jewishCalendarCycleYears
		}

		let a = firstDayOfTishri(year: Y)
		let b = firstDayOfTishri(year: Y + 1)
		let K = b - a - 352 - 27 * (((7 * Y + 13) % 19) / 12)

		switch K {
		case 1: 	return .deficientCommon
		case 2: 	return .regularCommon
		case 3: 	return .abundantCommon
		case 4: 	return .deficientLeap
		case 5: 	return .regularLeap
		case 6: 	return .abundantLeap
		default: 	fatalError("Invalid value \(K) for K")
		}
	}
#endif

	/// Returns the number of months in the specified year.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: The number of months in the specified year.
	public static func monthsInYear(_ Y: Int) -> Int {
		isLeapYear(Y) ? 13 : 12
	}

	/// The number of days in each month for a year with characterization K.
	///
	/// The array is indexed first by `K - 1` and the resultant array by `M - 1`.
	static let monthLengths = [
		// A deficient common year.
		[ 30, 29, 29, 29, 30, 29, 30, 29, 30, 29, 30, 29 ],
		// A regular common year.
		[ 30, 29, 30, 29, 30, 29, 30, 29, 30, 29, 30, 29 ],
		// An abundant common year.
		[ 30, 30, 30, 29, 30, 29, 30, 29, 30, 29, 30, 29 ],
		// A deficient leap year.
		[ 30, 29, 29, 29, 30, 30, 29, 30, 29, 30, 29, 30, 29 ],
		// A regular leap year.
		[ 30, 29, 30, 29, 30, 30, 29, 30, 29, 30, 29, 30, 29 ],
		// An abundant leap year.
		[ 30, 30, 30, 29, 30, 30, 29, 30, 29, 30, 29, 30, 29 ],
	]

	/// Returns the number of days in the specified month and year in the Jewish calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number between `1` (Tishri) and `12` (Elul) for common years and `1` (Tishri) and `13` (Elul) for leap years.
	///
	/// - returns: The number of days in the specified month and year.
	public static func daysInMonth(year Y: Int, month M: Int) -> Int {
		guard M > 0 else {
			return 0
		}

		var Y = Y
		var ΔcalendarCycles = 0

		if Y < 1 {
			ΔcalendarCycles = -Y / jewishCalendarCycleYears + 1
			Y += ΔcalendarCycles * jewishCalendarCycleYears
		}

		let a = firstDayOfTishri(year: Y)
		let b = firstDayOfTishri(year: Y + 1)
		let K = b - a - 352 - 27 * (((7 * Y + 13) % 19) / 12)

		if (K > 3 && M > 13) || (K < 4 && M > 12) {
			return 0
		}

		return monthLengths[K - 1][M - 1]
	}
}
