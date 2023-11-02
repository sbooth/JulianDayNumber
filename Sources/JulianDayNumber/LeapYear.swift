//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// Returns `true` if `Y` is a leap year in `calendar`.
///
/// - parameter Y: A year number.
/// - parameter calendar: The calendar used to interpret the year.
///
/// - returns: `true` if `Y` is a leap year in the specified calendar.
public func isLeapYear(_ Y: Int, calendar: JDN.Calendar = .julianGregorian) -> Bool {
	switch calendar {
	case .julian:
		return isJulianCalendarLeapYear(Y)
	case .gregorian:
		return isGregorianCalendarLeapYear(Y)
	case .julianGregorian:
		if Y < gregorianCalendarChangeoverDate.year {
			return isJulianCalendarLeapYear(Y)
		} else {
			return isGregorianCalendarLeapYear(Y)
		}
	case .islamic:
		return isIslamicCalendarLeapYear(Y)
	}
}

/// Returns `true` if `Y` is a leap year in the Julian calendar.
///
/// A Julian year is a leap (bissextile) year if its numerical designation is divisible by 4.
///
/// - parameter Y: A year number.
///
/// - returns: `true` if `Y` is a leap year in the Julian calendar.
public func isJulianCalendarLeapYear(_ Y: Int) -> Bool {
	Y % 4 == 0
}

/// Returns `true` if `Y` is a leap year in the Gregorian calendar.
///
/// A Gregorian year is a leap (bissextile) year if its numerical designation is divisible by 4
/// excluding centurial years *not* divisible by 400.
///
/// - parameter Y: A year number.
///
/// - returns: `true` if `Y` is a leap year in the Gregorian calendar.
public func isGregorianCalendarLeapYear(_ Y: Int) -> Bool {
	Y % 100 == 0 ? Y % 400 == 0 : Y % 4 == 0
}

/// Returns `true` if `Y` is a leap year in the Islamic calendar.
///
/// There are eleven leap years in a cycle of thirty years.
/// These are years 2, 5, 7, 10, 13, 16, 18, 21, 24, 26, and 29 of the cycle.
/// The year 1 A.H. was the first of a cycle.
///
/// - parameter Y: A year number.
///
/// - returns: `true` if `Y` is a leap year in the Islamic calendar.
public func isIslamicCalendarLeapYear(_ year: Int) -> Bool {
	let yearInCycle = (year - 1) % 30 + (year < 1 ? 31 : 1)
	return yearInCycle == 2 || yearInCycle == 5 || yearInCycle == 7 || yearInCycle == 10 || yearInCycle == 13 || yearInCycle == 16 || yearInCycle == 18 || yearInCycle == 21 || yearInCycle == 24 || yearInCycle == 26 || yearInCycle == 29
}
