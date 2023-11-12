//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

// Algorithm from the Explanatory Supplement to the Astronomical Almanac, 3rd edition, S.E Urban and P.K. Seidelmann eds., (Mill Valley, CA: University Science Books), Chapter 15, pp. 585-624.

/// The number of years in a cycle of the French Republican calendar.
///
/// A cycle in the modified French Republican calendar consists of 303 common years and 97 leap years.
let frenchRepublicanCalendarCycleYears = 400

/// The number of days in a cycle of the French Republican calendar.
///
/// A cycle in the modified French Republican calendar consists of 303 years of 365 days and 97 leap year of 366 days.
let frenchRepublicanCalendarCycleDays = 146097

extension FrenchRepublicanCalendar: JulianDayNumberConverting {
	/// Converts a year, month, and day in the French Republican calendar to a Julian day number.
	///
	/// - note: No validation checks are performed on the date values.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number between `1` (Vendémiaire) and `12` (Fructidor). The epagomenal days (Sansculottides) are treated as month `13`.
	/// - parameter D: A day number between `1` and the maximum number of days in month `M` for year `Y`.
	///
	/// - returns: The Julian day number corresponding to the specified year, month, and day.
	public static func julianDayNumberFrom(year Y: Int, month M: Int, day D: Int) -> JulianDayNumber {
		var Y = Y
		var ΔcalendarCycles = 0

		// Richards' algorithm is only valid for positive JDNs.
		// JDN 0 is -6504-Frimaire(03)-03 in the proleptic French Republican calendar.
		// Adjust the year of earlier dates forward in time by a multiple of
		// the calendar's cycle before calculating the JDN, and then translate
		// the result backward in time by the period of adjustment.
		if Y < -6504 || (Y == -6504 && (M < 3 || (M == 3 && D < 3))) {
			ΔcalendarCycles = (-6505 - Y) / frenchRepublicanCalendarCycleYears + 1
			Y += ΔcalendarCycles * frenchRepublicanCalendarCycleYears
		}

		let h = M - m
		let g = Y + y - (n - h) / n
		let f = (h - 1 + n) % n
		let e = (p * g + q) / r + D - 1 - j
		var J = e + (s * f + t) / u
		J = J - (3 * ((g + A) / 100)) / 4 - C

		if ΔcalendarCycles > 0 {
			J -= ΔcalendarCycles * frenchRepublicanCalendarCycleDays
		}

		return J
	}

	/// Converts a Julian day number to a year, month, and day in the French Republican calendar.
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
			ΔcalendarCycles = -J / frenchRepublicanCalendarCycleDays + 1
			J += ΔcalendarCycles * frenchRepublicanCalendarCycleDays
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
			Y -= ΔcalendarCycles * frenchRepublicanCalendarCycleYears
		}

		return (Y, M, D)
	}
}

// Constants for French Republican calendar conversions
private let y = 6504
private let j = 111
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
private let A = 396
private let B = 578797
private let C = -51
