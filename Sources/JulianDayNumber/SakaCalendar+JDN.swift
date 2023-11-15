//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

// Algorithm from the Explanatory Supplement to the Astronomical Almanac, 3rd edition, S.E Urban and P.K. Seidelmann eds., (Mill Valley, CA: University Science Books), Chapter 15, pp. 585-624.

extension SakaCalendar: JulianDayNumberConverting {
	/// A date in the Śaka calendar consists of a year, month, and day.
	public typealias DateType = (year: Int, month: Int, day: Int)

	/// The intercalating cycle of the Śaka calendar is 303 common years of 365 days and 97 leap years of 366 days.
	static let intercalatingCycle = (years: 400, days: 146097)

	/// The date for Julian day number zero in the proleptic Śaka calendar.
	static let julianDayNumberZero = (year: -4791, month: 9, day: 3)

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		var Y = date.year
		var ΔcalendarCycles = 0

		if date < julianDayNumberZero {
			ΔcalendarCycles = (julianDayNumberZero.year - Y - 1) / intercalatingCycle.years + 1
			Y += ΔcalendarCycles * intercalatingCycle.years
		}

		let h = date.month - m
		let g = Y + y - (n - h) / n
		let f = (h - 1 + n) % n
		let e = (p * g + q) / r + date.day - 1 - j
		let Z = f / 6
		var J = e + ((31 - Z) * f + 5 * Z) / u
		J = J - (3 * ((g + A) / 100)) / 4 - C

		if ΔcalendarCycles > 0 {
			J -= ΔcalendarCycles * intercalatingCycle.days
		}

		return J
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		var J = J
		var ΔcalendarCycles = 0

		// Richards' algorithm is only valid for positive JDNs.
		if J < 0 {
			ΔcalendarCycles = -J / intercalatingCycle.days + 1
			J += ΔcalendarCycles * intercalatingCycle.days
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
			Y -= ΔcalendarCycles * intercalatingCycle.years
		}

		return (Y, M, D)
	}

	// Constants for Śaka calendar conversions
	static let y = 4794
	static let j = 1348
	static let m = 1
	static let n = 12
	static let r = 4
	static let p = 1461
	static let q = 0
	static let v = 3
	static let u = 1
	static let s = 31
	static let t = 0
	static let w = 0
	static let A = 184
	static let B = 274073
	static let C = -36
}
