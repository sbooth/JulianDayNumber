//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// The modified French Republican calendar.
///
/// The French Republican calendar is an astronomical calendar. There were 12 months in the year, each having 30 days and a meteorological name.
/// These were followed by five epagomenal days (Sansculottides) with a sixth in leap years.
/// The year began on the day of the autumnal equinox as observed in Paris.
///
/// The French Republican calendar took effect on September 22, 1792 in the Gregorian calendar.
/// It was abolished by Napoleon in 1806.
///
/// The French Republican calendar epoch in the Gregorian calendar is September 22, 1792.
///
/// - seealso: [French Republican calendar](https://en.wikipedia.org/wiki/French_Republican_calendar)
public struct FrenchRepublicanCalendar {
	/// The Julian day number when the French Republican calendar took effect.
	///
	/// This JDN corresponds to noon on September 22, 1792 in the Gregorian calendar.
	public static let effectiveJulianDayNumber = epochJulianDayNumber

	/// The Julian date when the French Republican calendar took effect.
	///
	/// This JD corresponds to midnight on September 22, 1792 in the Gregorian calendar.
	public static let effectiveJulianDate = epochJulianDate

	/// The Julian day number of the epoch of the French Republican calendar.
	///
	/// This JDN corresponds to noon on September 22, 1792 in the Gregorian calendar.
	public static let epochJulianDayNumber: JulianDayNumber = 2375840

	/// The Julian date of the epoch of the French Republican calendar.
	///
	/// This JD corresponds to midnight on September 22, 1792 in the Gregorian calendar.
	public static let epochJulianDate: JulianDate = 2375839.5

	/// A year in the French Republican calendar.
	public typealias Year = Int

	/// A month in the French Republican calendar numbered from `1` (Vendémiaire) to `12` (Fructidor) with the epagomenal days (Sansculottides) treated as month `13`.
	public typealias Month = Int

	/// A day in the French Republican calendar numbered starting from `1`.
	public typealias Day = Int

	/// Returns `true` if the specified year, month, and day form a valid date in the French Republican calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	/// - parameter D: A day number.
	///
	/// - returns: `true` if the specified year, month, and day form a valid date in the French Republican calendar.
	public static func isDateValid(year Y: Year, month M: Month, day D: Day) -> Bool {
		M > 0 && M <= 13 && D > 0 && D <= daysInMonth(year: Y, month: M)
	}

	/// Returns `true` if the specified Julian day number occurred before the French Republican calendar took effect.
	///
	/// The French Republican calendar took effect on JDN 2375840.
	///
	/// - parameter julianDayNumber: A Julian day number.
	///
	/// - returns: `true` if the specified specified Julian day number occurred before the French Republican calendar took effect.
	public static func isProleptic(julianDayNumber: JulianDayNumber) -> Bool {
		julianDayNumber < effectiveJulianDayNumber
	}

	/// Returns `true` if the specified Julian date occurred before the French Republican calendar took effect.
	///
	/// The French Republican calendar took effect on JD 2375839.5.
	///
	/// - parameter julianDate: A Julian date.
	///
	/// - returns: `true` if the specified specified Julian date occurred before the French Republican calendar took effect.
	public static func isProleptic(julianDate: JulianDate) -> Bool {
		julianDate < effectiveJulianDate
	}

	/// Returns `true` if the specified year is a leap year in the French Republican calendar.
	///
	/// A French Republican year is a leap year if its numerical designation plus one would be a leap year in the Gregorian calendar.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: `true` if the specified year is a leap year in the French Republican calendar.
	public static func isLeapYear(_ Y: Year) -> Bool {
		GregorianCalendar.isLeapYear(Y + 1)
	}

	/// The number of months in one year.
	public static let monthsInYear = 13

	/// The number of days in each month indexed from `0` (Vendémiaire) to `11` (Fructidor), with the epagomenal days (Sansculottides) treated as month `12`.
	static let monthLengths = [ 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 5 ]

	/// Returns the number of days in the specified month and year in the French Republican calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	///
	/// - returns: The number of days in the specified month and year.
	public static func daysInMonth(year Y: Year, month M: Month) -> Int {
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

extension FrenchRepublicanCalendar {
	/// The names of the months in the French Republican calendar.
	///
	/// - attention: The array uses 1-based indexing. The first month has index `1`.
	public static let monthNames = [
		"",
		"Vendémiaire",
		"Brumaire",
		"Frimaire",
		"Nivôse",
		"Pluviôse",
		"Ventôse",
		"Germinal",
		"Floréal",
		"Prairial",
		"Messidor",
		"Thermido",
		"Fructidor",
		"Sansculottides",
	]
}
