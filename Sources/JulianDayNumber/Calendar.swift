//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

/// A calendar measuring time using years, months, and days.
public protocol Calendar: CalendarProtocol where DateType == YearMonthDay {
	/// A year number relative to the calendar's epoch.
	///
	/// Year numbers may be positive or negative and the first year following the epoch has year number `1`.
	typealias Year = Int

	/// A month number within a calendar year.
	///
	/// Month numbers are always positive and the first month of a year has month number `1`.
	typealias Month = Int

	/// A day number within a calendar month.
	///
	/// Day numbers are always positive and the first day of a month has day number `1`.
	typealias Day = Int

	/// A date consisting of a year number, month number, and day number.
	typealias YearMonthDay = (year: Year, month: Month, day: Day)

	/// Returns the number of months in the specified year.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: The number of months in the specified year.
	static func numberOfMonths(inYear Y: Year) -> Int

	/// Returns the number of days in the specified year.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: The number of days in the specified year.
	static func numberOfDays(inYear Y: Year) -> Int

	/// Returns the number of days in the specified month and year.
	///
	/// - parameter M: A month number.
	/// - parameter Y: A year number.
	///
	/// - returns: The number of days in the specified month and year.
	static func numberOfDaysIn(month M: Month, year Y: Year) -> Int
}

extension Calendar {
	public static func isValidDate(_ date: DateType) -> Bool {
		date.month > 0 && date.month <= numberOfMonths(inYear: date.year) && date.day > 0 && date.day <= numberOfDaysIn(month: date.month, year: date.year)
	}

	/// Returns `true` if the specified year, month, and day form a valid date.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	/// - parameter D: A day number.
	///
	/// - returns: `true` if the specified date is valid.
	public static func isValid(year Y: Year, month M: Month, day D: Day) -> Bool {
		isValidDate((Y, M, D))
	}
}

extension Calendar {
	/// Converts a year, month, and day to a Julian day number and returns the result.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	/// - parameter D: A day number.
	///
	/// - returns: The Julian day number corresponding to the specified year, month, and day.
	public static func julianDayNumberFrom(year Y: Year, month M: Month, day D: Day) -> JulianDayNumber {
		julianDayNumberFromDate((Y, M, D))
	}

	/// An ordinal day.
	public typealias OrdinalDay = Int

	/// Converts a year, month, and day to an ordinal day and returns the result.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	/// - parameter D: A day number.
	///
	/// - returns: The ordinal day corresponding to the specified year, month, and day.
	public static func ordinalDayFrom(year Y: Year, month M: Month, day D: Day) -> OrdinalDay {
		OrdinalDay(julianDayNumberFrom(year: Y, month: M, day: D) - julianDayNumberFrom(year: Y, month: 1, day: 1) + 1)
	}

	/// Converts a year and ordinal day to a year, month, and day and returns the result.
	///
	/// - parameter Y: A year number.
	/// - parameter N: An ordinal day number.
	///
	/// - returns: The year, month, and day corresponding to the specified year and ordinal day.
	public static func dateFrom(year Y: Year, ordinalDay N: OrdinalDay) -> DateType {
		dateFromJulianDayNumber(julianDayNumberFrom(year: Y, month: 1, day: 1) + JulianDayNumber(N) - 1)
	}
}

extension Calendar {
	/// Converts the specified date to a date in another calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	/// - parameter D: A day number.
	/// - parameter calendar: The calendar to use for conversion.
	///
	/// - returns: The specified date converted to a date in the specified calendar.
	public static func convert<C>(year Y: Year, month M: Month, day D: Day, to calendar: C.Type) -> C.DateType where C: CalendarProtocol {
		convertDate((Y, M, D), using: calendar)
	}
}
