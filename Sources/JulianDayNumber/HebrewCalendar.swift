//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// The Hebrew calendar is a lunisolar calendar with either 353, 354, 355, 383, 384, or 385 days in the year.
///
/// A common year has 353, 354, or 355 days. A leap year is always 30 days longer.
///
/// The number of days in a year depends on whether year is a common or leap year and whether it is deficient, regular, or abundant.
///
/// | | Common Year | Leap Year |
/// | --- | --- | --- |
/// | Deficient | 353 | 383 |
/// | Regular | 354 | 384 |
/// | Abundant | 355 | 385 |
///
/// Common years consist of twelve months.
///
/// | Month | Name | Days |
/// | ---: | --- | --- |
/// | 1 | Tishrei | 30 |
/// | 2 | Cheshvan | 29 (30 in abundant years) |
/// | 3 | Kislev | 30 (29 in deficient years) |
/// | 4 | Tevet | 29 |
/// | 5 | Shevat | 30 |
/// | 6 | Adar | 29 |
/// | 7 | Nisan | 30 |
/// | 8 | Iyar | 29 |
/// | 9 | Sivan | 30 |
/// | 10 | Tammuz | 29 |
/// | 11 | Av | 30 |
/// | 12 | Elul | 29 |
///
/// Leap years consist of thirteen months.
///
/// | Month | Name | Days |
/// | ---: | --- | --- |
/// | 1 | Tishrei | 30 |
/// | 2 | Cheshvan | 29 (30 in abundant years) |
/// | 3 | Kislev | 30 (29 in deficient years) |
/// | 4 | Tevet | 29 |
/// | 5 | Shevat | 30 |
/// | 6 | Adar | 30 |
/// | 7 | Adar II | 29 |
/// | 8 | Nisan | 30 |
/// | 9 | Iyar | 29 |
/// | 10 | Sivan | 30 |
/// | 11 | Tammuz | 29 |
/// | 12 | Av | 30 |
/// | 13 | Elul | 29 |
///
/// The Hebrew calendar epoch in the Julian calendar is October 7, 3761 BC.
///
/// - seealso: [Hebrew calendar](https://en.wikipedia.org/wiki/Hebrew_calendar)
public struct HebrewCalendar {
	/// The Julian day number of the epoch of the Hebrew calendar.
	///
	/// This JDN corresponds to noon on October 7, 3761 BC in the Julian calendar.
	public static let epochJulianDayNumber: JulianDayNumber = 347998

	/// The Julian date of the epoch of the Hebrew calendar.
	///
	/// This JD corresponds to midnight on October 7, 3761 BC in the Julian calendar.
	public static let epochJulianDate: JulianDate = 347997.5

	/// A year in the Hebrew calendar.
	public typealias Year = Int

	/// A month in the Hebrew calendar numbered from `1` (Tishrei) to `12` (Elul) for common years and from `1` (Tishrei) to `13` (Elul) for leap years.
	public typealias Month = Int

	/// A day in the Hebrew calendar numbered starting from `1`.
	public typealias Day = Int

	/// Returns `true` if the specified year, month, and day form a valid date in the Hebrew calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	/// - parameter D: A day number.
	///
	/// - returns: `true` if the specified year, month, and day form a valid date in the Hebrew calendar.
	public static func isDateValid(year Y: Year, month M: Month, day D: Day) -> Bool {
		M > 0 && M <= monthsInYear(Y) && D > 0 && D <= daysInMonth(year: Y, month: M)
	}

	/// Returns `true` if the specified year is an embolismic (leap) year in the Hebrew calendar.
	///
	/// There are seven embolismic years in a cycle of nineteen years.
	/// These are years 3, 6, 8, 11, 14, 17, and 19 of the cycle.
	/// The year 1 AM was the first of a cycle.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: `true` if the specified year is an embolismic (leap) year in the Hebrew calendar.
	public static func isLeapYear(_ Y: Year) -> Bool {
		if Y > 0 {
			return (7 * Y + 1) % 19 < 7
		}
		let yearInCycle = (Y - 1) % 19 + (Y < 1 ? 20 : 1)
		return yearInCycle == 3 || yearInCycle == 6 || yearInCycle == 8 || yearInCycle == 11 || yearInCycle == 14 || yearInCycle == 17 || yearInCycle == 19
	}

#if false
	/// A category of year in the Hebrew calendar.
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
		var Y = date.year
		var ΔcalendarCycles = 0

		if Y < 1 {
			ΔcalendarCycles = (1 - Y) / hebrewCalendarCycleYears + 1
			Y += ΔcalendarCycles * hebrewCalendarCycleYears
		}

		let a = firstDayOfTishrei(year: Y)
		let b = firstDayOfTishrei(year: Y + 1)
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
	public static func monthsInYear(_ Y: Year) -> Int {
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

	/// Returns the number of days in the specified month and year in the Hebrew calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	///
	/// - returns: The number of days in the specified month and year.
	public static func daysInMonth(year Y: Year, month M: Month) -> Int {
		guard M > 0 else {
			return 0
		}

		var Y = Y
		var ΔcalendarCycles = 0

		if Y < 1 {
			ΔcalendarCycles = (1 - Y) / hebrewCalendarCycleYears + 1
			Y += ΔcalendarCycles * hebrewCalendarCycleYears
		}

		let a = firstDayOfTishrei(year: Y)
		let b = firstDayOfTishrei(year: Y + 1)
		let K = b - a - 352 - 27 * (((7 * Y + 13) % 19) / 12)

		if (K > 3 && M > 13) || (K < 4 && M > 12) {
			return 0
		}

		return monthLengths[K - 1][M - 1]
	}
}
