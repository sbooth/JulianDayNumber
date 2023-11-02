//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// Returns the number of days in month `M` in year `Y` in `calendar`.
///
/// - parameter Y: A year number.
/// - parameter M: A month number between `1` and the maximum number of months in year `Y`.
/// - parameter calendar: The calendar used to interpret the month and year.
///
/// - returns: The number of days in the requested month.
public func daysInMonth(year Y: Int, month M: Int, calendar: JDN.Calendar = .julianGregorian) -> Int {
	guard M > 0, M <= 12 else {
		return 0
	}

	switch calendar {
	case .julian:
		return daysInJulianCalendarMonth(year: Y, month: M)
	case .gregorian:
		return daysInGregorianCalendarMonth(year: Y, month: M)
	case .julianGregorian:
		if Y < gregorianCalendarChangeoverDate.year {
			return daysInJulianCalendarMonth(year: Y, month: M)
		} else {
			return daysInGregorianCalendarMonth(year: Y, month: M)
		}
	case .islamic:
		return daysInIslamicCalendarMonth(year: Y, month: M)
	}
}

/// The number of days in each month indexed from `0` (January) to `11` (December).
let monthLengths = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ]

/// Returns the number of days in month `M` in year `Y` in the Julian calendar.
///
/// - parameter Y: A year number.
/// - parameter M: A month number between `1` (January) and `12` (December).
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
/// - parameter Y: A year number.
/// - parameter M: A month number between `1` (January) and `12` (December).
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

/// The number of days in each month indexed from `0` (Muharram) to `11` (Dhú’l-Hijjab).
let islamicMonthLengths = [ 30, 29, 30, 29, 30, 29, 30, 29, 30, 29, 30, 29 ]

/// Returns the number of days in month `M` in year `Y` in the Islamic calendar.
///
/// - parameter Y: A year number.
/// - parameter M: A month number between `1` (Muharram) and `12` (Dhú’l-Hijjab).
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
