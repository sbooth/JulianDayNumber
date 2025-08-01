//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

/// The Syrian calendar is a solar calendar with 365 days in the year plus an additional leap day every fourth year.
///
/// The year consists of twelve months. The fifth month contains an additional day in leap years.
///
/// | Month | Name | Days |
/// | ---: | --- | --- |
/// | 1 | October | 31 |
/// | 2 | November | 30 |
/// | 3 | December | 31 |
/// | 4 | January | 31 |
/// | 5 | February | 28 (29 in leap years) |
/// | 6 | March | 31 |
/// | 7 | April | 30 |
/// | 8 | May | 31 |
/// | 9 | June | 30 |
/// | 10 | July | 31 |
/// | 11 | August | 31 |
/// | 12 | September | 30 |
///
/// The Syrian calendar epoch in the Julian calendar is October 1, 312 BCE.
///
/// - seealso: [Syrian calendar](https://en.wikipedia.org/wiki/Syrian_calendar)
public struct SyrianCalendar: Calendar {
	/// The Julian day number of the epoch of the Syrian calendar.
	///
	/// This JDN corresponds to October 1, 312 BCE in the Julian calendar.
	public static let epoch: JulianDayNumber = 1607739

	/// The converter for the Syrian calendar.
	static let converter = JDNConverter(y: 4405, j: 1401, m: 5, n: 12, r: 4, p: 1461, q: 0, v: 3, u: 5, s: 153, t: 2, w: 2)

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		converter.julianDayNumberFromDate(date)
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		converter.dateFromJulianDayNumber(J)
	}

	/// The number of months in one year.
	public static let numberOfMonthsInYear = 12

	/// The number of days in each month indexed from `0` (October) to `11` (September).
	static let monthLengths = [ 31, 30, 31, 31, 28, 31, 30, 31, 30, 31, 31, 30 ]

	/// Returns `true` if the specified year is a leap year in the Syrian calendar.
	///
	/// A Syrian leap year occurs every four years and the first leap year was year 3.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: `true` if the specified year is a leap year in the Syrian calendar.
	public static func isLeapYear(_ Y: Year) -> Bool {
		Y > 0 ? Y % 4 == 3 : Y % 4 == -1
	}

	public static func numberOfMonths(inYear Y: Year) -> Int {
		numberOfMonthsInYear
	}

	public static func numberOfDays(inYear Y: Year) -> Int {
		isLeapYear(Y) ? 366 : 365
	}

	public static func numberOfDaysIn(month M: Month, year Y: Year) -> Int {
		guard M > 0, M <= numberOfMonthsInYear else {
			return 0
		}

		if M == 5 {
			return isLeapYear(Y) ? 29 : 28
		} else {
			return monthLengths[M - 1]
		}
	}
}
