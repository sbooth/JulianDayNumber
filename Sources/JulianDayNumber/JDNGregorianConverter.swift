//
// SPDX-FileCopyrightText: 2021 Stephen F. Booth <contact@sbooth.dev>
// SPDX-License-Identifier: MIT
//
// Part of https://github.com/sbooth/JulianDayNumber
//

/// A converter implementing algorithms for interconverting a Julian day number and a year, month, and day in calendars using Gregorian-type intercalating.
///
/// The algorithms are adapted from Richards, E.G. 2012, "[Calendars](https://aa.usno.navy.mil/downloads/c15_usb_online.pdf),"
/// from the *Explanatory Supplement to the Astronomical Almanac, 3rd edition*, S.E Urban and P.K. Seidelmann eds., (Mill Valley, CA: University Science Books),
/// Chapter 15, pp. 585-624.
struct JDNGregorianConverter {
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

	let A: Int
	let B: Int
	let C: Int

	/// Converts a date to a Julian day number and returns the result.
	///
	/// - important: No validation checks are performed on the date values.
	///
	/// - parameter date: A date to convert.
	///
	/// - returns: The Julian day number corresponding to the specified date.
	///
	/// - throws: An error if the date could not be converted to a Julian Day Number.
	func julianDayNumberFromDate(_ date: Calendar.YearMonthDay) throws -> JulianDayNumber {
		// Arithmetic upper limit
		// `Y` values larger than this cause overflow when `e` is computed
		let maxY = (.max / p) - y + (n - (date.month - m)) / n

		// Algorithmic lower limit
		let minY = 1 - y

		var Y = date.year
		var cycles = 0
		var adjustment = TemporalTranslation.none

		// Translate out-of-range years into the valid range using
		// multiples of the recurrence cycle
		if Y > maxY {
			adjustment = .negative
			cycles = (Y - maxY) / GregorianCalendar.recurrenceCycle.years
			Y -= cycles * GregorianCalendar.recurrenceCycle.years
			Y -= GregorianCalendar.recurrenceCycle.years
		} else if Y < minY {
			adjustment = .positive
			cycles = (Y - minY) / -GregorianCalendar.recurrenceCycle.years
			Y += cycles * GregorianCalendar.recurrenceCycle.years
			Y += GregorianCalendar.recurrenceCycle.years
		}

		let h = date.month - m
		let g = Y + y - (n - h) / n
		let f = (h - 1 + n) % n
		let e = (p * g + q) / r + date.day - 1 - j
		var J = e + (s * f + t) / u
		J = J - (3 * ((g + A) / 100)) / 4 - C

		if adjustment == .negative {
			J += cycles * GregorianCalendar.recurrenceCycle.days
			J += GregorianCalendar.recurrenceCycle.days
		} else if adjustment == .positive {
			J -= cycles * GregorianCalendar.recurrenceCycle.days
			J -= GregorianCalendar.recurrenceCycle.days
		}

		return J
	}

	/// Converts a Julian day number to a date and returns the result.
	///
	/// - parameter J: A Julian day number.
	///
	/// - returns: The date corresponding to the specified Julian day number.
	///
	/// - throws: An error if the Julian Day Number could not be converted to a date.
	func dateFromJulianDayNumber(_ J: JulianDayNumber) throws -> Calendar.YearMonthDay {
		// Approximate arithmetic upper limit (the true upper limit is very difficult to calculate)
		// Most `J` values larger than this cause overflow when `e` is computed
		let maxJ = .max / 5

		// Algorithmic lower limit
		// Richards' algorithm is only valid for JDNs ≥ 0.
		let minJ = 0

		var J = J
		var cycles = 0

		if J < minJ || J > maxJ {
			let qr = J.quotientAndRemainder(dividingBy: -GregorianCalendar.recurrenceCycle.days)
			cycles = qr.quotient + 1
			J = GregorianCalendar.recurrenceCycle.days + qr.remainder
		}

		var f = J + j
		f = f + (((4 * J + B) / 146097) * 3) / 4 + C
		let e = r * f + v
		let g = (e % p) / r
		let h = u * g + w
		let D = (h % s) / u + 1
		let M = ((h / s + m) % n) + 1
		var Y = e / p - y + (n + m - M) / n

		if cycles != 0 {
			Y -= cycles * GregorianCalendar.recurrenceCycle.years
		}

		return (Y, M, D)
	}
}
