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
	/// A date in the Islamic calendar consists of a year, month, and day.
	public typealias DateType = (year: Year, month: Month, day: Day)

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		var Y = date.year
		var ΔcalendarCycles = 0

		// JDN 0 is -5498-08-16 in the proleptic Islamic calendar.
		if date < (-5498, 8, 16) {
			ΔcalendarCycles = (-5498 - Y) / islamicCalendarCycleYears + 1
			Y += ΔcalendarCycles * islamicCalendarCycleYears
		}

		let h = date.month - m
		let g = Y + y - (n - h) / n
		let f = (h - 1 + n) % n
		let e = (p * g + q) / r + date.day - 1 - j
		var J = e + (s * f + t) / u

		if ΔcalendarCycles > 0 {
			J -= ΔcalendarCycles * islamicCalendarCycleDays
		}

		return J
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		var J = J
		var ΔcalendarCycles = 0

		// Richards' algorithm is only valid for positive JDNs.
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
