//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

extension AstronomicalCalendar: JulianDayNumberConverting {
	/// A date in the astronomical calendar consists of a year, month, and day in either the Julian or Gregorian calendar.
	public typealias DateType = JulianCalendar.DateType

	/// Converts a date in the astromical calendar to a Julian day number.
	///
	/// Dates before October 15, 1582 are treated as dates in the Julian calendar while later dates are treated as dates in the Gregorian calendar.
	///
	/// - important: No validation checks are performed on the date values.
	///
	/// - parameter date: A date to convert.
	/// - parameter date: A date to convert consisting of a year number, a month number between `1` (January) and `12` (December), and a day number between `1` and the maximum number of days in the specified month and year.
	///
	/// - returns: The Julian day number corresponding to the specified date.
	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		date < gregorianCalendarEffectiveDate ? JulianCalendar.julianDayNumberFromDate(date) : GregorianCalendar.julianDayNumberFromDate(date)
	}

	/// Converts a Julian day number to a date in the astromical calendar.
	///
	/// Julian day numbers less than 2299161 treated as dates in the Julian calendar while equal or larger Julian day numbers are treated as dates in the Gregorian calendar.
	///
	/// - parameter J: A Julian day number.
	///
	/// - returns: The date corresponding to the specified Julian day number.
	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		J < GregorianCalendar.effectiveJulianDayNumber ? JulianCalendar.dateFromJulianDayNumber(J): GregorianCalendar.dateFromJulianDayNumber(J)
	}
}
