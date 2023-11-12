//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

// Algorithm from the Explanatory Supplement to the Astronomical Almanac, 3rd edition, S.E Urban and P.K. Seidelmann eds., (Mill Valley, CA: University Science Books), Chapter 15, pp. 585-624.

/// The number of years in a cycle of the Śaka calendar.
///
/// A cycle in the Śaka calendar consists of 303 common years and 97 leap years.
let sakaCalendarCycleYears = 400

/// The number of days in a cycle of the Śaka calendar.
///
/// A cycle in the Gregorian calendar consists of 303 years of 365 days and 97 leap year of 366 days.
let sakaCalendarCycleDays = 146097

extension SakaCalendar: JulianDayNumberConverting {
	/// A date in the Śaka calendar consists of a year, month, and day.
	public typealias DateType = (year: Int, month: Int, day: Int)

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		var Y = date.year
		var ΔcalendarCycles = 0

		// JDN 0 is -4791-09-03 in the proleptic Śaka calendar.
		if date < (-4791, 9, 3) {
			ΔcalendarCycles = (-4792 - Y) / sakaCalendarCycleYears + 1
			Y += ΔcalendarCycles * sakaCalendarCycleYears
		}

		let h = date.month - m
		let g = Y + y - (n - h) / n
		let f = (h - 1 + n) % n
		let e = (p * g + q) / r + date.day - 1 - j
		let Z = f / 6
		var J = e + ((31 - Z) * f + 5 * Z) / u
		J = J - (3 * ((g + A) / 100)) / 4 - C

		if ΔcalendarCycles > 0 {
			J -= ΔcalendarCycles * sakaCalendarCycleDays
		}

		return J
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		var J = J
		var ΔcalendarCycles = 0

		// Richards' algorithm is only valid for positive JDNs.
		if J < 0 {
			ΔcalendarCycles = -J / sakaCalendarCycleDays + 1
			J += ΔcalendarCycles * sakaCalendarCycleDays
		}

		var f = J + j
		f = f + (((4 * J + B) / 146097) * 3) / 4 + C
		let e = r * f + v
		let g = (e % p) / r
		let X = g / 365
		let Z = g / 185 - X
		let s = 31 - Z
		let w = -5 * Z
		let h = u * g + w
		let D = (6 * X + (h % s)) / u + 1

		let M = ((h / s + m) % n) + 1
		var Y = e / p - y + (n + m - M) / n

		if ΔcalendarCycles > 0 {
			Y -= ΔcalendarCycles * sakaCalendarCycleYears
		}

		return (Y, M, D)
	}
}

// Constants for Śaka calendar conversions
private let y = 4794
private let j = 1348
private let m = 1
private let n = 12
private let r = 4
private let p = 1461
private let q = 0
private let v = 3
private let u = 1
private let s = 31
private let t = 0
private let w = 0
private let A = 184
private let B = 274073
private let C = -36
