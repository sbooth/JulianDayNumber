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
	/// A date in the Egyptian calendar consists of a year, month, and day.
	public typealias DateType = (year: Year, month: Month, day: Day)

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		var Y = date.year
		var ΔcalendarCycles = 0

		// JDN 0 is -3968-02-18 in the Egyptian calendar.
		if date < (-3968, 2, 18) {
			ΔcalendarCycles = (-3969 - Y) / egyptianCalendarCycleYears + 1
			Y += ΔcalendarCycles * egyptianCalendarCycleYears
		}

		let h = date.month - m
		let g = Y + y - (n - h) / n
		let f = (h - 1 + n) % n
		let e = (p * g + q) / r + date.day - 1 - j
		var J = e + (s * f + t) / u

		if ΔcalendarCycles > 0 {
			J -= ΔcalendarCycles * egyptianCalendarCycleDays
		}

		return J
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		var J = J
		var ΔcalendarCycles = 0

		// Richards' algorithm is only valid for positive JDNs.
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
