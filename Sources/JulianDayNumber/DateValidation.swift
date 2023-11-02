//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// Returns `true` if year `Y`, month `M`, and day `D` form a valid date in `calendar`.
///
/// - parameter Y: A year number.
/// - parameter M: A month number between `1` and the maximum number of months in year `Y`.
/// - parameter D: A day number between `1` and the maximum number of days in month `M` for year `Y`.
/// - parameter calendar: The calendar used to interpret the month and year.
///
/// - returns: `true` if `Y`, `M`, `D` is a valid date.
public func isDateValid(year Y: Int, month M: Int, day D: Int, calendar: JDN.Calendar = .julianGregorian) -> Bool {
	switch calendar {
	case .julian:
		return isJulianCalendarDateValid(year: Y, month: M, day: D)
	case .gregorian:
		return isGregorianCalendarDateValid(year: Y, month: M, day: D)
	case .julianGregorian:
		if (Y, M, D) < gregorianCalendarChangeoverDate {
			return isJulianCalendarDateValid(year: Y, month: M, day: D)
		} else {
			return isGregorianCalendarDateValid(year: Y, month: M, day: D)
		}
	case .islamic:
		return isIslamicCalendarDateValid(year: Y, month: M, day: D)
	}
}

/// Returns `true` if year `Y`, month `M`, and day `D` form a valid date in the Julian calendar.
///
/// - parameter Y: A year number.
/// - parameter M: A month number between `1` (January) and `12` (December).
/// - parameter D: A day number between `1` and the maximum number of days in month `M` for year `Y`.
///
/// - returns: `true` if `Y`, `M`, `D` is a valid date in the Julian calendar.
public func isJulianCalendarDateValid(year Y: Int, month M: Int, day D: Int) -> Bool {
	guard M > 0 && M <= 12 else {
		return false
	}
	return D > 0 && D <= daysInJulianCalendarMonth(year: Y, month: M)
}

/// Returns `true` if year `Y`, month `M`, and day `D` form a valid date in the Gregorian calendar.
///
/// - parameter Y: A year number.
/// - parameter M: A month number between `1` (January) and `12` (December).
/// - parameter D: A day number between `1` and the maximum number of days in month `M` for year `Y`.
///
/// - returns: `true` if `Y`, `M`, `D` is a valid date in the Gregorian calendar.
public func isGregorianCalendarDateValid(year Y: Int, month M: Int, day D: Int) -> Bool {
	guard M > 0 && M <= 12 else {
		return false
	}
	return D > 0 && D <= daysInGregorianCalendarMonth(year: Y, month: M)
}

/// Returns `true` if year `Y`, month `M`, and day `D` form a valid date in the Islamic calendar.
///
/// - parameter Y: A year number.
/// - parameter M: A month number between `1` (Muharram) and `12` (Dhú’l-Hijjab).
/// - parameter D: A day number between `1` and the maximum number of days in month `M` for year `Y`.
///
/// - returns: `true` if `Y`, `M`, `D` is a valid date in the Islamic calendar.
public func isIslamicCalendarDateValid(year Y: Int, month M: Int, day D: Int) -> Bool {
	guard M > 0 && M <= 12 else {
		return false
	}
	return D > 0 && D <= daysInIslamicCalendarMonth(year: Y, month: M)
}
