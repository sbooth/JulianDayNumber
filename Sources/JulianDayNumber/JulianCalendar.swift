//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// The year, month, and day of the introduction of the Julian calendar.
///
/// The Julian calendar was introduced on -0045-01-01.
public let julianCalendarIntroductionDate = (year: -45, month: 1, day: 1)

/// The Julian day number of the introduction of the Julian calendar.
///
/// This JDN corresponds to -0045-01-01 12:00 in the Julian calendar.
public let julianCalendarIntroductionJDN = 1704622

/// The Julian date of the introduction of the Julian calendar.
///
/// This JD corresponds to -0045-01-01 00:00 in the Julian calendar.
public let julianCalendarIntroductionJD = 1704621.5

/// The Julian calendar.
///
/// The Julian calendar took effect on January 1, 45 BC (-0045-01-01).
public enum JulianCalendar {
	/// Returns `true` if the specified year, month, and day form a valid date in the Julian calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number between `1` (January) and `12` (December).
	/// - parameter D: A day number between `1` and the maximum number of days in month `M` for year `Y`.
	///
	/// - returns: `true` if the specified year, month, and day form a valid date in the Julian calendar.
	static public func isValid(year Y: Int, month M: Int, day D: Int) -> Bool {
		M > 0 && M <= 12 && D > 0 && D <= daysInMonth(year: Y, month: M)
	}

	/// Returns `true` if the specified year, month, and day occurred before the introduction of the Julian calendar.
	///
	/// The Julian calendar was introduced on -0045-01-01.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number between `1` (January) and `12` (December).
	/// - parameter D: A day number between `1` and the maximum number of days in month `M` for year `Y`.
	///
	/// - returns: `true` if the specified year, month, and day occurred before the introduction of the Julian calendar.
	static public func isProleptic(year Y: Int, month M: Int, day D: Int) -> Bool {
		(Y, M, D) < julianCalendarIntroductionDate
	}

	/// Returns `true` if the specified Julian day number occurred before the introduction of the Julian calendar.
	///
	/// The Julian calendar was introduced on JDN 1704622.
	///
	/// - parameter julianDayNumber: A Julian day number.
	///
	/// - returns: `true` if the specified specified Julian day number occurred before the introduction of the Julian calendar.
	static public func isProleptic(julianDayNumber: Int) -> Bool {
		julianDayNumber < julianCalendarIntroductionJDN
	}

	/// Returns `true` if the specified Julian date occurred before the introduction of the Julian calendar.
	///
	/// The Julian calendar was introduced on JD 1704621.5.
	///
	/// - parameter julianDate: A Julian date.
	///
	/// - returns: `true` if the specified specified Julian date occurred before the introduction of the Julian calendar.
	static public func isProleptic(julianDate: Double) -> Bool {
		julianDate < julianCalendarIntroductionJD
	}

	/// Returns `true` if the specified year is a leap year in the Julian calendar.
	///
	/// A Julian year is a leap (bissextile) year if its numerical designation is divisible by 4.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: `true` if the specified year is a leap year in the Julian calendar.
	static public func isLeapYear(_ Y: Int) -> Bool {
		Y % 4 == 0
	}

	/// The number of days in each month indexed from `0` (January) to `11` (December).
	static let monthLengths = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ]

	/// Returns the number of days in the specified month and year in the Julian calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number between `1` (January) and `12` (December).
	///
	/// - returns: The number of days in the specified month and year.
	static public func daysInMonth(year Y: Int, month M: Int) -> Int {
		guard M > 0, M <= 12 else {
			return 0
		}

		if M == 2 {
			return isLeapYear(Y) ? 29 : 28
		} else {
			return monthLengths[M - 1]
		}
	}

	/// Returns the month and day of Easter in the specified year in the Julian calendar.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: The month and day of Easter in the specified year.
	static public func easter(year Y: Int) -> (month: Int, day: Int) {
		// Algorithm from the Explanatory Supplement to the Astronomical Almanac, 3rd edition, S.E Urban and P.K. Seidelmann eds., (Mill Valley, CA: University Science Books), Chapter 15, pp. 585-624.
		let a = 22 + ((225 - 11 * (Y % 19)) % 30)
		let g = a + ((56 + 6 * Y - Y / 4 - a) % 7)
		let M = 3 + g / 32
		let D = 1 + ((g - 1) % 31)
		return (M, D)
	}
}
