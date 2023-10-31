//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// Returns the number of days in month `M` in year `Y` in the Julian or Gregorian calendar.
///
/// Years before 1582 are interpreted in the Julian calendar and years after
/// 1582 are interpreted in the Gregorian calendar.
///
/// - parameter year: A year number.
/// - parameter month: A month number between `1` (January) and `12` (December).
///
/// - returns: The number of days in the requested month.
public func daysInMonth(year Y: Int, month M: Int) -> Int {
	guard M > 0, M <= 12 else {
		return 0
	}

	return Y < 1582 ? daysInJulianCalendarMonth(year: Y, month: M) : daysInGregorianCalendarMonth(year: Y, month: M)
}

/// The number of days in each month indexed from `0` (January) to `11` (December).
let monthLengths = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ]

/// Returns the number of days in month `M` in year `Y` in the Julian calendar.
///
/// - parameter year: A year number.
/// - parameter month: A month number between `1` (January) and `12` (December).
///
/// - returns: The number of days in the requested month.
public func daysInJulianCalendarMonth(year Y: Int, month M: Int) -> Int {
	guard M > 0, M <= 12 else {
		return 0
	}

	if M == 2 {
		return isJulianCalendarLeapYear(Y) ? 29 : 28
	} else {
		return monthLengths[M - 1]
	}
}

/// Returns the number of days in month `M` in year `Y` in the Gregorian calendar.
///
/// - parameter year: A year number.
/// - parameter month: A month number between `1` (January) and `12` (December).
///
/// - returns: The number of days in the requested month.
public func daysInGregorianCalendarMonth(year Y: Int, month M: Int) -> Int {
	guard M > 0, M <= 12 else {
		return 0
	}

	if M == 2 {
		return isGregorianCalendarLeapYear(Y) ? 29 : 28
	} else {
		return monthLengths[M - 1]
	}
}

/// The number of days in each month indexed from `0` (Muharram) to `11` (Dhu ́’l-Hijjab).
let islamicMonthLengths = [ 30, 29, 30, 29, 30, 29, 30, 29, 30, 29, 30, 29 ]

/// Returns the number of days in month `M` in year `Y` in the Islamic calendar.
///
/// - parameter year: A year number.
/// - parameter M: A month number between `1` (Muharram) and `12` (Dhu ́’l-Hijjab).
///
/// - returns: The number of days in the requested month.
public func daysInIslamicCalendarMonth(year Y: Int, month M: Int) -> Int {
	guard M > 0, M <= 12 else {
		return 0
	}

	if M == 12 {
		return isIslamicCalendarLeapYear(Y) ? 30 : 29
	} else {
		return islamicMonthLengths[M - 1]
	}
}
