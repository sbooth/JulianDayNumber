//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// The number of years in a cycle of the Khwarizmian calendar.
///
/// A cycle in the Khwarizmian calendar consists of 1 year.
let khwarizmianCalendarCycleYears = 1

/// The number of days in a cycle of the Khwarizmian calendar.
///
/// A cycle in the Khwarizmian calendar consists of 1 year of 365 days.
let khwarizmianCalendarCycleDays = 365

extension KhwarizmianCalendar: JulianDayNumberConverting {
	/// A date in the Khwarizmian calendar consists of a year, month, and day.
	public typealias DateType = (year: Year, month: Month, day: Day)

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		var Y = date.year
		var ΔcalendarCycles = 0

		// JDN 0 is -5348-11-18 in the proleptic Khwarizmian calendar.
		if date < (-5348, 11, 18) {
			ΔcalendarCycles = (-5349 - Y) / khwarizmianCalendarCycleYears + 1
			Y += ΔcalendarCycles * khwarizmianCalendarCycleYears
		}

		let h = date.month - m
		let g = Y + y - (n - h) / n
		let f = (h - 1 + n) % n
		let e = (p * g + q) / r + date.day - 1 - j
		var J = e + (s * f + t) / u

		if ΔcalendarCycles > 0 {
			J -= ΔcalendarCycles * khwarizmianCalendarCycleDays
		}

		return J
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		var J = J
		var ΔcalendarCycles = 0

		// Richards' algorithm is only valid for positive JDNs.
		if J < 0 {
			ΔcalendarCycles = -J / khwarizmianCalendarCycleDays + 1
			J += ΔcalendarCycles * khwarizmianCalendarCycleDays
		}

		let f = J + j
		let e = r * f + v
		let g = (e % p) / r
		let h = u * g + w
		let D = (h % s) / u + 1
		let M = ((h / s + m) % n) + 1
		var Y = e / p - y + (n + m - M) / n

		if ΔcalendarCycles > 0 {
			Y -= ΔcalendarCycles * khwarizmianCalendarCycleYears
		}

		return (Y, M, D)
	}
}

// Constants for Khwarizmian calendar conversions
private let y = 5348
private let j = 317
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
