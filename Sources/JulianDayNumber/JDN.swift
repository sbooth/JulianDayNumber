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

// Algorithms from the Explanatory Supplement to the Astronomical Almanac, 3rd edition, S.E Urban and P.K. Seidelmann eds., (Mill Valley, CA: University Science Books), Chapter 15, pp. 585-624.

/// Algorithm parameters for converting a Julian day number to a year, month, and day.
struct JDNConversionParameters {
	let y: Int
	let j: Int
	let m: Int
	let n: Int
	let r: Int
	let p: Int
	let q: Int
	let v: Int
	let u: Int
	let s: Int
	let t: Int
	let w: Int
}

/// Algorithm parameters specific to calenders using Gregorian-type intercalating.
struct JDNGregorianIntercalatingParameters {
	let A: Int
	let B: Int
	let C: Int
}

/// A calendar's intercalating cycle.
typealias IntercalatingCycle = (years: Int, days: Int)

/// A date consisting of a year, month, and day.
typealias YearMonthDay = (year: Int, month: Int, day: Int)

/// Converts a date to a Julian day number using the specified conversion parameters and returns the result.
///
/// - important: No validation checks are performed on the date values.
///
/// - parameter date: A date to convert.
/// - parameter parameters: Parameters for the conversion algorithm.
/// - parameter jdnZero: The date for which the Julian day number is zero.
/// - parameter intercalatingCycle: The calendar's intercalating cycle.
///
/// - returns: The Julian day number corresponding to the specified date.
func jdnFromDate(_ date: YearMonthDay, conversionParameters parameters: JDNConversionParameters, jdnZero: YearMonthDay, intercalatingCycle: IntercalatingCycle) -> JulianDayNumber {
	var Y = date.year
	var ΔcalendarCycles = 0

	if date < jdnZero {
		ΔcalendarCycles = (jdnZero.year - Y - 1) / intercalatingCycle.years + 1
		Y += ΔcalendarCycles * intercalatingCycle.years
	}

	let h = date.month - parameters.m
	let g = Y + parameters.y - (parameters.n - h) / parameters.n
	let f = (h - 1 + parameters.n) % parameters.n
	let e = (parameters.p * g + parameters.q) / parameters.r + date.day - 1 - parameters.j
	var J = e + (parameters.s * f + parameters.t) / parameters.u

	if ΔcalendarCycles > 0 {
		J -= ΔcalendarCycles * intercalatingCycle.days
	}

	return J
}

/// Converts a Julian day number to a date and returns the result.
///
/// - parameter J: A Julian day number.
/// - parameter parameters: Parameters for the conversion algorithm.
/// - parameter intercalatingCycle: The calendar's intercalating cycle.
///
/// - returns: The date corresponding to the specified Julian day number.
func dateFromJDN(_ J: JulianDayNumber, conversionParameters parameters: JDNConversionParameters, intercalatingCycle: IntercalatingCycle) -> YearMonthDay {
//	precondition(J < Int.max - 1)

	var J = J
	var ΔcalendarCycles = 0

	// Richards' algorithm is only valid for positive JDNs.
	if J < 0 {
		ΔcalendarCycles = -J / intercalatingCycle.days + 1
		J += ΔcalendarCycles * intercalatingCycle.days
	}

	precondition(J <= Int.max - parameters.j, "Julian day number too large")

	let f = J + parameters.j
	let e = parameters.r * f + parameters.v
	let g = (e % parameters.p) / parameters.r
	let h = parameters.u * g + parameters.w
	let D = (h % parameters.s) / parameters.u + 1
	let M = ((h / parameters.s + parameters.m) % parameters.n) + 1
	var Y = e / parameters.p - parameters.y + (parameters.n + parameters.m - M) / parameters.n

	if ΔcalendarCycles > 0 {
		Y -= ΔcalendarCycles * intercalatingCycle.years
	}

	return (Y, M, D)
}


func jdnFromDate(_ date: YearMonthDay, conversionParameters parameters: JDNConversionParameters, gregorianIntercalatingParameters: JDNGregorianIntercalatingParameters, jdnZero: YearMonthDay, intercalatingCycle: IntercalatingCycle) -> JulianDayNumber {
	var Y = date.year
	var ΔcalendarCycles = 0

	if date < jdnZero {
		ΔcalendarCycles = (jdnZero.year - Y - 1) / intercalatingCycle.years + 1
		Y += ΔcalendarCycles * intercalatingCycle.years
	}

	let h = date.month - parameters.m
	let g = Y + parameters.y - (parameters.n - h) / parameters.n
	let f = (h - 1 + parameters.n) % parameters.n
	let e = (parameters.p * g + parameters.q) / parameters.r + date.day - 1 - parameters.j
	var J = e + (parameters.s * f + parameters.t) / parameters.u
	J = J - (3 * ((g + gregorianIntercalatingParameters.A) / 100)) / 4 - gregorianIntercalatingParameters.C

	if ΔcalendarCycles > 0 {
		J -= ΔcalendarCycles * intercalatingCycle.days
	}

	return J
}

func dateFromJDN(_ J: JulianDayNumber, conversionParameters parameters: JDNConversionParameters, gregorianIntercalatingParameters: JDNGregorianIntercalatingParameters, intercalatingCycle: IntercalatingCycle) -> YearMonthDay {
	var J = J
	var ΔcalendarCycles = 0

	// Richards' algorithm is only valid for positive JDNs.
	if J < 0 {
		ΔcalendarCycles = -J / intercalatingCycle.days + 1
		J += ΔcalendarCycles * intercalatingCycle.days
	}

	precondition(J <= Int.max - parameters.j, "Julian day number too large")

	var f = J + parameters.j
	f = f + (((4 * J + gregorianIntercalatingParameters.B) / 146097) * 3) / 4 + gregorianIntercalatingParameters.C
	let e = parameters.r * f + parameters.v
	let g = (e % parameters.p) / parameters.r
	let h = parameters.u * g + parameters.w
	let D = (h % parameters.s) / parameters.u + 1
	let M = ((h / parameters.s + parameters.m) % parameters.n) + 1
	var Y = e / parameters.p - parameters.y + (parameters.n + parameters.m - M) / parameters.n

	if ΔcalendarCycles > 0 {
		Y -= ΔcalendarCycles * intercalatingCycle.years
	}

	return (Y, M, D)
}
