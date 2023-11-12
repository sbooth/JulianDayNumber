//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

// Algorithm from the Explanatory Supplement to the Astronomical Almanac, 3rd edition, S.E Urban and P.K. Seidelmann eds., (Mill Valley, CA: University Science Books), Chapter 15, pp. 585-624.

/// The number of years in a cycle of the Baháʼí calendar.
///
/// A cycle in the Baháʼí calendar consists of 303 common years and 97 leap years.
let bahaiCalendarCycleYears = 400

/// The number of days in a cycle of the Baháʼí calendar.
///
/// A cycle in the Baháʼí calendar consists of 303 years of 365 days and 97 leap year of 366 days.
let bahaiCalendarCycleDays = 146097

extension BahaiCalendar: JulianDayNumberConverting {
	/// A date in the Baháʼí calendar consists of a year, month, and day.
	public typealias DateType = (year: Year, month: Month, day: Day)

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		var Y = date.year
		var ΔcalendarCycles = 0

		// JDN 0 is -6556-14-02 in the proleptic Baháʼí calendar.
		if date < (-6556, 14, 2) {
			ΔcalendarCycles = (-6557 - Y) / bahaiCalendarCycleYears + 1
			Y += ΔcalendarCycles * bahaiCalendarCycleYears
		}

		let h = date.month - m
		let g = Y + y - (n - h) / n
		let f = (h - 1 + n) % n
		let e = (p * g + q) / r + date.day - 1 - j
		var J = e + (s * f + t) / u
		J = J - (3 * ((g + A) / 100)) / 4 - C

		if ΔcalendarCycles > 0 {
			J -= ΔcalendarCycles * bahaiCalendarCycleDays
		}

		return J
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		var J = J
		var ΔcalendarCycles = 0

		// Richards' algorithm is only valid for positive JDNs.
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
