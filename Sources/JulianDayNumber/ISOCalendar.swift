//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

/// The ISO week-numbering calendar.
///
/// - seealso: [ISO week date](https://en.wikipedia.org/wiki/ISO_week_date)
public struct ISOCalendar: CalendarProtocol {
	/// A year in the ISO calendar is equivalent to the Gregorian calendar year with the same value.
	public typealias Year = GregorianCalendar.Year

	/// A week number for a full week in the ISO calendar numbered from `1` to  `52` (for short years) or `53` (for long years).
	public typealias WeekNumber = Int

	/// A weekday number in the ISO calendar numbered from `1` (Monday) to `7` (Sunday).
	public typealias WeekdayNumber = Int

	/// An ISO week date consists of a year, week number, and weekday number.
	public typealias DateType = (year: Year, week: WeekNumber, weekday: WeekdayNumber)

	/// The Julian day number of the epoch of the ISO calendar.
	///
	/// This JDN corresponds to January 3, 1 CE in the Julian calendar.
	public static let epoch = GregorianCalendar.epoch

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		GregorianCalendar.julianDayNumberFromDate(dateFromISO(year: date.year, week: date.week, weekday: date.weekday))
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		let (Y, M, D) = GregorianCalendar.dateFromJulianDayNumber(J)
		return isoDateFrom(year: Y, month: M, day: D)
	}

	/// Returns the number of ISO full weeks in a year.
	///
	/// - parameter Y: A Gregorian year number.
	///
	/// - returns: The number of full weeks in the specified year.
	static func isoWeeksInYear(_ Y: Int) -> Int {
		/// Returns the day of the week for December 31st in the specified year.
		///
		/// - parameter Y: A Gregorian year number.
		///
		/// - returns: The day of the week for December 31st in the specified year.
		func p(_ Y: Int) -> Int {
			(Y + Y / 4 - Y / 100 + Y / 400) % 7
		}

		if p(Y) == 4 || p(Y - 1) == 3 {
			return 53
		}
		return 52
	}

	/// Returns the ISO weekday for the specified year, month, and day.
	///
	/// - parameter Y: A Gregorian year number.
	/// - parameter M: A month number.
	/// - parameter D: A day number.
	///
	/// - returns: The ISO weekday from `1` (Monday) to `7` (Sunday) corresponding to the specified year, month, and day.
	static func isoWeekdayFrom(year Y: Int, month M: Int, day D: Int) -> WeekdayNumber {
		let weekday = GregorianCalendar.dayOfWeekFrom(year: Y, month: M, day: D) - 1
		return weekday < 1 ? weekday + 7 : weekday
	}

	public static func isValidDate(_ date: (year: Year, week: WeekNumber, weekday: WeekdayNumber)) -> Bool {
		// TODO: Is this correct?
		date.weekday > 0 && date.weekday <= 7 && date.week > 0 && date.week <= isoWeeksInYear(date.year)
	}

	/// Returns the ISO week date for the specified year, month, and day.
	///
	/// - parameter Y: A Gregorian year number.
	/// - parameter M: A month number.
	/// - parameter D: A day number.
	///
	/// - returns: The ISO week date corresponding to the specified year, month, and day.
	public static func isoDateFrom(year Y: Int, month M: Int, day D: Int) -> (year: Year, week: WeekNumber, weekday: WeekdayNumber) {
		let N = GregorianCalendar.ordinalDayFrom(year: Y, month: M, day: D)
		let weekday = isoWeekdayFrom(year: Y, month: M, day: D)
		let w = (10 + N - weekday) / 7
		if w == 0 {
			return (Y - 1, isoWeeksInYear(Y - 1), weekday)
		} else if w > isoWeeksInYear(Y) {
			return (Y + 1, 1, weekday)
		}
		return (Y, w, weekday)
	}

	/// Returns the date for the specified year, ISO week number, and ISO weekday number.
	///
	/// - parameter Y: A Gregorian year number.
	/// - parameter week: An ISO week number.
	/// - parameter weekday: An ISO weekday number.
	///
	/// - returns: The date corresponding to the specified Gregorian year, ISO week number, and ISO weekday number.
	public static func dateFromISO(year Y: Year, week: WeekNumber, weekday: WeekdayNumber) -> (year: Int, month: Int, day: Int) {
		let N = week * 7 + weekday - isoWeekdayFrom(year: Y, month: 1, day: 4) - 3
		return GregorianCalendar.dateFrom(year: Y, ordinalDay: N)
	}
}
