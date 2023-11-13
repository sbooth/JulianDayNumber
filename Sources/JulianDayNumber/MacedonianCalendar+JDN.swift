//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// The number of years in a cycle of the Macedonian calendar.
///
/// A cycle in the Macedonian calendar consists of 3 common years and 1 leap year.
let macedonianCalendarCycleYears = 4

/// The number of days in a cycle of the Macedonian calendar.
///
/// A cycle in the Macedonian calendar consists of 3 years of 365 days and 1 leap year of 366 days.
let macedonianCalendarCycleDays = 1461

extension MacedonianCalendar: JulianDayNumberConverting {
	/// A date in the Macedonian calendar consists of a year, month, and day.
	public typealias DateType = (year: Year, month: Month, day: Day)

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		var Y = date.year
		var ΔcalendarCycles = 0

		// JDN 0 is -4401-05-01 in the Macedonian calendar.
		if date < (-4401, 5, 1) {
			ΔcalendarCycles = (-4402 - Y) / macedonianCalendarCycleYears + 1
			Y += ΔcalendarCycles * macedonianCalendarCycleYears
		}

		let h = date.month - m
		let g = Y + y - (n - h) / n
		let f = (h - 1 + n) % n
		let e = (p * g + q) / r + date.day - 1 - j
		var J = e + (s * f + t) / u

		if ΔcalendarCycles > 0 {
			J -= ΔcalendarCycles * macedonianCalendarCycleDays
		}

		return J
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		var J = J
		var ΔcalendarCycles = 0

		// Richards' algorithm is only valid for positive JDNs.
		if J < 0 {
			ΔcalendarCycles = -J / macedonianCalendarCycleDays + 1
			J += ΔcalendarCycles * macedonianCalendarCycleDays
		}

		let f = J + j
		let e = r * f + v
		let g = (e % p) / r
		let h = u * g + w
		let D = (h % s) / u + 1
		let M = ((h / s + m) % n) + 1
		var Y = e / p - y + (n + m - M) / n

		if ΔcalendarCycles > 0 {
			Y -= ΔcalendarCycles * macedonianCalendarCycleYears
		}

		return (Y, M, D)
	}
}

// Constants for Macedonian calendar conversions
private let y = 4405
private let j = 1401
private let m = 6
private let n = 12
private let r = 4
private let p = 1461
private let q = 0
private let v = 3
private let u = 5
private let s = 153
private let t = 2
private let w = 2
