//
//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// Converts a date in the Islamic calendar to a Julian day number.
///
/// The Julian day number (JDN) is the integer assigned to a whole solar day in the Julian day count starting from noon Universal Time,
/// with JDN 0 assigned to the day starting at noon on yawm al-'ithnayn, Shaabán 17, 5499 B.H. (-5498-08-16 12:00:00) in the proleptic Islamic calendar.
///
/// - note: No validation checks are performed on the date values.
///
/// - parameter Y: A year number between `-9999` and `99999`.
/// - parameter M: A month number between `1` (Muharram) and `12` (Dhu ́’l-Hijjab).
/// - parameter D: A day number between `1` and the maximum number of days in month `M` for year `Y`.
///
/// - returns: The JDN corresponding to the requested date.
public func islamicCalendarDateToJulianDayNumber(year Y: Int, month M: Int, day D: Int) -> Int {
	// Richards' algorithm is only valid for positive JDNs.
	// JDN 0 is -5498-08-16 in the proleptic Islamic calendar.
	// Adjust the year of earlier dates forward in time by a multiple of
	// 30 (to account for leap years in the Islamic calendar)
	// before calculating the JDN and then translate the result backward
	// in time by the period of adjustment.
	if Y < -5498 || (Y == -5498 && (M < 8 || (M == 8 && D < 16))) {
		// 30 years = 10,631 days (19 years of 354 days and 11 leap years of 355 days)
		let periods = (-5498 - Y) / 30 + 1
		let mappedY = Y + periods * 30
		let mappedJ = islamicCalendarDateToJulianDayNumber(year: mappedY, month: M, day: D)
		return mappedJ - periods * 10631
	}

	let h = M - m
	let g = Y + y - (n - h) / n
	let f = (h - 1 + n) % n
	let e = (p * g + q) / r + D - 1 - j
	let J = e + (s * f + t) / u

	return J
}

/// The earliest supported JDN using the Islamic calendar.
///
/// This JDN corresponds to -9999-01-01 12:00:00 in the Islamic calendar
let earliestSupportedIslamicCalendarJDN = -1595227

/// The latest supported JDN using the Islamic calendar.
///
/// This JDN corresponds to 99999-12-29 12:00:00 in the Islamic calendar
let latestSupportedIslamicCalendarJDN = 37384751

/// Converts the Julian day number `J` to a date in the Islamic calendar.
///
/// - parameter J: A Julian day number between `-1595227` and `37384751`.
///
/// - returns: The calendar date corresponding to `J`.
public func julianDayNumberToIslamicCalendarDate(_ J: Int) -> (year: Int, month: Int, day: Int) {
	// Richards' algorithm is only valid for positive JDNs.
	// Adjust negative JDNs forward in time by a multiple of
	// 30 years (to account for leap years in the Islamic calendar)
	// before calculating the proleptic Islamic date and then translate
	// the result backward in time by the amount of forward adjustment.
	if J < 0 {
		// 30 years = 10,631 days (19 years of 354 days and 11 leap years of 355 days)
		let periods = -J / 10631 + 1
		let mappedJ = J + periods * 10631
		let mappedYMD = julianDayNumberToIslamicCalendarDate(mappedJ)
		return (mappedYMD.year - periods * 30, mappedYMD.month, mappedYMD.day)
	}

	let f = J + j
	let e = r * f + v
	let g = (e % p) / r
	let h = u * g + w
	let D = (h % s) / u + 1
	let M = ((h / s + m) % n) + 1
	let Y = e / p - y + (n + m - M) / n

	return (Y, M, D)
}

// Constants for Islamic calendar conversions
private let y = 5519
private let j = 7664
private let m = 0
private let n = 12
private let r = 30
private let p = 10631
private let q = 14
private let v = 15
private let u = 100
private let s = 2951
private let t = 51
private let w = 10
