//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

// Algorithm from the Explanatory Supplement to the Astronomical Almanac, 3rd edition, S.E Urban and P.K. Seidelmann eds., (Mill Valley, CA: University Science Books), Chapter 15, pp. 585-624.

/// The number of years in a cycle of the Baháʼí calendar.
///
/// A cycle in the Baháʼí calendar consists of 3 common years and 1 leap year.
let bahaiCalendarCycleYears = 4

/// The number of days in a cycle of the Baháʼí calendar.
///
/// A cycle in the Baháʼí calendar consists of 3 years of 365 days and 1 leap year of 366 days.
let bahaiCalendarCycleDays = 1461

extension BahaiCalendar: JulianDayNumberConverting {
	/// Converts a year, month, and day in the Baháʼí calendar to a Julian day number.
	///
	/// - note: No validation checks are performed on the date values.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number between `1` (Bahá) and `20` (ʻAláʼ). The epagomenal days (Ayyám-i-Há) are treated as month `19`.
	/// - parameter D: A day number between `1` and the maximum number of days in month `M` for year `Y`.
	///
	/// - returns: The Julian day number corresponding to the specified year, month, and day.
	public static func dateToJulianDayNumber(year Y: Int, month M: Int, day D: Int) -> JulianDayNumber {
		var Y = Y
		var ΔcalendarCycles = 0

		// Richards' algorithm is only valid for positive JDNs.
		// JDN 0 is -6556-14-02 in the proleptic Baháʼí calendar.
		// Adjust the year of earlier dates forward in time by a multiple of
		// the calendar's cycle before calculating the JDN, and then translate
		// the result backward in time by the period of adjustment.
		if Y < -6556 || (Y == -6556 && (M < 14 || (M == 14 && D < 2))) {
			ΔcalendarCycles = (-6557 - Y) / bahaiCalendarCycleYears + 1
			Y += ΔcalendarCycles * bahaiCalendarCycleYears
		}

		let h = M - m
		let g = Y + y - (n - h) / n
		let f = (h - 1 + n) % n
		let e = (p * g + q) / r + D - 1 - j
		var J = e + (s * f + t) / u
		J = J - (3 * ((g + A) / 100)) / 4 - C

		if ΔcalendarCycles > 0 {
			J -= ΔcalendarCycles * bahaiCalendarCycleDays
		}

		return J
	}

	/// Converts a Julian day number to a year, month, and day in the Baháʼí calendar.
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
			ΔcalendarCycles = -J / bahaiCalendarCycleDays + 1
			J += ΔcalendarCycles * bahaiCalendarCycleDays
		}

		var f = J + j
		f = f + (((4 * J + B) / 146097) * 3) / 4 + C
		let e = r * f + v
		let g = (e % p) / r
		let h = u * g + w
		let D = (h % s) / u + 1
		let M = ((h / s + m) % n) + 1
		var Y = e / p - y + (n + m - M) / n

		if ΔcalendarCycles > 0 {
			Y -= ΔcalendarCycles * bahaiCalendarCycleYears
		}

		return (Y, M, D)
	}
}

// Constants for Baháʼí calendar conversions
private let y = 6560
private let j = 1412
private let m = 19
private let n = 20
private let r = 4
private let p = 1461
private let q = 0
private let v = 3
private let u = 1
private let s = 19
private let t = 0
private let w = 0
private let A = 184
private let B = 274273
private let C = -50
