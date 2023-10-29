//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// Converts a date in the Gregorian calendar to a Julian day number (JDN).
///
/// The Julian day number (JDN) is the integer assigned to a whole solar day in the Julian day count starting from noon Universal Time,
/// with JDN 0 assigned to the day starting at noon on November 24, 4714 BC in the proleptic Gregorian calendar.
///
/// - note: No validation checks are performed on the date values.
///
/// - parameter Y: A year number between `-9999` and `99999`.
/// - parameter M: A month number between `1` (January) and `12` (December).
/// - parameter D: A day number between `1` and the maximum number of days in month `M` for year `Y`.
/// - returns: The JDN corresponding to the requested date.
public func gregorianCalendarDateToJulianDayNumber(year Y: Int, month M: Int, day D: Int) -> Int {
	// Richards' algorithm is only valid for positive JDNs.
	// JDN 0 is -4713-Nov-24 in the proleptic Gregorian calendar.
	// Adjust the year of earlier dates forward in time by a multiple of
	// 400 (to account for leap years in the Gregorian calendar)
	// before calculating the JDN and then translate the result backward
	// in time by the period of adjustment.
	if Y < -4713 || (Y == -4713 && (M < 11 || (M == 11 && D < 24))) {
		// 400 years * 365.2425 days/year = 146,097 days
		let periods = (-4714 - Y) / 400 + 1
		let mappedY = Y + periods * 400
		let mappedJ = gregorianCalendarDateToJulianDayNumber(year: mappedY, month: M, day: D)
		return mappedJ - periods * 146097
	}

	let h = M - m
	let g = Y + y - (n - h) / n
	let f = (h - 1 + n) % n
	let e = (p * g + q) / r + D - 1 - j
	var J = e + (s * f + t) / u
	J = J - (3 * ((g + A) / 100)) / 4 - C

	return J
}

/// The earliest supported JDN using the Gregorian calendar.
///
/// This JDN corresponds to -9999-Jan-01 12:00:00 in the Gregorian calendar.
let earliestSupportedGregorianCalendarJDN = -1930999

/// The latest supported JDN using the Gregorian calendar.
///
/// This JDN corresponds to 99999-Dec-31 12:00:00 in the Gregorian calendar.
let latestSupportedGregorianCalendarJDN = latestSupportedJDN

/// Converts the Julian day number `J` to a date in the Gregorian calendar.
///
/// - parameter J: A Julian day number between `-1930999` and `38245309`.
/// - returns: The calendar date corresponding to `J`.
public func julianDayNumberToGregorianCalendarDate(_ J: Int) -> (year: Int, month: Int, day: Int) {
	// Richards' algorithm is only valid for positive JDNs.
	// Adjust earlier JDNs forward in time by a multiple of
	// 400 years (to account for leap years in the Gregorian calendar)
	// before calculating the proleptic Gregorian date and then translate
	// the result backward in time by the period of adjustment.
	if J < 0 {
		// 400 years * 365.2425 days/year = 146,097 days
		let periods = -J / 146097 + 1
		let mappedJ = J + periods * 146097
		let mappedYMD = julianDayNumberToGregorianCalendarDate(mappedJ)
		return (mappedYMD.year - periods * 400, mappedYMD.month, mappedYMD.day)
	}

	var f = J + j
	f = f + (((4 * J + B) / 146097) * 3) / 4 + C
	let e = r * f + v
	let g = (e % p) / r
	let h = u * g + w
	let D = (h % s) / u + 1
	let M = ((h / s + m) % n) + 1
	let Y = e / p - y + (n + m - M) / n

	return (Y, M, D)
}

// Constants for Gregorian calendar conversions
private let y = 4716
private let j = 1401
private let m = 2
private let n = 12
private let r = 4
private let p = 1461
private let q = 0
private let v = 3
private let u = 5
private let s = 153
private let t = 2
private let w = 2
private let A = 184
private let B = 274277
private let C = -38
