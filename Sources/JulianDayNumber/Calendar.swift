//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

/// A calendar measuring time using years, months, and days.
public protocol Calendar: CalendarProtocol where DateType == (year: Year, month: Month, day: Day) {
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
	/// Returns `true` if the specified date is valid.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	/// - parameter D: A day number.
	///
	/// - returns: `true` if the specified date is valid.
	static func isValidDate(year Y: Year, month M: Month, day D: Day) -> Bool {
		isValidDate((Y, M, D))
	}

	static func numberOfDays(inYear Y: Year) -> Int {
//		(1...numberOfMonths(inYear: Y)).reduce(0,  { $0 + numberOfDaysIn(month: $1, year: Y) })
		var days = 0
		for M in 1...numberOfMonths(inYear: Y) {
			days += numberOfDaysIn(month: M, year: Y)
		}
		return days
	}
}
