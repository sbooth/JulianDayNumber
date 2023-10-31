//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// Converts a date in the Islamic calendar to a Julian date.
///
/// The Julian date (JD) is the Julian Day Number (JDN) plus the fraction of a day since the preceding noon in Universal Time.
/// Julian dates are expressed as a JDN with a decimal fraction added.
///
/// - note: No validation checks are performed on the date values.
///
/// - parameter Y: A year number between `-9999` and `99999`.
/// - parameter M: A month number between `1` (Muharram) and `12` (Dhu ́’l-Hijjab).
/// - parameter D: A day number between `1` and the maximum number of days in month `M` for year `Y`.
/// - parameter h: An hour number between `0` and `23`.
/// - parameter m: A minute number between `0` and `59`.
/// - parameter s: A second number between `0` and `59`.
///
/// - returns: The JD corresponding to the requested date.
public func islamicCalendarDateToJulianDate(year Y: Int, month M: Int, day D: Int, hour h: Int = 0, minute m: Int = 0, second s: Double = 0) -> Double {
	Double(islamicCalendarDateToJulianDayNumber(year: Y, month: M, day: D)) - 0.5 + timeToFractionalDay(hour: h, minute: m, second: s)
}

/// Converts a date in the Islamic calendar to a Julian date.
///
/// The Julian date (JD) is the Julian Day Number (JDN) plus the fraction of a day since the preceding noon in Universal Time.
/// Julian dates are expressed as a JDN with a decimal fraction added.
///
/// - note: No validation checks are performed on the date values.
///
/// - parameter Y: A year number between `-9999` and `99999`.
/// - parameter M: A month number between `1` (Muharram) and `12` (Dhu ́’l-Hijjab).
/// - parameter D: A decimal day between `1` and the maximum number of days in month `M` for year `Y`.
///
/// - returns: The JD corresponding to the requested date.
public func islamicCalendarDateToJulianDate(year Y: Int, month M: Int, day D: Double) -> Double {
	let (day, dayFraction) = modf(D)
	return Double(islamicCalendarDateToJulianDayNumber(year: Y, month: M, day: Int(day))) - 0.5 + dayFraction
}

/// The earliest supported JD using the Islamic calendar.
///
/// This JD corresponds to -9999-01-01 00:00:00 in the Islamic calendar.
let earliestSupportedIslamicCalendarJD = -1595227.5

/// The latest supported JD using the Islamic calendar.
///
/// This JD corresponds to 99999-12-29 00:00:00 in the Islamic calendar.
let latestSupportedIslamicCalendarJD = 37384750.5

/// Converts the Julian date `JD` to a date in the Islamic calendar.
///
/// - parameter JD: A Julian date between `-1595227.5` and `37384750.5`.
///
/// - returns: A tuple specifying the requested date.
public func julianDateToIslamicCalendarDate(_ JD: Double) -> (year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Double) {
	convertJDToCalendarDate(JD, usingJDNConversionFunction: julianDayNumberToIslamicCalendarDate)
}