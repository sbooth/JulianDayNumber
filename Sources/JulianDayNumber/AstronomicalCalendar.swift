//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

/// A hybrid calendar that uses the Julian calendar for dates on or before October 4, 1582 and the Gregorian calendar for dates on or after October 15, 1582.
public struct AstronomicalCalendar {
	/// The year, month, and day of the last valid Julian calendar date in the astronomical calendar.
	public static let lastJulianCalendarDate: DateType = (year: 1582, month: 10, day: 4)

	/// The year, month, and day of the first valid Gregorian calendar date in the astronomical calendar.
	public static let firstGregorianCalendarDate: DateType = (year: 1582, month: 10, day: 15)

	/// A year in the astronomical calendar.
	public typealias Year = JulianCalendar.Year

	/// A month in the astronomical calendar numbered from `1` (January) to `12` (December).
	public typealias Month = JulianCalendar.Month

	/// A day in the astronomical calendar numbered starting from `1`.
	public typealias Day = JulianCalendar.Day

	/// Returns `true` if the specified year, month, and day form a valid date in the astronomical calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	/// - parameter D: A day number.
	///
	/// - returns: `true` if the specified year, month, and day form a valid date in the astronomical calendar.
	public static func isDateValid(year Y: Year, month M: Month, day D: Day) -> Bool {
		if (Y, M, D) >= firstGregorianCalendarDate {
			return GregorianCalendar.isDateValid(year: Y, month: M, day: D)
		} else if (Y, M, D) <= lastJulianCalendarDate {
			return JulianCalendar.isDateValid(year: Y, month: M, day: D)
		} else {
			return false
		}
	}

	/// Returns `true` if the specified Julian day number occurred before the Gregorian calendar took effect.
	///
	/// - parameter julianDayNumber: A Julian day number.
	///
	/// - returns: `true` if the specified specified Julian day number occurred before the Gregorian calendar took effect.
	public static func isJulian(julianDayNumber: JulianDayNumber) -> Bool {
		julianDayNumber < GregorianCalendar.effectiveJulianDayNumber
	}

	/// Returns `true` if the specified year is a leap year in the astronomical calendar.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: `true` if the specified year is a leap year in the astronomical calendar.
	public static func isLeapYear(_ Y: Year) -> Bool {
		// 1582 was not a leap year so there is no need to special-case
		Y < firstGregorianCalendarDate.year ? JulianCalendar.isLeapYear(Y) : GregorianCalendar.isLeapYear(Y)
	}

	/// The number of months in one year.
	public static let monthsInYear = JulianCalendar.monthsInYear

	/// Returns the number of days in the specified year in the astronomical calendar.
	///
	/// - parameter Y: A year number.
	///
	/// - note: This function accounts for the Julian to Gregorian calendar changeover.
	///
	/// - returns: The number of days in the specified year.
	public static func daysInYear(_ Y: Year) -> Int {
		if Y > firstGregorianCalendarDate.year {
			return GregorianCalendar.daysInYear(Y)
		}
		else if Y < firstGregorianCalendarDate.year {
			return JulianCalendar.daysInYear(Y)
		} else {
			return 355
		}
	}

	/// Returns the number of days in the specified month and year in the astronomical calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	///
	/// - note: This function accounts for the Julian to Gregorian calendar changeover.
	///
	/// - returns: The number of days in the specified month and year.
	public static func daysInMonth(year Y: Year, month M: Month) -> Int {
		if (Y, M) > (firstGregorianCalendarDate.year, firstGregorianCalendarDate.month) {
			return GregorianCalendar.daysInMonth(year: Y, month: M)
		}
		else if (Y, M) < (firstGregorianCalendarDate.year, firstGregorianCalendarDate.month) {
			return JulianCalendar.daysInMonth(year: Y, month: M)
		}
		else {
			return 21
		}
	}

	/// Returns the month and day of Easter in the specified year in the astronomical calendar.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: The month and day of Easter in the specified year.
	public static func easter(year Y: Year) -> (month: Month, day: Day) {
		Y > firstGregorianCalendarDate.year ? GregorianCalendar.easter(year: Y) : JulianCalendar.easter(year: Y)
	}
}

extension AstronomicalCalendar: JulianDayNumberConverting {
	/// A date in the astronomical calendar consists of a year, month, and day in either the Julian or Gregorian calendar.
	public typealias DateType = JulianCalendar.DateType

	/// Converts a date in the astronomical calendar to a Julian day number.
	///
	/// Dates before October 15, 1582 are treated as dates in the Julian calendar while later dates are treated as dates in the Gregorian calendar.
	///
	/// - important: No validation checks are performed on the date values.
	///
	/// - parameter date: A date to convert.
	///
	/// - returns: The Julian day number corresponding to the specified date.
	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		date < firstGregorianCalendarDate ? JulianCalendar.julianDayNumberFromDate(date) : GregorianCalendar.julianDayNumberFromDate(date)
	}

	/// Converts a Julian day number to a date in the astronomical calendar.
	///
	/// Julian day numbers less than 2299161 are treated as dates in the Julian calendar while equal or larger Julian day numbers are treated as dates in the Gregorian calendar.
	///
	/// - parameter J: A Julian day number.
	///
	/// - returns: The date corresponding to the specified Julian day number.
	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		J < GregorianCalendar.effectiveJulianDayNumber ? JulianCalendar.dateFromJulianDayNumber(J): GregorianCalendar.dateFromJulianDayNumber(J)
	}
}
