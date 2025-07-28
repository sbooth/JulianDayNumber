//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

/// A hybrid calendar that uses the Julian calendar for dates on or before October 4, 1582 and the Gregorian calendar for dates on or after October 15, 1582.
public struct AstronomicalCalendar: Calendar {
	/// The Julian day number of the epoch of the astronomical calendar.
	///
	/// This JDN corresponds to January 1, 1 CE in the Julian calendar.
	public static let epoch = JulianCalendar.epoch

	/// The year, month, and day of the last valid Julian calendar date in the astronomical calendar.
	public static let lastJulianCalendarDate: DateType = (year: 1582, month: 10, day: 4)

	/// The year, month, and day of the first valid Gregorian calendar date in the astronomical calendar.
	public static let firstGregorianCalendarDate: DateType = (year: 1582, month: 10, day: 15)

	/// The number of months in one year.
	public static let numberOfMonthsInYear = JulianCalendar.numberOfMonthsInYear

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

	/// Returns `true` if the specified year, month, and day form a valid date in the astronomical calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	/// - parameter D: A day number.
	///
	/// - returns: `true` if the specified year, month, and day form a valid date in the astronomical calendar.
	public static func isValidDate(year Y: Year, month M: Month, day D: Day) -> Bool {
		if (Y, M, D) >= firstGregorianCalendarDate {
			return GregorianCalendar.isValidDate(year: Y, month: M, day: D)
		} else if (Y, M, D) <= lastJulianCalendarDate {
			return JulianCalendar.isValidDate(year: Y, month: M, day: D)
		} else {
			return false
		}
	}

	public static func numberOfMonths(inYear Y: Year) -> Int {
		numberOfMonthsInYear
	}

	/// Returns the number of days in the specified year in the astronomical calendar.
	///
	/// - parameter Y: A year number.
	///
	/// - note: This function accounts for the Julian to Gregorian calendar changeover.
	///
	/// - returns: The number of days in the specified year.
	public static func numberOfDays(inYear Y: Year) -> Int {
		if Y > firstGregorianCalendarDate.year {
			return GregorianCalendar.numberOfDays(inYear: Y)
		}
		else if Y < firstGregorianCalendarDate.year {
			return JulianCalendar.numberOfDays(inYear: Y)
		} else {
			return 355
		}
	}

	/// Returns the number of days in the specified month and year in the astronomical calendar.
	///
	/// - parameter M: A month number.
	/// - parameter Y: A year number.
	///
	/// - note: This function accounts for the Julian to Gregorian calendar changeover.
	///
	/// - returns: The number of days in the specified month and year.
	public static func numberOfDaysIn(month M: Month, year Y: Year) -> Int {
		if (Y, M) > (firstGregorianCalendarDate.year, firstGregorianCalendarDate.month) {
			return GregorianCalendar.numberOfDaysIn(month: M, year: Y)
		}
		else if (Y, M) < (firstGregorianCalendarDate.year, firstGregorianCalendarDate.month) {
			return JulianCalendar.numberOfDaysIn(month: M, year: Y)
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
