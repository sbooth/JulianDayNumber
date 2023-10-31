//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// Converts a date in the Julian calendar to a Julian day number.
///
/// The Julian day number (JDN) is the integer assigned to a whole solar day in the Julian day count starting from noon Universal Time,
/// with JDN 0 assigned to the day starting at noon on Monday, January 1, 4713 BC (-4712-01-01 12:00:00) in the proleptic Julian calendar.
///
/// - note: No validation checks are performed on the date values.
///
/// - parameter Y: A year number between `-9999` and `99999`.
/// - parameter M: A month number between `1` (January) and `12` (December).
/// - parameter D: A day number between `1` and the maximum number of days in month `M` for year `Y`.
///
/// - returns: The JDN corresponding to the requested date.
public func julianCalendarDateToJulianDayNumber(year Y: Int, month M: Int, day D: Int) -> Int {
	var Y = Y
	var ΔleapCycles = 0

	// Richards' algorithm is only valid for positive JDNs.
	// JDN 0 is -4712-01-01 in the proleptic Julian calendar.
	// Adjust the year of earlier dates forward in time by a multiple of
	// 4 (the frequency of leap years in the Julian calendar)
	// before calculating the JDN and then translate the result backward
	// in time by the period of adjustment.
	if Y < -4712 {
		// 4 years * 365.25 days/year = 1,461 days
		ΔleapCycles = (-4713 - Y) / 4 + 1
		Y += ΔleapCycles * 4
	}

	let h = M - m
	let g = Y + y - (n - h) / n
	let f = (h - 1 + n) % n
	let e = (p * g + q) / r + D - 1 - j
	var J = e + (s * f + t) / u

	if ΔleapCycles > 0 {
		J -= ΔleapCycles * 1461
	}

	return J
}

/// The earliest supported Julian day number using the Julian calendar.
///
/// This JDN corresponds to -9999-01-01 12:00:00 in the Julian calendar
let earliestSupportedJulianCalendarJDN = earliestSupportedJDN

/// The latest supported Julian day number using the Julian calendar.
///
/// This JDN corresponds to 99999-12-31 12:00:00 in the Julian calendar
let latestSupportedJulianCalendarJDN = 38246057

/// Converts the Julian day number `J` to a date in the Julian calendar.
///
/// - parameter J: A Julian day number between `-1931076` and `38246057`.
///
/// - returns: The calendar date corresponding to `J`.
public func julianDayNumberToJulianCalendarDate(_ J: Int) -> (year: Int, month: Int, day: Int) {
	var J = J
	var ΔleapCycles = 0

	// Richards' algorithm is only valid for positive JDNs.
	// Adjust negative JDNs forward in time by a multiple of
	// 4 years (the frequency of leap years in the Julian calendar)
	// before calculating the proleptic Julian date and then translate
	// the result backward in time by the amount of forward adjustment.
	if J < 0 {
		// 4 years * 365.25 days/year = 1,461 days
		ΔleapCycles = -J / 1461 + 1
		J += ΔleapCycles * 1461
	}

	let f = J + j
	let e = r * f + v
	let g = (e % p) / r
	let h = u * g + w
	let D = (h % s) / u + 1
	let M = ((h / s + m) % n) + 1
	var Y = e / p - y + (n + m - M) / n

	if ΔleapCycles > 0 {
		Y -= ΔleapCycles * 4
	}

	return (Y, M, D)
}

// Constants for Julian calendar conversions
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
