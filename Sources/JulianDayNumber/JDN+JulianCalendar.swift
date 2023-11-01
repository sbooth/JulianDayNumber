//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

// Algorithm from the Explanatory Supplement to the Astronomical Almanac, 3rd edition, S.E Urban and P.K. Seidelmann eds., (Mill Valley, CA: University Science Books), Chapter 15, pp. 585-624.

/// The number of years in a cycle of the Julian calendar.
///
/// A cycle in the Julian calendar consists of 3 common years and 1 leap year.
let julianCalendarCycleYears = 4

/// The number of days in a cycle of the Julian calendar.
///
/// A cycle in the Julian calendar consists of 3 years of 365 days and 1 leap year of 366 days.
let julianCalendarCycleDays = 1461

/// The earliest supported Julian day number using the Julian calendar.
///
/// This JDN corresponds to -9999-01-01 12:00:00 in the Julian calendar
let earliestSupportedJulianCalendarJDN = -1931076

/// The latest supported Julian day number using the Julian calendar.
///
/// This JDN corresponds to 99999-12-31 12:00:00 in the Julian calendar
let latestSupportedJulianCalendarJDN = 38246057

/// Converts a year, month, and day in the Julian calendar to a Julian day number.
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
/// - returns: The Julian day number corresponding to the specified year, month, and day.
public func julianCalendarDateToJulianDayNumber(year Y: Int, month M: Int, day D: Int) -> Int {
	var Y = Y
	var ΔcalendarCycles = 0

	// Richards' algorithm is only valid for positive JDNs.
	// JDN 0 is -4712-01-01 in the proleptic Julian calendar.
	// Adjust the year of earlier dates forward in time by a multiple of
	// the calendar's cycle before calculating the JDN, and then translate
	// the result backward in time by the period of adjustment.
	if Y < -4712 {
		ΔcalendarCycles = (-4713 - Y) / julianCalendarCycleYears + 1
		Y += ΔcalendarCycles * julianCalendarCycleYears
	}

	let h = M - m
	let g = Y + y - (n - h) / n
	let f = (h - 1 + n) % n
	let e = (p * g + q) / r + D - 1 - j
	var J = e + (s * f + t) / u

	if ΔcalendarCycles > 0 {
		J -= ΔcalendarCycles * julianCalendarCycleDays
	}

	return J
}

/// Converts the Julian day number `J` to a year, month, and day in the Julian calendar.
///
/// - parameter J: A Julian day number between `-1931076` and `38246057`.
///
/// - returns: The year, month, and day corresponding to the specified Julian day number.
public func julianDayNumberToJulianCalendarDate(_ J: Int) -> (year: Int, month: Int, day: Int) {
	var J = J
	var ΔcalendarCycles = 0

	// Richards' algorithm is only valid for positive JDNs.
	// Adjust negative JDNs forward in time by a multiple of
	// the calendar's cycle before calculating the JDN, and then translate
	// the result backward in time by the period of adjustment.
	if J < 0 {
		ΔcalendarCycles = -J / julianCalendarCycleDays + 1
		J += ΔcalendarCycles * julianCalendarCycleDays
	}

	let f = J + j
	let e = r * f + v
	let g = (e % p) / r
	let h = u * g + w
	let D = (h % s) / u + 1
	let M = ((h / s + m) % n) + 1
	var Y = e / p - y + (n + m - M) / n

	if ΔcalendarCycles > 0 {
		Y -= ΔcalendarCycles * julianCalendarCycleYears
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
