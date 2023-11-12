//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// A hybrid calendar that uses the Julian calendar for dates before October 15, 1582 and the Gregorian calendar for later dates.
public struct AstronomicalCalendar {
	/// The year, month, and day when the Gregorian calendar took effect.
	static let gregorianCalendarEffectiveDate: DateType = (year: 1582, month: 10, day: 15)

	/// A year in the astromical calendar.
	public typealias Year = JulianCalendar.Year

	/// A month in the astromical calendar numbered from `1` (January) to `12` (December).
	public typealias Month = JulianCalendar.Month

	/// A day in the astromical calendar numbered starting from `1`.
	public typealias Day = JulianCalendar.Day

	/// Returns `true` if the specified year, month, and day form a valid date in the astromical calendar.
	///
	/// - parameter date: A date to convert.
	///
	/// - returns: `true` if the specified year, month, and day form a valid date in the astromical calendar.
	public static func isDateValid(year Y: Year, month M: Month, day D: Day) -> Bool {
		(Y, M, D) < gregorianCalendarEffectiveDate ? JulianCalendar.isDateValid(year: Y, month: M, day: D) : GregorianCalendar.isDateValid(year: Y, month: M, day: D)
	}

	/// Returns `true` if the specified year, month, and day occurred before the Gregorian calendar took effect.
	///
	/// - parameter date: A date to convert consisting of a year number, a month number between `1` (January) and `12` (December), and a day number between `1` and the maximum number of days in the specified month and year.
	///
	/// - returns: `true` if the specified year, month, and day occurred before the Gregorian calendar took effect.
	public static func isJulian(year Y: Int, month M: Int, day D: Int) -> Bool {
		(Y, M, D) < gregorianCalendarEffectiveDate
	}

	/// Returns `true` if the specified Julian day number occurred before the Gregorian calendar took effect.
	///
	/// - parameter julianDayNumber: A Julian day number.
	///
	/// - returns: `true` if the specified specified Julian day number occurred before the Gregorian calendar took effect.
	public static func isJulian(julianDayNumber: JulianDayNumber) -> Bool {
		julianDayNumber < GregorianCalendar.effectiveJulianDayNumber
	}

	/// Returns `true` if the specified Julian date occurred before the Gregorian calendar took effect.
	///
	/// - parameter julianDate: A Julian date.
	///
	/// - returns: `true` if the specified specified Julian date occurred before the Gregorian calendar took effect.
	public static func isJulian(julianDate: JulianDate) -> Bool {
		julianDate < GregorianCalendar.effectiveJulianDate
	}

	/// Returns `true` if the specified year is a leap year in the astromical calendar.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: `true` if the specified year is a leap year in the astromical calendar.
	public static func isLeapYear(_ Y: Year) -> Bool {
		Y < gregorianCalendarEffectiveDate.year ? JulianCalendar.isLeapYear(Y) : GregorianCalendar.isLeapYear(Y)
	}

	/// The number of months in one year.
	public static let monthsInYear = 12

	/// Returns the number of days in the specified month and year in the astromical calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	///
	/// - returns: The number of days in the specified month and year.
	public static func daysInMonth(year Y: Year, month M: Month) -> Int {
		Y < gregorianCalendarEffectiveDate.year ? JulianCalendar.daysInMonth(year: Y, month: M) : GregorianCalendar.daysInMonth(year: Y, month: M)
	}

	/// Returns the month and day of Easter in the specified year in the astromical calendar.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: The month and day of Easter in the specified year.
	public static func easter(year Y: Year) -> (month: Int, day: Int) {
		Y < gregorianCalendarEffectiveDate.year ? JulianCalendar.easter(year: Y) : GregorianCalendar.easter(year: Y)
	}
}
