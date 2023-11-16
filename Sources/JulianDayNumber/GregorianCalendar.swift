//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// The Gregorian calendar is a solar calendar with 365 days in the year plus an additional leap day in certain years.
///
/// The year consists of twelve months. The second month contains an additional day in leap years.
///
/// | Month | Name | Days |
/// | ---: | --- | --- |
/// | 1 | January | 31 |
/// | 2 | February | 28 (29 in leap years) |
/// | 3 | March | 31 |
/// | 4 | April | 30 |
/// | 5 | May | 31 |
/// | 6 | June | 30 |
/// | 7 | July | 31 |
/// | 8 | August | 31 |
/// | 9 | September | 30 |
/// | 19 | October | 31 |
/// | 11 | November | 30 |
/// | 12 | December | 31 |
///
/// The months and length of months in the Gregorian calendar are the same as for the Julian calendar.
/// The only difference is that the Gregorian reform omitted a leap day in three centurial years every 400 years.
///
/// The Gregorian calendar took effect on October 15, 1582. Julian Thursday, October 4 was followed by Gregorian Friday, October 15.
///
/// The Gregorian calendar epoch in the Julian calendar is January 1, 1 CE.
///
/// - note: The actual adoption date of the Gregorian calendar varies by country.
///
/// - seealso: [Gregorian calendar](https://en.wikipedia.org/wiki/Gregorian_calendar)
public struct GregorianCalendar {
	/// The Julian day number when the Gregorian calendar took effect.
	///
	/// This JDN corresponds to noon on October 15, 1582 in the Gregorian calendar.
	public static let effectiveJulianDayNumber: JulianDayNumber = 2299161

	/// The Julian date when the Gregorian calendar took effect.
	///
	/// This JD corresponds to midnight on October 15, 1582 in the Gregorian calendar.
	public static let effectiveJulianDate: JulianDate = 2299160.5

	/// The Julian day number of the epoch of the Gregorian calendar.
	///
	/// This JDN corresponds to noon on January 1, 1 CE in the Julian calendar.
	public static let epochJulianDayNumber = JulianCalendar.epochJulianDayNumber

	/// The Julian date of the epoch of the Gregorian calendar.
	///
	/// This JD corresponds to midnight on January 1, 1 CE in the Julian calendar.
	public static let epochJulianDate = JulianCalendar.epochJulianDate

	/// A year in the Gregorian calendar.
	public typealias Year = JulianCalendar.Year

	/// A month in the Gregorian calendar numbered from `1` (January) to `12` (December).
	public typealias Month = JulianCalendar.Month

	/// A day in the Gregorian calendar numbered starting from `1`.
	public typealias Day = JulianCalendar.Day

	/// Returns `true` if the specified year, month, and day form a valid date in the Gregorian calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	/// - parameter D: A day number.
	///
	/// - returns: `true` if the specified year, month, and day form a valid date in the Gregorian calendar.
	public static func isDateValid(year Y: Year, month M: Month, day D: Day) -> Bool {
		M > 0 && M <= 12 && D > 0 && D <= daysInMonth(year: Y, month: M)
	}

	/// Returns `true` if the specified Julian day number occurred before the Gregorian calendar took effect.
	///
	/// The Gregorian calendar took effect on JDN 2299161.
	///
	/// - parameter julianDayNumber: A Julian day number.
	///
	/// - returns: `true` if the specified specified Julian day number occurred before the Gregorian calendar took effect.
	public static func isProleptic(julianDayNumber: JulianDayNumber) -> Bool {
		julianDayNumber < effectiveJulianDayNumber
	}

	/// Returns `true` if the specified Julian date occurred before the Gregorian calendar took effect.
	///
	/// The Gregorian calendar took effect on JD 2299160.5.
	///
	/// - parameter julianDate: A Julian date.
	///
	/// - returns: `true` if the specified specified Julian date occurred before the Gregorian calendar took effect.
	public static func isProleptic(julianDate: JulianDate) -> Bool {
		julianDate < effectiveJulianDate
	}

	/// Returns `true` if the specified year is a leap year in the Gregorian calendar.
	///
	/// A Gregorian year is a leap (bissextile) year if its numerical designation is divisible by 4
	/// excluding centurial years *not* divisible by 400.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: `true` if the specified year is a leap year in the Gregorian calendar.
	public static func isLeapYear(_ Y: Year) -> Bool {
		Y % 100 == 0 ? Y % 400 == 0 : Y % 4 == 0
	}

	/// The number of months in one year.
	public static let monthsInYear = JulianCalendar.monthsInYear

	/// Returns the number of days in the specified month and year in the Gregorian calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	///
	/// - returns: The number of days in the specified month and year.
	public static func daysInMonth(year Y: Year, month M: Month) -> Int {
		guard M > 0, M <= 12 else {
			return 0
		}

		if M == 2 {
			return isLeapYear(Y) ? 29 : 28
		} else {
			return JulianCalendar.monthLengths[M - 1]
		}
	}

	/// Returns the day of the week for the specified Julian day number.
	///
	/// - parameter J: A Julian day number.
	///
	/// - returns: The day of week from `1` (Sunday) to `7` (Saturday) corresponding to the specified Julian day number.
	public static func dayOfWeek(_ J: JulianDayNumber) -> Int {
		1 + (J + 1) % 7
	}

	/// Returns the day of the week for the specified year, month, and day.
	///
	/// - important: No validation checks are performed on the date values.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	/// - parameter D: A day number.
	///
	/// - returns: The day of week from `1` (Sunday) to `7` (Saturday) corresponding to the specified year, month, and day.
	public static func dayOfWeekFrom(year Y: Year, month M: Month, day D: Day) -> Int {
		let a = (9 + M) % 12
		let b = Y - a / 10
		return 1 + (2 + D + (13 * a + 2) / 5 + b + b / 4 - b / 100 + b / 400) % 7
	}

	/// Returns the day of the year for the specified year, month, and day.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	/// - parameter D: A day number.
	///
	/// - returns: The day of the year from `1` to `365` (`366` for leap years)  corresponding to the specified year, month, and day.
	public static func dayOfYear(year Y: Year, month M: Month, day D: Day) -> Int {
		guard M > 0, M <= 12 else {
			return 0
		}

		let dayCounts = [
			[0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334],
			[0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335],
		]

		let days = dayCounts[isLeapYear(Y) ? 1 : 0]
		return days[M - 1] + D
	}

	/// Returns the month and day of Easter in the specified year in the Gregorian calendar.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: The month and day of Easter in the specified year.
	public static func easter(year Y: Year) -> (month: Month, day: Day) {
		// Algorithm from the Explanatory Supplement to the Astronomical Almanac, 3rd edition, S.E Urban and P.K. Seidelmann eds., (Mill Valley, CA: University Science Books), Chapter 15, pp. 585-624.
		let a = Y / 100
		let b = a - a / 4
		let c = (Y % 19)
		let e = ((15 + 19 * c + b - (a - (a - 17) / 25) / 3) % 30)
		let f = e - (c + 11 * e) / 319
		let g = 22 + f + ((140004 - Y - Y / 4 + b - f) % 7)
		let M = 3 + g / 32
		let D = 1 + ((g - 1) % 31)
		return (M, D)
	}
}

extension GregorianCalendar: JulianDayNumberConverting {
	/// A date in the Gregorian calendar consists of a year, month, and day.
	public typealias DateType = JulianCalendar.DateType

	/// The converter for the Gregorian calendar.
	static let converter = JDNGregorianTypeConverter(y: 4716, j: 1401, m: 2, n: 12, r: 4, p: 1461, q: 0, v: 3, u: 5, s: 153, t: 2, w: 2, A: 184, B: 274277, C: -38)

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		converter.julianDayNumberFromDate(date)
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		converter.dateFromJulianDayNumber(J)
	}
}
