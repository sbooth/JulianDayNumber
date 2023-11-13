//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// The Baháʼí calendar.
///
/// The Baháʼí calendar is a solar calendar of 365 days in every year with an additional leap day in certain years.
/// The year consists of 19 months having 19 days each.  The 18th month is followed by four epagomenal days (Ayyám-i-Há) with a fifth in leap years.
///
/// The Baháʼí calendar epoch in the Gregorian calendar is March 21, 1844.
///
/// - seealso: [Baháʼí calendar](https://en.wikipedia.org/wiki/Baháʼí_calendar)
public struct BahaiCalendar {
	/// The Julian day number when the Baháʼí calendar took effect.
	///
	/// This JDN corresponds to noon on March 21, 1844 in the Gregorian calendar.
	public static let effectiveJulianDayNumber = epochJulianDayNumber

	/// The Julian date when the Baháʼí calendar took effect.
	///
	/// This JD corresponds to midnight on March 21, 1844 in the Gregorian calendar.
	public static let effectiveJulianDate = epochJulianDate

	/// The Julian day number of the epoch of the Baháʼí calendar.
	///
	/// This JDN corresponds to noon on March 21, 1844 in the Gregorian calendar.
	public static let epochJulianDayNumber: JulianDayNumber = 2394647

	/// The Julian date of the epoch of the Baháʼí calendar.
	///
	/// This JD corresponds to midnight on March 21, 1844 in the Gregorian calendar.
	public static let epochJulianDate: JulianDate = 2394646.5

	/// A year in the Baháʼí calendar.
	public typealias Year = Int

	/// A month in the Baháʼí calendar numbered from `1` (Bahá) to `20` (ʻAláʼ) with the epagomenal days (Ayyám-i-Há) treated as month `19`.
	public typealias Month = Int

	/// A day in the Baháʼí calendar numbered starting from `1`.
	public typealias Day = Int

	/// Returns `true` if the specified year, month, and day form a valid date in the Baháʼí calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	/// - parameter D: A day number.
	///
	/// - returns: `true` if the specified year, month, and day form a valid date in the Baháʼí calendar.
	public static func isDateValid(year Y: Year, month M: Month, day D: Day) -> Bool {
		M > 0 && M <= 20 && D > 0 && D <= daysInMonth(year: Y, month: M)
	}

	/// Returns `true` if the specified Julian day number occurred before the Baháʼí calendar took effect.
	///
	/// The Baháʼí calendar took effect on JDN 2394647.
	///
	/// - parameter julianDayNumber: A Julian day number.
	///
	/// - returns: `true` if the specified specified Julian day number occurred before the Baháʼí calendar took effect.
	public static func isProleptic(julianDayNumber: JulianDayNumber) -> Bool {
		julianDayNumber < effectiveJulianDayNumber
	}

	/// Returns `true` if the specified Julian date occurred before the Baháʼí calendar took effect.
	///
	/// The Baháʼí calendar took effect on JD 2394646.5.
	///
	/// - parameter julianDate: A Julian date.
	///
	/// - returns: `true` if the specified specified Julian date occurred before the Baháʼí calendar took effect.
	public static func isProleptic(julianDate: JulianDate) -> Bool {
		julianDate < effectiveJulianDate
	}

	/// Returns `true` if the specified year is a leap year in the Baháʼí calendar.
	///
	/// A Baháʼí year is a leap year if its numerical designation plus 1844 would be a leap year in the Gregorian calendar.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: `true` if the specified year is a leap year in the Baháʼí calendar.
	public static func isLeapYear(_ Y: Year) -> Bool {
		GregorianCalendar.isLeapYear(Y + 1844)
	}

	/// The number of months in one year.
	public static let monthsInYear = 20

	/// The number of days in each month indexed from `0` (Bahá) to `19` (ʻAláʼ), with the epagomenal days (Ayyám-i-Há) treated as month `18`.
	static let monthLengths = [ 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 4, 19 ]

	/// Returns the number of days in the specified month and year in the Baháʼí calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	///
	/// - returns: The number of days in the specified month and year.
	public static func daysInMonth(year Y: Year, month M: Month) -> Int {
		guard M > 0, M <= 20 else {
			return 0
		}

		if M == 19 {
			return isLeapYear(Y) ? 5 : 4
		} else {
			return monthLengths[M - 1]
		}
	}
}
