//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

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
/// The Gregorian calendar epoch in the Julian calendar is January 3, 1 CE.
///
/// - note: The actual adoption date of the Gregorian calendar varies by country.
///
/// - seealso: [Gregorian calendar](https://en.wikipedia.org/wiki/Gregorian_calendar)
public struct GregorianCalendar: Calendar {
	/// The Julian day number of the epoch of the Gregorian calendar.
	///
	/// This JDN corresponds to January 3, 1 CE in the Julian calendar.
	public static let epoch: JulianDayNumber = 1721426

	/// The converter for the Gregorian calendar.
	static let converter = JDNGregorianConverter(y: 4716, j: 1401, m: 2, n: 12, r: 4, p: 1461, q: 0, v: 3, u: 5, s: 153, t: 2, w: 2, A: 184, B: 274277, C: -38)

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		converter.julianDayNumberFromDate(date)
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		converter.dateFromJulianDayNumber(J)
	}

	/// The Julian day number when the Gregorian calendar took effect.
	///
	/// This JDN corresponds to October 15, 1582 in the Gregorian calendar.
	public static let effectiveJulianDayNumber: JulianDayNumber = 2299161

	/// The number of months in one year.
	public static let numberOfMonthsInYear = JulianCalendar.numberOfMonthsInYear

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

	public static func numberOfMonths(inYear Y: Year) -> Int {
		numberOfMonthsInYear
	}

	public static func numberOfDays(inYear Y: Year) -> Int {
		isLeapYear(Y) ? 366 : 365
	}

	public static func numberOfDaysIn(month M: Month, year Y: Year) -> Int {
		guard M > 0, M <= numberOfMonthsInYear else {
			return 0
		}

		if M == 2 {
			return isLeapYear(Y) ? 29 : 28
		} else {
			return JulianCalendar.monthLengths[M - 1]
		}
	}
}

extension GregorianCalendar {
	/// Returns the day of the week for the specified Julian day number.
	///
	/// - parameter J: A Julian day number.
	///
	/// - returns: The day of week from `1` (Sunday) to `7` (Saturday) corresponding to the specified Julian day number.
	public static func dayOfWeek(_ J: JulianDayNumber) -> Int {
		JulianCalendar.dayOfWeek(J)
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
