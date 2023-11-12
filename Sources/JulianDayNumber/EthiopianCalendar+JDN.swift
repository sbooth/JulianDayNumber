//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

// Algorithm from the Explanatory Supplement to the Astronomical Almanac, 3rd edition, S.E Urban and P.K. Seidelmann eds., (Mill Valley, CA: University Science Books), Chapter 15, pp. 585-624.

/// The number of years in a cycle of the Ethiopian calendar.
///
/// A cycle in the Ethiopian calendar consists of 3 common years and 1 leap year.
let ethiopianCalendarCycleYears = 4

/// The number of days in a cycle of the Ethiopian calendar.
///
/// A cycle in the Ethiopian calendar consists of 3 years of 365 days and 1 leap year of 366 days.
let ethiopianCalendarCycleDays = 1461

extension EthiopianCalendar: JulianDayNumberConverting {
	/// A date in the Ethiopian calendar consists of a year, month, and day.
	public typealias DateType = (year: Year, month: Month, day: Day)

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		var Y = date.year
		var ΔcalendarCycles = 0

		// JDN 0 is -4720-05-05 in the Ethiopian calendar.
		if date < (-4720, 5, 5) {
			ΔcalendarCycles = (-4721 - Y) / ethiopianCalendarCycleYears + 1
			Y += ΔcalendarCycles * ethiopianCalendarCycleYears
		}

		let h = date.month - m
		let g = Y + y - (n - h) / n
		let f = (h - 1 + n) % n
		let e = (p * g + q) / r + date.day - 1 - j
		var J = e + (s * f + t) / u

		if ΔcalendarCycles > 0 {
			J -= ΔcalendarCycles * ethiopianCalendarCycleDays
		}

		return J
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		var J = J
		var ΔcalendarCycles = 0

		// Richards' algorithm is only valid for positive JDNs.
		if J < 0 {
			ΔcalendarCycles = -J / ethiopianCalendarCycleDays + 1
			J += ΔcalendarCycles * ethiopianCalendarCycleDays
		}

		let f = J + j
		let e = r * f + v
		let g = (e % p) / r
		let h = u * g + w
		let D = (h % s) / u + 1
		let M = ((h / s + m) % n) + 1
		var Y = e / p - y + (n + m - M) / n

		if ΔcalendarCycles > 0 {
			Y -= ΔcalendarCycles * ethiopianCalendarCycleYears
		}

		return (Y, M, D)
	}
}

// Constants for Ethiopian calendar conversions
private let y = 4720
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
