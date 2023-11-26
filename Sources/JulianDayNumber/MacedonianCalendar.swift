//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// The Macedonian calendar is a solar calendar with 365 days in the year plus an additional leap day every fourth year.
///
/// The year consists of twelve months. The sixth month contains an additional day in leap years.
///
/// | Month | Name | Days |
/// | ---: | --- | --- |
/// | 1 | September | 30 |
/// | 2 | October | 31 |
/// | 3 | November | 30 |
/// | 4 | December | 31 |
/// | 5 | January | 31 |
/// | 6 | February | 28 (29 in leap years) |
/// | 7 | March | 31 |
/// | 8 | April | 30 |
/// | 9 | May | 31 |
/// | 10 | June | 30 |
/// | 11 | July | 31 |
/// | 12 | August | 31 |
///
/// The Macedonian calendar epoch in the Julian calendar is September 1, 312 BCE.
///
/// - seealso: [Macedonian calendar](https://en.wikipedia.org/wiki/Ancient_Macedonian_calendar)
public struct MacedonianCalendar {
	/// The Julian day number of the epoch of the Macedonian calendar.
	///
	/// This JDN corresponds to September 1, 312 BCE in the Julian calendar.
	public static let epoch: JulianDayNumber = 1607709

	/// A year in the Macedonian calendar.
	public typealias Year = Int

	/// A month in the Macedonian calendar numbered from `1`,
	public typealias Month = Int

	/// A day in the Macedonian calendar numbered starting from `1`.
	public typealias Day = Int

	/// Returns `true` if the specified year, month, and day form a valid date in the Macedonian calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	/// - parameter D: A day number.
	///
	/// - returns: `true` if the specified year, month, and day form a valid date in the Macedonian calendar.
	public static func isDateValid(year Y: Year, month M: Month, day D: Day) -> Bool {
		M > 0 && M <= 12 && D > 0 && D <= daysInMonth(year: Y, month: M)
	}


	/// Returns `true` if the specified year is a leap year in the Macedonian calendar.
	///
	/// A Macedonian leap year occurs every four years and the first leap year was year 3.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: `true` if the specified year is a leap year in the Macedonian calendar.
	public static func isLeapYear(_ Y: Year) -> Bool {
		Y > 0 ? Y % 4 == 3 : Y % 4 == -1
	}

	/// The number of months in one year.
	public static let monthsInYear = 12

	/// The number of days in each month indexed from `0` (September) to `11` (August).
	static let monthLengths = [ 30, 31, 30, 31, 31, 28, 31, 30, 31, 30, 31, 31 ]

	/// Returns the number of days in the specified month and year in the Macedonian calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	///
	/// - returns: The number of days in the specified month and year.
	public static func daysInMonth(year Y: Year, month M: Month) -> Int {
		guard M > 0, M <= 12 else {
			return 0
		}

		if M == 6 {
			return isLeapYear(Y) ? 29 : 28
		} else {
			return monthLengths[M - 1]
		}
	}
}

extension MacedonianCalendar: JulianDayNumberConverting {
	/// A date in the Macedonian calendar consists of a year, month, and day.
	public typealias DateType = (year: Year, month: Month, day: Day)

	/// The converter for the Macedonian calendar.
	static let converter = JDNConverter(y: 4405, j: 1401, m: 6, n: 12, r: 4, p: 1461, q: 0, v: 3, u: 5, s: 153, t: 2, w: 2)

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		converter.julianDayNumberFromDate(date)
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		converter.dateFromJulianDayNumber(J)
	}
}
