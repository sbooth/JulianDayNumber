//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// The number of years in a cycle of the Syrian calendar.
///
/// A cycle in the Syrian calendar consists of 3 common years and 1 leap year.
let syrianCalendarCycleYears = 4

/// The number of days in a cycle of the Syrian calendar.
///
/// A cycle in the Syrian calendar consists of 3 years of 365 days and 1 leap year of 366 days.
let syrianCalendarCycleDays = 1461

extension SyrianCalendar: JulianDayNumberConverting {
	/// A date in the Syrian calendar consists of a year, month, and day.
	public typealias DateType = (year: Year, month: Month, day: Day)

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		var Y = date.year
		var ΔcalendarCycles = 0

		// JDN 0 is -4720-05-05 in the Syrian calendar.
		if date < (-4720, 5, 5) {
			ΔcalendarCycles = (-4721 - Y) / syrianCalendarCycleYears + 1
			Y += ΔcalendarCycles * syrianCalendarCycleYears
		}

		let h = date.month - m
		let g = Y + y - (n - h) / n
		let f = (h - 1 + n) % n
		let e = (p * g + q) / r + date.day - 1 - j
		var J = e + (s * f + t) / u

		if ΔcalendarCycles > 0 {
			J -= ΔcalendarCycles * syrianCalendarCycleDays
		}

		return J
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		var J = J
		var ΔcalendarCycles = 0

		// Richards' algorithm is only valid for positive JDNs.
		if J < 0 {
			ΔcalendarCycles = -J / syrianCalendarCycleDays + 1
			J += ΔcalendarCycles * syrianCalendarCycleDays
		}

		let f = J + j
		let e = r * f + v
		let g = (e % p) / r
		let h = u * g + w
		let D = (h % s) / u + 1
		let M = ((h / s + m) % n) + 1
		var Y = e / p - y + (n + m - M) / n

		if ΔcalendarCycles > 0 {
			Y -= ΔcalendarCycles * syrianCalendarCycleYears
		}

		return (Y, M, D)
	}
}

// Constants for Syrian calendar conversions
private let y = 4405
private let j = 1401
private let m = 5
private let n = 12
private let r = 4
private let p = 1461
private let q = 0
private let v = 3
private let u = 5
private let s = 153
private let t = 2
private let w = 2
