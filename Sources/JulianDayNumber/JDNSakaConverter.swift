//
// Copyright © 2021-2024 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

/// A converter implementing algorithms for interconverting a Julian day number and a year, month, and day in the Śaka calendar.
///
/// The algorithms are adapted from Richards, E.G. 2012, "[Calendars](https://aa.usno.navy.mil/downloads/c15_usb_online.pdf),"
/// from the *Explanatory Supplement to the Astronomical Almanac, 3rd edition*, S.E Urban and P.K. Seidelmann eds., (Mill Valley, CA: University Science Books), 
/// Chapter 15, pp. 585-624.
struct JDNSakaConverter {
	/// The number of years in the computational calendar which precede the epoch.
	let y = 4794
	/// The number of days the epoch of the computational calendar (0/0/0) precedes day zero.
	let j = 1348
	/// The month number which corresponds to month zero in the computational calendar.
	let m = 1
	/// The number of months in a year, counting any epagonomai as an extra month.
	let n = 12
	/// The number of years in an intercalation cycle.
	let r = 4
	/// The number of days in an intercalation cycle.
	let p = 1461
	let q = 0
	let v = 3
	let u = 1
	let s = 31
	let t = 0
	let w = 0

	let A = 184
	let B = 274073
	let C = -36

	/// Converts a date in the Śaka calendar to a Julian day number and returns the result.
	///
	/// - important: No validation checks are performed on the date values.
	///
	/// - parameter date: A date to convert.
	///
	/// - returns: The Julian day number corresponding to the specified date.
	func julianDayNumberFromDate(_ date: Calendar.YearMonthDay) -> JulianDayNumber {
		var Y = date.year
		var ΔcalendarCycles = 0

		if Y <= -y {
			ΔcalendarCycles = (-y - Y) / gregorianIntercalatingCycle.years + 1
			Y += ΔcalendarCycles * gregorianIntercalatingCycle.years
		}

		let h = date.month - m
		let g = Y + y - (n - h) / n
		let f = (h - 1 + n) % n
		let e = (p * g + q) / r + date.day - 1 - j
		let Z = f / 6
		var J = e + ((31 - Z) * f + 5 * Z) / u
		J = J - (3 * ((g + A) / 100)) / 4 - C

		if ΔcalendarCycles > 0 {
			J -= ΔcalendarCycles * gregorianIntercalatingCycle.days
		}

		return J
	}

	/// Converts a Julian day number to a date in the Śaka calendar and returns the result.
	///
	/// - parameter J: A Julian day number.
	///
	/// - returns: The date corresponding to the specified Julian day number.
	func dateFromJulianDayNumber(_ J: JulianDayNumber) -> Calendar.YearMonthDay {
		var J = J
		var ΔcalendarCycles = 0

		// Richards' algorithm is only valid for positive JDNs.
		if J < 0 {
			ΔcalendarCycles = -(J / gregorianIntercalatingCycle.days) + 1
			precondition(ΔcalendarCycles <= Int.max / gregorianIntercalatingCycle.days, "Julian day number too small")
			J += ΔcalendarCycles * gregorianIntercalatingCycle.days
		}

		precondition(J <= Int.max - j, "Julian day number too large")

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
			Y -= ΔcalendarCycles * gregorianIntercalatingCycle.years
		}

		return (Y, M, D)
	}
}
