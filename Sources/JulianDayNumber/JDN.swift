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
