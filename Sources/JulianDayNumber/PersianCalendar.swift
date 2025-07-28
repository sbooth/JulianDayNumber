//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

/// The Persian calendar is a solar calendar with 365 days in the year.
///
/// The year consists of twelve months having 30 days each. The eighth month is followed by five epagomenal days.
///
/// | Month | Days |
/// | ---: | --- |
/// | 1 | 30 |
/// | 2 | 30 |
/// | 3 | 30 |
/// | 4 | 30 |
/// | 5 | 30 |
/// | 6 | 30 |
/// | 7 | 30 |
/// | 8 | 30 |
/// | 9 | 5 |
/// | 10 | 30 |
/// | 11 | 30 |
/// | 12 | 30 |
/// | 13 | 30 |
///
/// The Persian calendar epoch in the Julian calendar is June 16, 632 CE.
///
/// - seealso: [Persian calendar](https://en.wikipedia.org/wiki/Persian_calendar)
public struct PersianCalendar: Calendar {
	/// The Julian day number of the epoch of the Persian calendar.
	///
	/// This JDN corresponds to June 16, 632 CE in the Julian calendar.
	public static let epoch: JulianDayNumber = 1952063

	/// The number of months in one year.
	public static let numberOfMonthsInYear = 13

	/// The number of days in one year.
	public static let numberOfDaysInYear = 365

	/// The number of days in each month indexed from `0` (?) to `12` (?), with the epagomenal days (?) treated as month `8`.
	static let monthLengths = [ 30, 30, 30, 30, 30, 30, 30, 30, 5, 30, 30, 30, 30 ]

	/// Returns the number of days in the specified month in the Persian calendar.
	///
	/// - parameter M: A month number.
	///
	/// - returns: The number of days in the specified month.
	public static func numberOfDays(inMonth M: Month) -> Int {
		guard M > 0, M <= 13 else {
			return 0
		}
		return monthLengths[M - 1]
	}

	public static func numberOfMonths(inYear Y: Year) -> Int {
		numberOfMonthsInYear
	}

	public static func numberOfDays(inYear Y: Year) -> Int {
		numberOfDaysInYear
	}

	public static func numberOfDaysIn(month M: Month, year Y: Year) -> Int {
		numberOfDays(inMonth: M)
	}
}

extension PersianCalendar: JulianDayNumberConverting {
	/// The converter for the Persian calendar.
	static let converter = JDNConverter(y: 5348, j: 77, m: 9, n: 13, r: 1, p: 365, q: 0, v: 0, u: 1, s: 30, t: 0, w: 0)

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		converter.julianDayNumberFromDate(date)
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		converter.dateFromJulianDayNumber(J)
	}
}
