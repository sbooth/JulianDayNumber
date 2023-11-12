//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

// Algorithm from the Explanatory Supplement to the Astronomical Almanac, 3rd edition, S.E Urban and P.K. Seidelmann eds., (Mill Valley, CA: University Science Books), Chapter 15, pp. 585-624.

/// The number of years in a cycle of the Gregorian calendar.
///
/// A cycle in the Gregorian calendar consists of 303 common years and 97 leap years.
let gregorianCalendarCycleYears = 400

/// The number of days in a cycle of the Gregorian calendar.
///
/// A cycle in the Gregorian calendar consists of 303 years of 365 days and 97 leap year of 366 days.
let gregorianCalendarCycleDays = 146097

extension GregorianCalendar: JulianDayNumberConverting {
	/// A date in the Gregorian calendar consists of a year, month, and day.
	public typealias DateType = JulianCalendar.DateType

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		var Y = date.year
		var ΔcalendarCycles = 0

		// JDN 0 is -4713-11-24 in the proleptic Gregorian calendar.
		if date < (-4713, 11, 24) {
			ΔcalendarCycles = (-4714 - Y) / gregorianCalendarCycleYears + 1
			Y += ΔcalendarCycles * gregorianCalendarCycleYears
		}

		let h = date.month - m
		let g = Y + y - (n - h) / n
		let f = (h - 1 + n) % n
		let e = (p * g + q) / r + date.day - 1 - j
		var J = e + (s * f + t) / u
		J = J - (3 * ((g + A) / 100)) / 4 - C

		if ΔcalendarCycles > 0 {
			J -= ΔcalendarCycles * gregorianCalendarCycleDays
		}

		return J
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		var J = J
		var ΔcalendarCycles = 0

		// Richards' algorithm is only valid for positive JDNs.
		if J < 0 {
			ΔcalendarCycles = -J / gregorianCalendarCycleDays + 1
			J += ΔcalendarCycles * gregorianCalendarCycleDays
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
			Y -= ΔcalendarCycles * gregorianCalendarCycleYears
		}

		return (Y, M, D)
	}
}

// Constants for Gregorian calendar conversions
private let y = 4716
private let j = 1401
private let m = 2
private let n = 12
private let r = 4
private let p = 1461
private let q = 0
private let v = 3
private let u = 5
private let s = 153
private let t = 2
private let w = 2
private let A = 184
private let B = 274277
private let C = -38
