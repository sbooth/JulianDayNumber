//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// A Julian day number.
///
/// The Julian day number (JDN) is the integer assigned to a whole solar day in the Julian day count starting from noon Universal Time,
/// with JDN 0 assigned to the day starting at noon on Monday, January 1, 4713 BC in the proleptic Julian calendar.
///
/// - seealso: [Julian day](https://en.wikipedia.org/wiki/Julian_day)
public typealias JulianDayNumber = Int

/// Julian day number to year, month, and day conversion.
public protocol JulianDayNumberConverting {
	/// Converts a year, month, and day to a Julian day number and returns the result.
	///
	/// - note: No validation checks are performed on the date values.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	/// - parameter D: A day number.
	///
	/// - returns: The Julian day number corresponding to the specified year, month, and day.
	static func julianDayNumberFrom(year Y: Int, month M: Int, day D: Int) -> JulianDayNumber

	/// Converts a Julian day number to a year, month, and day and returns the result.
	///
	/// - parameter J: A Julian day number.
	///
	/// - returns: The year, month, and day corresponding to the specified Julian day number.
	static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> (year: Int, month: Int, day: Int)
}
