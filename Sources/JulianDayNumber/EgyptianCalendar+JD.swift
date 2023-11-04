//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

// Algorithm from the Explanatory Supplement to the Astronomical Almanac, 3rd edition, S.E Urban and P.K. Seidelmann eds., (Mill Valley, CA: University Science Books), Chapter 15, pp. 585-624.

/// The number of years in a cycle of the Egyptian calendar.
///
/// A cycle in the Egyptian calendar consists of 1 year.
let egyptianCalendarCycleYears = 1

/// The number of days in a cycle of the Egyptian calendar.
///
/// A cycle in the Egyptian calendar consists of 1 year of 365 days.
let egyptianCalendarCycleDays = 365

extension EgyptianCalendar: JulianDayNumberConverting {
	/// Converts a year, month, and day in the Egyptian calendar to a Julian day number.
	///
	/// - note: No validation checks are performed on the date values.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number between `1` (Thoth) and `12` (Mesori). The five epagomenal days are treated as month `13`.
	/// - parameter D: A day number between `1` and the maximum number of days in month `M` for year `Y`.
	///
	/// - returns: The Julian day number corresponding to the specified year, month, and day.
	public static func dateToJulianDayNumber(year Y: Int, month M: Int, day D: Int) -> JulianDayNumber {
		var Y = Y
		var ΔcalendarCycles = 0

		// Richards' algorithm is only valid for positive JDNs.
		// JDN 0 is -3968-02-18 in the Egyptian calendar.
		// Adjust the year of earlier dates forward in time by a multiple of
		// the calendar's cycle before calculating the JDN, and then translate
		// the result backward in time by the period of adjustment.
		if Y < -3968 || (Y == -3968 && (M < 2 || (M == 2 && D < 18))) {
			ΔcalendarCycles = (-3969 - Y) / egyptianCalendarCycleYears + 1
			Y += ΔcalendarCycles * egyptianCalendarCycleYears
		}

		let h = M - m
		let g = Y + y - (n - h) / n
		let f = (h - 1 + n) % n
		let e = (p * g + q) / r + D - 1 - j
		var J = e + (s * f + t) / u

		if ΔcalendarCycles > 0 {
			J -= ΔcalendarCycles * egyptianCalendarCycleDays
		}

		return J
	}

	/// Converts a Julian day number to a year, month, and day in the Egyptian calendar.
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
			ΔcalendarCycles = -J / egyptianCalendarCycleDays + 1
			J += ΔcalendarCycles * egyptianCalendarCycleDays
		}

		let f = J + j
		let e = r * f + v
		let g = (e % p) / r
		let h = u * g + w
		let D = (h % s) / u + 1
		let M = ((h / s + m) % n) + 1
		var Y = e / p - y + (n + m - M) / n

		if ΔcalendarCycles > 0 {
			Y -= ΔcalendarCycles * egyptianCalendarCycleYears
		}

		return (Y, M, D)
	}
}

// Constants for Egyptian calendar conversions
private let y = 3968
private let j = 47
private let m = 0
private let n = 13
private let r = 1
private let p = 365
private let q = 0
private let v = 0
private let u = 1
private let s = 30
private let t = 0
private let w = 0
