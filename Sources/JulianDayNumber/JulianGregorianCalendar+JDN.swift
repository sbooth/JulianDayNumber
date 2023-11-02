// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

extension JulianGregorianCalendar: JulianDayNumberConverting {
	/// Converts a year, month, and day in the Julian or Gregorian calendar to a Julian day number.
	///
	///
	/// Dates before 1582-10-15 are treated as dates in the Julian calendar, while later dates are treated as dates in the Gregorian calendar.
	///
	/// - note: No validation checks are performed on the date values.
	///
	/// - parameter Y: A year number between `-9999` and `99999`.
	/// - parameter M: A month number between `1` (January) and `12` (December).
	/// - parameter D: A day number between `1` and the maximum number of days in month `M` for year `Y`.
	///
	/// - returns: The Julian day number corresponding to the specified year, month, and day.
	public static func dateToJulianDayNumber(year Y: Int, month M: Int, day D: Int) -> JulianDayNumber {
		if (Y, M, D) < gregorianCalendarChangeoverDate {
			return JulianCalendar.dateToJulianDayNumber(year: Y, month: M, day: D)
		} else {
			return GregorianCalendar.dateToJulianDayNumber(year: Y, month: M, day: D)
		}
	}

	/// Converts a Julian day number to a year, month, and day in the Julian or Gregorian calendar.
	///
	/// Julian day numbers less than 2299161 treated as dates in the Julian calendar while equal or larger Julian day numbers are treated as dates in the Gregorian calendar.
	///
	/// - parameter J: A Julian day number.
	///
	/// - returns: The year, month, and day corresponding to the specified Julian day number.
	public static func julianDayNumberToDate(_ J: JulianDayNumber) -> (year: Int, month: Int, day: Int) {
		if J < gregorianCalendarChangeoverJDN {
			return JulianCalendar.julianDayNumberToDate(J)
		} else {
			return GregorianCalendar.julianDayNumberToDate(J)
		}
	}
}
