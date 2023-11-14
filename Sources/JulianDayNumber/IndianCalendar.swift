//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// The Indian calendar is a solar calendar with 365 days in the year plus an additional leap day in certain years.
///
/// The year consists of twelve months.  The first month contains an additional day in leap years.
///
/// | Month | Name | Days |
/// | ---: | --- | --- |
/// | 1 | Chaitra | 30 (31 in leap years) |
/// | 2 | Vaiśākha | 31 |
/// | 3 | Jyēṣṭha | 31 |
/// | 4 | Āshādha | 31 |
/// | 5 | Śrāvana | 31 |
/// | 6 | Bhādra | 31 |
/// | 7 | Āśvin | 30 |
/// | 8 | Kārtika | 31 |
/// | 9 | Mārgaśīrṣa | 30 |
/// | 10 | Pauṣa | 30 |
/// | 11 | Māgha | 30 |
/// | 1 2| Phālguna | 30 |
///
/// The Indian calendar took effect on March 22, 1957 in the Gregorian calendar.
///
/// The Indian calendar epoch in the Julian calendar is March 24, 79 CE.
///
/// - seealso: [Indian national calendar](https://en.wikipedia.org/wiki/Indian_national_calendar)
public struct IndianCalendar {
	/// The Julian day number when the Indian calendar took effect.
	///
	/// This JDN corresponds to noon on March 22, 1957 in the Gregorian calendar.
	public static let effectiveJulianDayNumber: JulianDayNumber = 2435920

	/// The Julian date when the Indian calendar took effect.
	///
	/// This JD corresponds to midnight on March 22, 1957 in the Gregorian calendar.
	public static let effectiveJulianDate: JulianDate = 2435919.5

	/// The Julian day number of the epoch of the Indian calendar.
	///
	/// This JDN corresponds to noon on March 24, 79 CE in the Julian calendar.
	public static let epochJulianDayNumber: JulianDayNumber = 1749995

	/// The Julian date of the epoch of the Indian calendar.
	///
	/// This JD corresponds to midnight on March 24, 79 CE in the Julian calendar.
	public static let epochJulianDate: JulianDate = 1749994.5

	/// A year in the Indian calendar.
	public typealias Year = Int

	/// A month in the Indian calendar numbered from `1` (Chaitra) to `12` (Phālguna).
	public typealias Month = Int

	/// A day in the Indian calendar numbered starting from `1`.
	public typealias Day = Int

	/// Returns `true` if the specified year, month, and day form a valid date in the Indian calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	/// - parameter D: A day number.
	///
	/// - returns: `true` if the specified year, month, and day form a valid date in the Indian calendar.
	public static func isDateValid(year Y: Year, month M: Month, day D: Day) -> Bool {
		M > 0 && M <= 12 && D > 0 && D <= daysInMonth(year: Y, month: M)
	}

	/// Returns `true` if the specified Julian day number occurred before the Indian calendar took effect.
	///
	/// The Indian calendar took effect on JDN 2435920.
	///
	/// - parameter julianDayNumber: A Julian day number.
	///
	/// - returns: `true` if the specified specified Julian day number occurred before the Indian calendar took effect.
	public static func isProleptic(julianDayNumber: JulianDayNumber) -> Bool {
		julianDayNumber < effectiveJulianDayNumber
	}

	/// Returns `true` if the specified Julian date occurred before the Indian calendar took effect.
	///
	/// The Indian calendar took effect on JD 2435919.5.
	///
	/// - parameter julianDate: A Julian date.
	///
	/// - returns: `true` if the specified specified Julian date occurred before the Indian calendar took effect.
	public static func isProleptic(julianDate: JulianDate) -> Bool {
		julianDate < effectiveJulianDate
	}

	/// Returns `true` if the specified year is a leap year in the Indian calendar.
	///
	/// A Indian year is a leap year if its numerical designation plus 78 would be a leap year in the Gregorian calendar.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: `true` if the specified year is a leap year in the Indian calendar.
	public static func isLeapYear(_ Y: Year) -> Bool {
		GregorianCalendar.isLeapYear(Y + 78)
	}

	/// The number of months in one year.
	public static let monthsInYear = 12

	/// The number of days in each month indexed from `0` (Chaitra) to `11` (Phālguna).
	static let monthLengths = [ 30, 31, 31, 31, 31, 31, 30, 30, 30, 30, 30, 30 ]

	/// Returns the number of days in the specified month and year in the Indian calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	///
	/// - returns: The number of days in the specified month and year.
	public static func daysInMonth(year Y: Year, month M: Month) -> Int {
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
