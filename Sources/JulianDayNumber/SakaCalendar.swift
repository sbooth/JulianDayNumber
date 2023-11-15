//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// The Śaka calendar is a solar calendar with 365 days in the year plus an additional leap day in certain years.
///
/// The year consists of twelve months. The first month contains an additional day in leap years.
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
/// The Śaka calendar took effect on March 22, 1957 in the Gregorian calendar.
///
/// The Śaka calendar epoch in the Julian calendar is March 24, 79 CE.
///
/// - seealso: [Indian national calendar](https://en.wikipedia.org/wiki/Indian_national_calendar)
public struct SakaCalendar {
	/// The Julian day number when the Śaka calendar took effect.
	///
	/// This JDN corresponds to noon on March 22, 1957 in the Gregorian calendar.
	public static let effectiveJulianDayNumber: JulianDayNumber = 2435920

	/// The Julian date when the Śaka calendar took effect.
	///
	/// This JD corresponds to midnight on March 22, 1957 in the Gregorian calendar.
	public static let effectiveJulianDate: JulianDate = 2435919.5

	/// The Julian day number of the epoch of the Śaka calendar.
	///
	/// This JDN corresponds to noon on March 24, 79 CE in the Julian calendar.
	public static let epochJulianDayNumber: JulianDayNumber = 1749995

	/// The Julian date of the epoch of the Śaka calendar.
	///
	/// This JD corresponds to midnight on March 24, 79 CE in the Julian calendar.
	public static let epochJulianDate: JulianDate = 1749994.5

	/// A year in the Śaka calendar.
	public typealias Year = Int

	/// A month in the Śaka calendar numbered from `1` (Chaitra) to `12` (Phālguna).
	public typealias Month = Int

	/// A day in the Śaka calendar numbered starting from `1`.
	public typealias Day = Int

	/// Returns `true` if the specified year, month, and day form a valid date in the Śaka calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	/// - parameter D: A day number.
	///
	/// - returns: `true` if the specified year, month, and day form a valid date in the Śaka calendar.
	public static func isDateValid(year Y: Year, month M: Month, day D: Day) -> Bool {
		M > 0 && M <= 12 && D > 0 && D <= daysInMonth(year: Y, month: M)
	}

	/// Returns `true` if the specified Julian day number occurred before the Śaka calendar took effect.
	///
	/// The Śaka calendar took effect on JDN 2435920.
	///
	/// - parameter julianDayNumber: A Julian day number.
	///
	/// - returns: `true` if the specified specified Julian day number occurred before the Śaka calendar took effect.
	public static func isProleptic(julianDayNumber: JulianDayNumber) -> Bool {
		julianDayNumber < effectiveJulianDayNumber
	}

	/// Returns `true` if the specified Julian date occurred before the Śaka calendar took effect.
	///
	/// The Śaka calendar took effect on JD 2435919.5.
	///
	/// - parameter julianDate: A Julian date.
	///
	/// - returns: `true` if the specified specified Julian date occurred before the Śaka calendar took effect.
	public static func isProleptic(julianDate: JulianDate) -> Bool {
		julianDate < effectiveJulianDate
	}

	/// Returns `true` if the specified year is a leap year in the Śaka calendar.
	///
	/// A Śaka year is a leap year if its numerical designation plus 78 would be a leap year in the Gregorian calendar.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: `true` if the specified year is a leap year in the Śaka calendar.
	public static func isLeapYear(_ Y: Year) -> Bool {
		GregorianCalendar.isLeapYear(Y + 78)
	}

	/// The number of months in one year.
	public static let monthsInYear = 12

	/// The number of days in each month indexed from `0` (Chaitra) to `11` (Phālguna).
	static let monthLengths = [ 30, 31, 31, 31, 31, 31, 30, 30, 30, 30, 30, 30 ]

	/// Returns the number of days in the specified month and year in the Śaka calendar.
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

// Algorithm adapted from the Explanatory Supplement to the Astronomical Almanac, 3rd edition, S.E Urban and P.K. Seidelmann eds., (Mill Valley, CA: University Science Books), Chapter 15, pp. 585-624.

extension SakaCalendar: JulianDayNumberConverting {
	/// A date in the Śaka calendar consists of a year, month, and day.
	public typealias DateType = (year: Int, month: Int, day: Int)

	/// Algorithm parameters for Śaka calendar conversions.
	static let conversionParameters = JDNConversionParameters(y: 4794, j: 1348, m: 1, n: 12, r: 4, p: 1461, q: 0, v: 3, u: 1, s: 31, t: 0, w: 0)

	/// Gregorian intercalating parameters for Śaka calendar conversions.
	static let gregorianIntercalatingParameters = JDNGregorianIntercalatingParameters(A: 184, B: 274073, C: -36)

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		var Y = date.year
		var ΔcalendarCycles = 0

		if Y <= -conversionParameters.y {
			ΔcalendarCycles = (-conversionParameters.y - Y) / gregorianIntercalatingCycle.years + 1
			Y += ΔcalendarCycles * gregorianIntercalatingCycle.years
		}

		let h = date.month - conversionParameters.m
		let g = Y + conversionParameters.y - (conversionParameters.n - h) / conversionParameters.n
		let f = (h - 1 + conversionParameters.n) % conversionParameters.n
		let e = (conversionParameters.p * g + conversionParameters.q) / conversionParameters.r + date.day - 1 - conversionParameters.j
		let Z = f / 6
		var J = e + ((31 - Z) * f + 5 * Z) / conversionParameters.u
		J = J - (3 * ((g + gregorianIntercalatingParameters.A) / 100)) / 4 - gregorianIntercalatingParameters.C

		if ΔcalendarCycles > 0 {
			J -= ΔcalendarCycles * gregorianIntercalatingCycle.days
		}

		return J
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		var J = J
		var ΔcalendarCycles = 0

		// Richards' algorithm is only valid for positive JDNs.
		if J < 0 {
			ΔcalendarCycles = -J / gregorianIntercalatingCycle.days + 1
			J += ΔcalendarCycles * gregorianIntercalatingCycle.days
		}

		precondition(J <= Int.max - conversionParameters.j, "Julian day number too large")

		var f = J + conversionParameters.j
		f = f + (((4 * J + gregorianIntercalatingParameters.B) / 146097) * 3) / 4 + gregorianIntercalatingParameters.C
		let e = conversionParameters.r * f + conversionParameters.v
		let g = (e % conversionParameters.p) / conversionParameters.r
		let X = g / 365
		let Z = g / 185 - X
		let s = 31 - Z
		let w = -5 * Z
		let h = conversionParameters.u * g + w
		let D = (6 * X + (h % s)) / conversionParameters.u + 1

		let M = ((h / s + conversionParameters.m) % conversionParameters.n) + 1
		var Y = e / conversionParameters.p - conversionParameters.y + (conversionParameters.n + conversionParameters.m - M) / conversionParameters.n

		if ΔcalendarCycles > 0 {
			Y -= ΔcalendarCycles * gregorianIntercalatingCycle.years
		}

		return (Y, M, D)
	}
}
