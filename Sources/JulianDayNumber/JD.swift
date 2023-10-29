//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// Converts a calendar date to a Julian date.
///
/// The Julian date (JD) of an instant is the Julian Day Number (JDN) plus the fraction of a day since the preceding noon in Universal Time.
/// Julian dates are expressed as a JDN with a decimal fraction added. For example, the Julian date for 2013-01-01 00:30:00.0 UT
/// is 2456293.520833.
///
/// Dates before 1582-10-15 are interpreted in the Julian calendar while later dates are interpreted in the Gregorian calendar.
///
/// - note: No validation checks are performed on the date values.
///
/// - parameter Y: A year number between `-9999` and `99999`.
/// - parameter M: A month number between `1` (January) and `12` (December).
/// - parameter D: A day number between `1` and the maximum number of days in month `M` for year `Y`.
/// - parameter h: An hour number between `0` and `23`.
/// - parameter m: A minute number between `0` and `59`.
/// - parameter s: A second number between `0` and `59`.
/// - returns: The JD corresponding to the requested date.
public func calendarDateToJulianDate(year Y: Int, month M: Int, day D: Int, hour h: Int = 0, minute m: Int = 0, second s: Double = 0) -> Double {
	calendarDateToJulianDate(year: Y, month: M, day: Double(D) + timeToFractionalDay(hour: h, minute: m, second: s))
}

/// Converts a calendar date to a Julian date.
///
/// The Julian date (JD) of an instant is the Julian Day Number (JDN) plus the fraction of a day since the preceding noon in Universal Time.
/// Julian dates are expressed as a JDN with a decimal fraction added. For example, the Julian date for 2013-01-01 00:30:00.0 UT
/// is 2456293.520833.
///
/// Dates before 1582-10-15 are interpreted in the Julian calendar while later dates are interpreted in the Gregorian calendar.
///
/// - note: No validation checks are performed on the date values.
///
/// - parameter Y: A year number between `-9999` and `99999`.
/// - parameter M: A month number between `1` (January) and `12` (December).
/// - parameter D: A decimal day between `1` and the maximum number of days in month `M` for year `Y`.
/// - returns: The JD corresponding to the requested date.
public func calendarDateToJulianDate(year Y: Int, month M: Int, day D: Double) -> Double {
	let (day, dayFraction) = modf(D)
	return Double(calendarDateToJulianDayNumber(year: Y, month: M, day: Int(day))) - 0.5 + dayFraction
}

/// Converts a date in the Julian calendar to a Julian date.
///
/// The Julian date (JD) of an instant is the Julian Day Number (JDN) plus the fraction of a day since the preceding noon in Universal Time.
/// Julian dates are expressed as a JDN with a decimal fraction added. For example, the Julian date for 2013-01-01 00:30:00.0 UT
/// is 2456293.520833.
///
/// - note: No validation checks are performed on the date values.
///
/// - parameter Y: A year number between `-9999` and `99999`.
/// - parameter M: A month number between `1` (January) and `12` (December).
/// - parameter D: A day number between `1` and the maximum number of days in month `M` for year `Y`.
/// - parameter h: An hour number between `0` and `23`.
/// - parameter m: A minute number between `0` and `59`.
/// - parameter s: A second number between `0` and `59`.
/// - returns: The JD corresponding to the requested date.
public func julianCalendarDateToJulianDate(year Y: Int, month M: Int, day D: Int, hour h: Int = 0, minute m: Int = 0, second s: Double = 0) -> Double {
	julianCalendarDateToJulianDate(year: Y, month: M, day: Double(D) + timeToFractionalDay(hour: h, minute: m, second: s))
}

/// Converts a date in the Julian calendar to a Julian date.
///
/// The Julian date (JD) of an instant is the Julian Day Number (JDN) plus the fraction of a day since the preceding noon in Universal Time.
/// Julian dates are expressed as a JDN with a decimal fraction added. For example, the Julian date for 2013-01-01 00:30:00.0 UT
/// is 2456293.520833.
///
/// - note: No validation checks are performed on the date values.
///
/// - parameter Y: A year number between `-9999` and `99999`.
/// - parameter M: A month number between `1` (January) and `12` (December).
/// - parameter D: A decimal day between `1` and the maximum number of days in month `M` for year `Y`.
/// - returns: The JD corresponding to the requested date.
public func julianCalendarDateToJulianDate(year Y: Int, month M: Int, day D: Double) -> Double {
	let (day, dayFraction) = modf(D)
	return Double(julianCalendarDateToJulianDayNumber(year: Y, month: M, day: Int(day))) - 0.5 + dayFraction
}

/// Converts a date in the Gregorian calendar to a Julian date.
///
/// The Julian date (JD) of an instant is the Julian Day Number (JDN) plus the fraction of a day since the preceding noon in Universal Time.
/// Julian dates are expressed as a JDN with a decimal fraction added. For example, the Julian date for 2013-01-01 00:30:00.0 UT
/// is 2456293.520833.
///
/// - note: No validation checks are performed on the date values.
///
/// - parameter Y: A year number between `-9999` and `99999`.
/// - parameter M: A month number between `1` (January) and `12` (December).
/// - parameter D: A day number between `1` and the maximum number of days in month `M` for year `Y`.
/// - parameter h: An hour number between `0` and `23`.
/// - parameter m: A minute number between `0` and `59`.
/// - parameter s: A second number between `0` and `59`.
/// - returns: The JD corresponding to the requested date.
public func gregorianCalendarDateToJulianDate(year Y: Int, month M: Int, day D: Int, hour h: Int = 0, minute m: Int = 0, second s: Double = 0) -> Double {
	gregorianCalendarDateToJulianDate(year: Y, month: M, day: Double(D) + timeToFractionalDay(hour: h, minute: m, second: s))
}

/// Converts a date in the Gregorian calendar to a Julian date.
///
/// The Julian date (JD) of an instant is the Julian Day Number (JDN) plus the fraction of a day since the preceding noon in Universal Time.
/// Julian dates are expressed as a JDN with a decimal fraction added. For example, the Julian date for 2013-01-01 00:30:00.0 UT
/// is 2456293.520833.
///
/// - note: No validation checks are performed on the date values.
///
/// - parameter Y: A year number between `-9999` and `99999`.
/// - parameter M: A month number between `1` (January) and `12` (December).
/// - parameter D: A decimal day between `1` and the maximum number of days in month `M` for year `Y`.
/// - returns: The JD corresponding to the requested date.
public func gregorianCalendarDateToJulianDate(year Y: Int, month M: Int, day D: Double) -> Double {
	let (day, dayFraction) = modf(D)
	return Double(gregorianCalendarDateToJulianDayNumber(year: Y, month: M, day: Int(day))) - 0.5 + dayFraction
}

/// The earliest supported JD.
///
/// This JD corresponds to -9999-01-01 00:00:00 in the Julian calendar.
let earliestSupportedJD = -1931076.5

/// The latest supported JD.
///
/// This JD corresponds to 99999-12-31 00:00:00 in the Gregorian calendar.
let latestSupportedJD = 38245308.5

/// Converts the Julian date `JD` to a calendar date.
///
/// JD values less than `2299160.5` are interpreted in the Julian calendar while greater or equal JD values are interpreted in the Gregorian calendar.
///
/// - parameter JD: A Julian date between `-1931076.5` and `38245308.5`.
/// - returns: A tuple specifying the requested date.
public func julianDateToCalendarDate(_ JD: Double) -> (year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Double) {
	convertJDToCalendarDate(JD, usingJDNConversionFunction: julianDayNumberToCalendarDate)
}

/// The earliest supported JD using the Julian calendar.
///
/// This JD corresponds to -9999-01-01 00:00:00 in the Julian calendar.
let earliestSupportedJulianCalendarJD = earliestSupportedJD

/// The latest supported JD using the Julian calendar.
///
/// This JD corresponds to 99999-12-31 00:00:00 in the Julian calendar.
let latestSupportedJulianCalendarJD = 38246056.5

/// Converts the Julian date `JD` to a date in the Julian calendar.
///
/// - parameter JD: A Julian date between `-1931076.5` and `38246056.5`.
/// - returns: A tuple specifying the requested date.
public func julianDateToJulianCalendarDate(_ JD: Double) -> (year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Double) {
	convertJDToCalendarDate(JD, usingJDNConversionFunction: julianDayNumberToJulianCalendarDate)
}

/// The earliest supported JD using the Gregorian calendar.
///
/// This JD corresponds to -9999-01-01 00:00:00 in the Gregorian calendar.
let earliestSupportedGregorianCalendarJD = -1930999.5

/// The latest supported JD using the Gregorian calendar.
///
/// This JD corresponds to 99999-12-31 00:00:00 in the Gregorian calendar.
let latestSupportedGregorianCalendarJD = latestSupportedJD

/// Converts the Julian date `JD` to a date in the Gregorian calendar.
///
/// - parameter JD: A Julian date between `-1930999.5` and `38245308.5`.
/// - returns: A tuple specifying the requested date.
public func julianDateToGregorianCalendarDate(_ JD: Double) -> (year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Double) {
	convertJDToCalendarDate(JD, usingJDNConversionFunction: julianDayNumberToGregorianCalendarDate)
}

/// Returns the decimal fractional day represented by the time comprised of hour `h`, minute `m`, and second `s`.
/// - parameter h: An hour number between `0` and `23`.
/// - parameter m: A minute number between `0` and `59`.
/// - parameter s: A second number between `0` and `59`.
/// - returns: The fractional day represented by `h`, `m`, and `s`.
func timeToFractionalDay(hour h: Int, minute m: Int, second s: Double) -> Double {
	(Double(h) / 24) + (Double(m) / 1440) + (s / 86400)
}

/// Returns the time represented by the decimal fractional day`fractionalDay`.
/// - parameter fractionalDay: A decimal fractional day in the half-open interval `[0,1)`.
/// - returns: The time represented by `fractionalDay`comprised of hour `h`, minute `m`, and second `s`.
func fractionalDayToTime(_ fractionalDay: Double) -> (hour: Int, minute: Int, second: Double) {
	let h = (fractionalDay * 24).rounded(.towardZero)
	let m = ((fractionalDay - h / 24) * 1440).rounded(.towardZero)
	let s = (fractionalDay - (h / 24) - (m / 1440)) * 84600
	return (Int(h), Int(m), s)
}

/// Converts the Julian date `JD` to a date using `jdnToDateConversionFunction`.
///
/// - parameter JD: A Julian date.
/// - parameter jdnToDateConversionFunction: A function accepting a JDN value and returning equivalent year, month, and day values.
/// - returns: A tuple specifying the requested date.
private func convertJDToCalendarDate(_ JD: Double, usingJDNConversionFunction jdnToDateConversionFunction: (_: Int) -> (Int, Int, Int)) -> (year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Double) {
	let JD = JD + 0.5
	let J = Int(JD.rounded(.down))
	let (Y, M, D) = jdnToDateConversionFunction(J)
	var (_, dayFraction) = modf(JD)
	if dayFraction < 0 {
		dayFraction = abs(dayFraction)
	}
	let (h, m, s) = fractionalDayToTime(dayFraction)
	return (Y, M, D, h, m, s)
}
