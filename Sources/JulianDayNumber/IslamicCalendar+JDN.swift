//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

// Algorithm from the Explanatory Supplement to the Astronomical Almanac, 3rd edition, S.E Urban and P.K. Seidelmann eds., (Mill Valley, CA: University Science Books), Chapter 15, pp. 585-624.

/// The number of years in a cycle of the Islamic calendar.
///
/// A cycle in the Islamic calendar consists of 19 common years and 11 leap years.
let islamicCalendarCycleYears = 30

/// The number of days in a cycle of the Islamic calendar.
///
/// A cycle in the Islamic calendar consists of 19 years of 354 days and 11 leap years of 355 days.
let islamicCalendarCycleDays = 10631

extension IslamicCalendar: JulianDayNumberConverting {
	/// Converts a year, month, and day in the Islamic calendar to a Julian day number.
	///
	/// - note: No validation checks are performed on the date values.
	///
	/// - parameter Y: A year number between `-9999` and `99999`.
	/// - parameter M: A month number between `1` (Muharram) and `12` (Dhú’l-Hijjab).
	/// - parameter D: A day number between `1` and the maximum number of days in month `M` for year `Y`.
	///
	/// - returns: The Julian day number corresponding to the specified year, month, and day.
	public static func dateToJulianDayNumber(year Y: Int, month M: Int, day D: Int) -> JulianDayNumber {
		var Y = Y
		var ΔcalendarCycles = 0

		// Richards' algorithm is only valid for positive JDNs.
		// JDN 0 is -5498-08-16 in the proleptic Islamic calendar.
		// Adjust the year of earlier dates forward in time by a multiple of
		// the calendar's cycle before calculating the JDN, and then translate
		// the result backward in time by the period of adjustment.
		if Y < -5498 || (Y == -5498 && (M < 8 || (M == 8 && D < 16))) {
			ΔcalendarCycles = (-5498 - Y) / islamicCalendarCycleYears + 1
			Y += ΔcalendarCycles * islamicCalendarCycleYears
		}

		let h = M - m
		let g = Y + y - (n - h) / n
		let f = (h - 1 + n) % n
		let e = (p * g + q) / r + D - 1 - j
		var J = e + (s * f + t) / u

		if ΔcalendarCycles > 0 {
			J -= ΔcalendarCycles * islamicCalendarCycleDays
		}

		return J
	}

	/// Converts a Julian day number to a year, month, and day in the Islamic calendar.
	///
	/// - parameter J: A Julian day number.
	///
	/// - returns: The year, month, and day corresponding to the specified Julian day number.
	public static func julianDayNumberToDate(_ J: JulianDayNumber) -> (year: Int, month: Int, day: Int) {
		var J = J
		var ΔcalendarCycles = 0

		// Richards' algorithm is only valid for positive JDNs.
		// Adjust negative JDNs forward in time by a multiple of
		// the calendar's cycle before calculating the JDN, and then translate
		// the result backward in time by the period of adjustment.
		if J < 0 {
			ΔcalendarCycles = -J / islamicCalendarCycleDays + 1
			J += ΔcalendarCycles * islamicCalendarCycleDays
		}

		let f = J + j
		let e = r * f + v
		let g = (e % p) / r
		let h = u * g + w
		let D = (h % s) / u + 1
		let M = ((h / s + m) % n) + 1
		var Y = e / p - y + (n + m - M) / n

		if ΔcalendarCycles > 0 {
			Y -= ΔcalendarCycles * islamicCalendarCycleYears
		}

		return (Y, M, D)
	}
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