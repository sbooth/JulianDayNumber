//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// The number of years in a cycle of the Armenian calendar.
///
/// A cycle in the Armenian calendar consists of 1 year.
let armenianCalendarCycleYears = 1

/// The number of days in a cycle of the Armenian calendar.
///
/// A cycle in the Armenian calendar consists of 1 year of 365 days.
let armenianCalendarCycleDays = 365

extension ArmenianCalendar: JulianDayNumberConverting {
	/// A date in the Armenian calendar consists of a year, month, and day.
	public typealias DateType = (year: Year, month: Month, day: Day)

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		var Y = date.year
		var ΔcalendarCycles = 0

		// JDN 0 is -5268-11-18 in the proleptic Armenian calendar.
		if date < (-5268, 11, 18) {
			ΔcalendarCycles = (-5269 - Y) / armenianCalendarCycleYears + 1
			Y += ΔcalendarCycles * armenianCalendarCycleYears
		}

		let h = date.month - m
		let g = Y + y - (n - h) / n
		let f = (h - 1 + n) % n
		let e = (p * g + q) / r + date.day - 1 - j
		var J = e + (s * f + t) / u

		if ΔcalendarCycles > 0 {
			J -= ΔcalendarCycles * armenianCalendarCycleDays
		}

		return J
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		var J = J
		var ΔcalendarCycles = 0

		if J < 0 {
			ΔcalendarCycles = -J / armenianCalendarCycleDays + 1
			J += ΔcalendarCycles * armenianCalendarCycleDays
		}

		let f = J + j
		let e = r * f + v
		let g = (e % p) / r
		let h = u * g + w
		let D = (h % s) / u + 1
		let M = ((h / s + m) % n) + 1
		var Y = e / p - y + (n + m - M) / n

		if ΔcalendarCycles > 0 {
			Y -= ΔcalendarCycles * armenianCalendarCycleYears
		}

		return (Y, M, D)
	}
}

// Constants for Armenian calendar conversions
private let y = 5268
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
