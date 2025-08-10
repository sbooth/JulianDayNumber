//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

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
	/// - throws: An error if the date could not be converted to a Julian Day Number.
	///
	/// - seealso: ``dateFromJulianDayNumber(_:)``
	static func julianDayNumberFromDate(_ date: DateType) throws -> JulianDayNumber

	/// Converts a Julian day number to a date and returns the result.
	///
	/// - parameter J: A Julian day number.
	///
	/// - returns: The date corresponding to the specified Julian day number.
	///
	/// - throws: An error if the Julian Day Number could not be converted to a date.
	///
	/// - seealso: ``julianDayNumberFromDate(_:)``
	static func dateFromJulianDayNumber(_ J: JulianDayNumber) throws -> DateType
}

extension JulianDayNumberConverting {
	/// Converts the specified date to a date using the specified converter.
	///
	/// - parameter date: A date to convert.
	/// - parameter converter: The converter to use.
	///
	/// - returns: The specified date converted to a date using the specified converter.
	///
	/// - throws: An error if the date could not be converted to a date using the specified converter.
	public static func convertDate<C>(_ date: DateType, using converter: C.Type) throws -> C.DateType where C: JulianDayNumberConverting {
		try C.dateFromJulianDayNumber(Self.julianDayNumberFromDate(date))
	}
}
