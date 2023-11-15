//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// A Julian day number.
///
/// The Julian day number (JDN) is the integer assigned to a whole solar day in the Julian day count starting from noon Universal Time,
/// with JDN 0 assigned to the day starting at noon on Monday, January 1, 4713 BCE in the proleptic Julian calendar.
///
/// - seealso: [Julian day](https://en.wikipedia.org/wiki/Julian_day)
public typealias JulianDayNumber = Int

/// Julian day number to date conversion.
public protocol JulianDayNumberConverting {
	/// The type that a Julian day number is converted to and from.
	associatedtype DateType

	/// Converts a date to a Julian day number and returns the result.
	///
	/// - important: No validation checks are performed on the date values.
	///
	/// - parameter date: A date to convert.
	///
	/// - returns: The Julian day number corresponding to the specified date.
	///
	/// - seealso: ``dateFromJulianDayNumber(_:)``
	static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber

	/// Converts a Julian day number to a date and returns the result.
	///
	/// - parameter J: A Julian day number.
	///
	/// - returns: The date corresponding to the specified Julian day number.
	///
	/// - seealso: ``julianDayNumberFromDate(_:)``
	static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType
}

extension JulianDayNumberConverting where DateType == (year: Int, month: Int, day: Int) {
	/// Converts a year, month, and day to a Julian day number and returns the result.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	/// - parameter D: A day number.
	///
	/// - returns: The Julian day number corresponding to the specified date.
	public static func julianDayNumberFrom(year Y: Int, month M: Int, day D: Int) -> JulianDayNumber {
		julianDayNumberFromDate((Y, M, D))
	}
}

// MARK: - Conversion Algorithms

// Algorithm from the Explanatory Supplement to the Astronomical Almanac, 3rd edition, S.E Urban and P.K. Seidelmann eds., (Mill Valley, CA: University Science Books), Chapter 15, pp. 585-624.

protocol YearMonthDayJulianDayNumberConverting: JulianDayNumberConverting where DateType == (year: Int, month: Int, day: Int) {
	static var calendarCycleDays: Int { get }
	static var calendarCycleYears: Int { get }
	static var julianDayNumberZero: DateType { get }

	static var y: Int { get }
	static var j: Int { get }
	static var m: Int { get }
	static var n: Int { get }
	static var r: Int { get }
	static var p: Int { get }
	static var q: Int { get }
	static var v: Int { get }
	static var u: Int { get }
	static var s: Int { get }
	static var t: Int { get }
	static var w: Int { get }
}

extension YearMonthDayJulianDayNumberConverting {
	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		var Y = date.year
		var ΔcalendarCycles = 0

		if date < julianDayNumberZero {
			ΔcalendarCycles = (julianDayNumberZero.year - Y - 1) / calendarCycleYears + 1
			Y += ΔcalendarCycles * calendarCycleYears
		}

		let h = date.month - m
		let g = Y + y - (n - h) / n
		let f = (h - 1 + n) % n
		let e = (p * g + q) / r + date.day - 1 - j
		var J = e + (s * f + t) / u

		if ΔcalendarCycles > 0 {
			J -= ΔcalendarCycles * calendarCycleDays
		}

		return J
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
//		precondition(J < Int.max - 1)

		var J = J
		var ΔcalendarCycles = 0

		// Richards' algorithm is only valid for positive JDNs.
		if J < 0 {
			ΔcalendarCycles = -J / calendarCycleDays + 1
			J += ΔcalendarCycles * calendarCycleDays
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
			Y -= ΔcalendarCycles * calendarCycleYears
		}

		return (Y, M, D)
	}
}

// MARK: Gregorian-type Intercalation

protocol GregorianIntercalatingJulianDayNumberConverting: JulianDayNumberConverting where DateType == (year: Int, month: Int, day: Int) {
	static var calendarCycleDays: Int { get }
	static var calendarCycleYears: Int { get }
	static var julianDayNumberZero: DateType { get }

	static var y: Int { get }
	static var j: Int { get }
	static var m: Int { get }
	static var n: Int { get }
	static var r: Int { get }
	static var p: Int { get }
	static var q: Int { get }
	static var v: Int { get }
	static var u: Int { get }
	static var s: Int { get }
	static var t: Int { get }
	static var w: Int { get }
	static var A: Int { get }
	static var B: Int { get }
	static var C: Int { get }
}

extension GregorianIntercalatingJulianDayNumberConverting {
	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		var Y = date.year
		var ΔcalendarCycles = 0

		if date < julianDayNumberZero {
			ΔcalendarCycles = (julianDayNumberZero.year - Y - 1) / calendarCycleYears + 1
			Y += ΔcalendarCycles * calendarCycleYears
		}

		let h = date.month - m
		let g = Y + y - (n - h) / n
		let f = (h - 1 + n) % n
		let e = (p * g + q) / r + date.day - 1 - j
		var J = e + (s * f + t) / u
		J = J - (3 * ((g + A) / 100)) / 4 - C

		if ΔcalendarCycles > 0 {
			J -= ΔcalendarCycles * calendarCycleDays
		}

		return J
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		var J = J
		var ΔcalendarCycles = 0

		// Richards' algorithm is only valid for positive JDNs.
		if J < 0 {
			ΔcalendarCycles = -J / calendarCycleDays + 1
			J += ΔcalendarCycles * calendarCycleDays
		}

		precondition(J <= Int.max - j, "Julian day number too large")

		var f = J + j
		f = f + (((4 * J + B) / 146097) * 3) / 4 + C
		let e = r * f + v
		let g = (e % p) / r
		let h = u * g + w
		let D = (h % s) / u + 1
		let M = ((h / s + m) % n) + 1
		var Y = e / p - y + (n + m - M) / n

		if ΔcalendarCycles > 0 {
			Y -= ΔcalendarCycles * calendarCycleYears
		}

		return (Y, M, D)
	}
}

