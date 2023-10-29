//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

// From the Explanatory Supplement to the Astronomical Almanac, 3rd edition, S.E Urban and P.K. Seidelmann eds., (Mill Valley, CA: University Science Books), Chapter 15, pp. 585-624.

/// Converts a calendar date to a Julian day number.
///
/// The Julian day number (JDN) is the integer assigned to a whole solar day in the Julian day count starting from noon Universal Time,
/// with JDN 0 assigned to the day starting at noon on Monday, January 1, 4713 BC (-4712-01-01 12:00:00) in the proleptic Julian calendar
/// (November 24, 4714 BC [-4713-11-24 12:00:00] in the proleptic Gregorian calendar).
///
/// Dates before 1582-10-15 are interpreted in the Julian calendar while later dates are interpreted in the Gregorian calendar.
///
/// - note: No validation checks are performed on the date values.
///
/// - parameter Y: A year number between `-9999` and `99999`.
/// - parameter M: A month number between `1` (January) and `12` (December).
/// - parameter D: A day number between `1` and the maximum number of days in month `M` for year `Y`.
/// - returns: The JDN corresponding to the requested date.
public func calendarDateToJulianDayNumber(year Y: Int, month M: Int, day D: Int) -> Int {
	if Y > 1582 || (Y == 1582 && (M > 10 || (M == 10 && D >= 15))) {
		return gregorianCalendarDateToJulianDayNumber(year: Y, month: M, day: D)
	} else {
		return julianCalendarDateToJulianDayNumber(year: Y, month: M, day: D)
	}
}

/// The earliest supported JDN.
///
/// This JDN corresponds to -9999-01-01 12:00:00 in the Julian calendar
let earliestSupportedJDN = -1931076

/// The latest supported JDN.
///
/// This JDN corresponds to 99999-12-31 12:00:00 in the Gregorian calendar.
let latestSupportedJDN = 38245309

/// Converts the Julian day number `J` to a calendar date.
///
/// JDN values less than `2299161` are interpreted in the Julian calendar while greater or equal JDN values are interpreted in the Gregorian calendar.
///
/// - parameter J: A Julian day number between `-1931076` and `38245309`.
/// - returns: The calendar date corresponding to `J`.
public func julianDayNumberToCalendarDate(_ J: Int) -> (year: Int, month: Int, day: Int) {
	if J > 2299160 {
		return julianDayNumberToGregorianCalendarDate(J)
	} else {
		return julianDayNumberToJulianCalendarDate(J)
	}
}
