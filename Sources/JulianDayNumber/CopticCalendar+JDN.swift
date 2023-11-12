//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

// Algorithm from the Explanatory Supplement to the Astronomical Almanac, 3rd edition, S.E Urban and P.K. Seidelmann eds., (Mill Valley, CA: University Science Books), Chapter 15, pp. 585-624.

/// The number of years in a cycle of the Coptic calendar.
///
/// A cycle in the Coptic calendar consists of 3 common years and 1 leap year.
let copticCalendarCycleYears = 4

/// The number of days in a cycle of the Coptic calendar.
///
/// A cycle in the Coptic calendar consists of 3 years of 365 days and 1 leap year of 366 days.
let copticCalendarCycleDays = 1461

extension CopticCalendar: JulianDayNumberConverting {
	/// Converts a year, month, and day in the Coptic calendar to a Julian day number.
	///
	/// - note: No validation checks are performed on the date values.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number between `1` (Tut) and `13` (Nissieh).
	/// - parameter D: A day number between `1` and the maximum number of days in month `M` for year `Y`.
	///
	/// - returns: The Julian day number corresponding to the specified year, month, and day.
	public static func julianDayNumberFrom(year Y: Int, month M: Int, day D: Int) -> JulianDayNumber {
		var Y = Y
		var ΔcalendarCycles = 0

		// Richards' algorithm is only valid for positive JDNs.
		// JDN 0 is -4996-05-05 in the Coptic calendar.
		// Adjust the year of earlier dates forward in time by a multiple of
		// the calendar's cycle before calculating the JDN, and then translate
		// the result backward in time by the period of adjustment.
		if Y < -4996 || (Y == -4996 && (M < 5 || (M == 5 && D < 5))) {
			ΔcalendarCycles = (-4997 - Y) / copticCalendarCycleYears + 1
			Y += ΔcalendarCycles * copticCalendarCycleYears
		}

		let h = M - m
		let g = Y + y - (n - h) / n
		let f = (h - 1 + n) % n
		let e = (p * g + q) / r + D - 1 - j
		var J = e + (s * f + t) / u

		if ΔcalendarCycles > 0 {
			J -= ΔcalendarCycles * copticCalendarCycleDays
		}

		return J
	}

	/// Converts a Julian day number to a year, month, and day in the Coptic calendar.
	///
	/// - parameter J: A Julian day number.
	///
	/// - returns: The year, month, and day corresponding to the specified Julian day number.
	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> (year: Int, month: Int, day: Int) {
		var J = J
		var ΔcalendarCycles = 0

		// Richards' algorithm is only valid for positive JDNs.
		// Adjust negative JDNs forward in time by a multiple of
		// the calendar's cycle before calculating the JDN, and then translate
		// the result backward in time by the period of adjustment.
		if J < 0 {
			ΔcalendarCycles = -J / copticCalendarCycleDays + 1
			J += ΔcalendarCycles * copticCalendarCycleDays
		}

		let f = J + j
		let e = r * f + v
		let g = (e % p) / r
		let h = u * g + w
		let D = (h % s) / u + 1
		let M = ((h / s + m) % n) + 1
		var Y = e / p - y + (n + m - M) / n

		if ΔcalendarCycles > 0 {
			Y -= ΔcalendarCycles * copticCalendarCycleYears
		}

		return (Y, M, D)
	}
}

// Constants for Coptic calendar conversions
private let y = 4996
private let j = 124
private let m = 0
private let n = 13
private let r = 4
private let p = 1461
private let q = 0
private let v = 3
private let u = 1
private let s = 30
private let t = 0
private let w = 0
