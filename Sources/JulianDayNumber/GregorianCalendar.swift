//
// SPDX-FileCopyrightText: 2021 Stephen F. Booth <contact@sbooth.dev>
// SPDX-License-Identifier: MIT
//
// Part of https://github.com/sbooth/JulianDayNumber
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

	/// The recurrence (solar) cycle of the Gregorian calendar is 303 common years of 365 days and 97 leap years of 366 days.
	static let recurrenceCycle = (years: 400, days: 146097)

	/// The Gregorian calendar date corresponding to JDN 0.
	static let jdnZero: DateType = (-4713, 11, 24)

	// These algorithms are valid for all Gregorian calendar dates
	// corresponding to JDN ≥ 0.
	//
	// For more information see:
	//   Fliegel, H.F. & van Flandern, T.C. 1968, Communications of the ACM, 11, 657.
	//   https://doi.org/10.1145/364096.364097

	public static func julianDayNumberFromDate(_ date: DateType) throws -> JulianDayNumber {
		// Years greater than maxY cause arithmetic overflow
		// when computing J even when the final result is ≤ .max
		// N.B. this is an estimated upper bound
		let maxY = .max / 1461 - 4800

		var Y = date.year
		var cycles = 0
		var adjustment = TemporalTranslation.none

		// Translate out-of-range dates into the valid range using
		// multiples of the Gregorian calendar's 400 year recurrence cycle
		if Y > maxY {
			adjustment = .negative
			cycles = (Y - maxY) / recurrenceCycle.years
			Y -= cycles * recurrenceCycle.years + recurrenceCycle.years
		} else if date < jdnZero {
			adjustment = .positive
			cycles = (Y - jdnZero.year) / -recurrenceCycle.years
			Y += cycles * recurrenceCycle.years + recurrenceCycle.years
		}

//		precondition((Y, date.month, date.day) >= minDate)
		var J = (1461 * (Y + 4800 + (date.month - 14) / 12)) / 4
				+ (367 * (date.month - 2 - 12 * ((date.month - 14) / 12))) / 12
				- (3 * ((Y + 4900 + (date.month - 14) / 12) / 100)) / 4
				+ date.day
				- 32075

		if adjustment == .negative {
			J += cycles * recurrenceCycle.days
			J += recurrenceCycle.days
		} else if adjustment == .positive {
			J -= cycles * recurrenceCycle.days
			J -= recurrenceCycle.days
		}

		return J
	}

	public static func dateFromJulianDayNumber(_ JD: JulianDayNumber) throws -> DateType {
		// JDN values greater than maxJD cause arithmetic overflow
		// when computing L
		let maxJD = .max - 68569

		var JD = JD
		var cycles = 0

		// Translate out-of-range JDNs into the valid range using
		// multiples of the Gregorian calendar's 146097 day recurrence cycle
		if JD > maxJD || JD < 0 {
			let qr = JD.quotientAndRemainder(dividingBy: -recurrenceCycle.days)
			cycles = qr.quotient + 1
			JD = recurrenceCycle.days + qr.remainder
		}

//		precondition(JD >= minJD)
		var L = JD + 68569
		let N = (4 * L) / 146097
		L = L - (146097 * N + 3) / 4
		let I = (4000 * (L + 1)) / 1461001
		L = L - (1461 * I) / 4 + 31
		let J = (80 * L) / 2447
		let D = L - (2447 * J) / 80
		L = J / 11
		let M = J + 2 - 12 * L
		var Y = 100 * (N - 49) + I + L

		if cycles != 0 {
			Y -= cycles * recurrenceCycle.years
		}

		return (Y, M, D)
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
	/// A day of the week number from `1` (Sunday) to `7` (Saturday).
	public typealias DayOfWeek = JulianCalendar.DayOfWeek

	/// Returns the day of the week for the specified Julian day number in the Gregorian calendar.
	///
	/// - parameter J: A Julian day number.
	///
	/// - returns: The day of the week for the specified Julian day number.
	public static func dayOfWeek(_ J: JulianDayNumber) -> DayOfWeek {
		JulianCalendar.dayOfWeek(J)
	}

	/// Returns the day of the week for the specified year, month, and day in the Gregorian calendar.
	///
	/// - important: No validation checks are performed on the date values.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	/// - parameter D: A day number.
	///
	/// - returns: The day of the week for the specified year, month, and day.
	public static func dayOfWeekFrom(year Y: Year, month M: Month, day D: Day) -> DayOfWeek {
		var Y = Y

		// Richards' algorithm is only valid for positive years.
		if Y < 1 {
			Y += (-Y / recurrenceCycle.years + 1) * recurrenceCycle.years
		}

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
