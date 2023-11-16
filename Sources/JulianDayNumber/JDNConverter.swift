//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// A converter implementing algorithms for interconverting a Julian day number and a year, month, and day for selected arithmetic calendars.
///
/// The algorithms are adapted from Richards, E.G. 2012, "[Calendars](https://aa.usno.navy.mil/downloads/c15_usb_online.pdf),"
/// from the *Explanatory Supplement to the Astronomical Almanac, 3rd edition*, S.E Urban and P.K. Seidelmann eds., (Mill Valley, CA: University Science Books),
/// Chapter 15, pp. 585-624.
struct JDNConverter {
	/// A date consisting of a year, month, and day.
	typealias YearMonthDay = (year: Int, month: Int, day: Int)

	/// The number of years in the computational calendar which precede the epoch.
	let y: Int
	/// The number of days the epoch of the computational calendar (0/0/0) precedes day zero.
	let j: Int
	/// The month number which corresponds to month zero in the computational calendar.
	let m: Int
	/// The number of months in a year, counting any epagonomai as an extra month.
	let n: Int
	/// The number of years in an intercalation cycle.
	let r: Int
	/// The number of days in an intercalation cycle.
	let p: Int
	let q: Int
	let v: Int
	let u: Int
	let s: Int
	let t: Int
	let w: Int

	/// Converts a date to a Julian day numberand returns the result.
	///
	/// - important: No validation checks are performed on the date values.
	///
	/// - parameter date: A date to convert.
	///
	/// - returns: The Julian day number corresponding to the specified date.
	func julianDayNumberFromDate(_ date: YearMonthDay) -> JulianDayNumber {
		var Y = date.year
		var ΔcalendarCycles = 0

		if Y <= -y {
			ΔcalendarCycles = (-y - Y) / r + 1
			Y += ΔcalendarCycles * r
		}

		let h = date.month - m
		let g = Y + y - (n - h) / n
		let f = (h - 1 + n) % n
		let e = (p * g + q) / r + date.day - 1 - j
		var J = e + (s * f + t) / u

		if ΔcalendarCycles > 0 {
			J -= ΔcalendarCycles * p
		}

		return J
	}

	/// Converts a Julian day number to a date and returns the result.
	///
	/// - parameter J: A Julian day number.
	///
	/// - returns: The date corresponding to the specified Julian day number.
	func dateFromJulianDayNumber(_ J: JulianDayNumber) -> YearMonthDay {
//	precondition(J < Int.max - 1)

		var J = J
		var ΔcalendarCycles = 0

		// Richards' algorithm is only valid for positive JDNs.
		if J < 0 {
			ΔcalendarCycles = -J / p + 1
			J += ΔcalendarCycles * p
		}

		precondition(J <= Int.max - j, "Julian day number too large")

		let f = J + j
		let e = r * f + v
		let g = (e % p) / r
		let h = u * g + w
		let D = (h % s) / u + 1
		let M = ((h / s + m) % n) + 1
		var Y = e / p - y + (n + m - M) / n

		if ΔcalendarCycles > 0 {
			Y -= ΔcalendarCycles * r
		}

		return (Y, M, D)
	}
}
