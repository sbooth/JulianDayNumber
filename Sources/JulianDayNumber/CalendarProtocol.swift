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

/// A calendar that supports Julian day number to date conversion.
public protocol CalendarProtocol {
	/// A date in the calendar.
	associatedtype DateType

	/// The calendar's epoch.
	static var epoch: JulianDayNumber { get }

	/// Returns `true` if the specified date is valid.
	///
	/// - parameter date: A date to check.
	///
	/// - returns: `true` if the specified date is valid.
	static func isValidDate(_ date: DateType) -> Bool

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

extension CalendarProtocol {
	/// Converts the specified date to a date in another calendar.
	///
	/// - parameter date: A date to convert.
	/// - parameter calendar: The calendar to use for conversion.
	///
	/// - returns: The specified date converted to a date in the specified calendar.
	public static func convertDate<C>(_ date: DateType, toCalendar calendar: C.Type) -> C.DateType where C: CalendarProtocol {
		C.dateFromJulianDayNumber(Self.julianDayNumberFromDate(date))
	}
}
