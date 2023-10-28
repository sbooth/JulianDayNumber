//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// Returns `true` if `Y` is a leap year.
///
/// Years before 1582 are interpreted in the Julian calendar and years after
/// 1582 are interpreted in the Gregorian calendar.
///
/// - parameter Y: A year number.
/// - returns: `true` if `Y` is a leap year.
public func isLeapYear(_ Y: Int) -> Bool {
	Y < 1582 ? isJulianCalendarLeapYear(Y) : isGregorianCalendarLeapYear(Y)
}

/// Returns `true` if `Y` is a leap year according to the Gregorian calendar.
///
/// A Gregorian year is a leap (bissextile) year if its numerical designation is divisible by 4
/// excluding centurial years *not* divisible by 400.
///
/// - parameter Y: A year number.
/// - returns: `true` if `Y` is a leap year in the Gregorian calendar.
public func isGregorianCalendarLeapYear(_ Y: Int) -> Bool {
	Y % 100 == 0 ? Y % 400 == 0 : Y % 4 == 0
}

/// Returns `true` if `Y` is a leap year according to the Julian calendar.
///
/// A Julian year is a leap (bissextile) year if its numerical designation is divisible by 4.
///
/// - parameter Y: A year number.
/// - returns: `true` if `Y` is a leap year in the Julian calendar.
public func isJulianCalendarLeapYear(_ Y: Int) -> Bool {
	Y % 4 == 0
}
