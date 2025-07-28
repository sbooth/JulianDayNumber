//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

/// The Ethiopian calendar is a solar calendar with 365 days in the year plus an additional leap day every fourth year.
///
/// The year consists of twelve months having 30 days each. The twelfth month is followed by five epagomenal days (Ṗagume) with a sixth in leap years.
///
/// | Month | Name | | Days |
/// | ---: | --- | --- | --- |
/// | 1 | Mäskäräm | መስከረም | 30 |
/// | 2 | Ṭəqəmt | ጥቅምት | 30 |
/// | 3 | Ḫədar | ኅዳር | 30 |
/// | 4 | Taḫśaś | ታኅሣሥ | 30 |
/// | 5 | Ṭərr | ጥር | 30 |
/// | 6 | Yäkatit | የካቲት | 30 |
/// | 7 | Mägabit | መጋቢት | 30 |
/// | 8 | Miyazya | ሚያዝያ | 30 |
/// | 9 | Gənbo | ግንቦት | 30 |
/// | 10 | Säne | ሰኔ | 30 |
/// | 11 | Ḥamle | ሐምሌ | 30 |
/// | 12 | Nähase | ነሐሴ | 30 |
/// | 13 | Ṗagume | ጳጉሜ | 5 (6 in leap years) |
///
/// The Ethiopian calendar epoch in the Julian calendar is August 29, 8 CE.
///
/// - seealso: [Ethiopian calendar](https://en.wikipedia.org/wiki/Ethiopian_calendar)
public struct EthiopianCalendar: Calendar {
	/// The Julian day number of the epoch of the Ethiopian calendar.
	///
	/// This JDN corresponds to August 29, 8 CE in the Julian calendar.
	public static let epoch: JulianDayNumber = 1724221

	/// The number of months in one year.
	public static let numberOfMonthsInYear = 13

	/// The number of days in each month indexed from `0` (Mäskäräm) to `12` (Ṗagume).
	static let monthLengths = [ 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 5 ]

	/// Returns `true` if the specified year is a leap year in the Ethiopian calendar.
	///
	/// An Ethiopian leap year occurs every four years and the first leap year was year 3.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: `true` if the specified year is a leap year in the Ethiopian calendar.
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

		if M == 13 {
			return isLeapYear(Y) ? 6 : 5
		} else {
			return monthLengths[M - 1]
		}
	}
}

extension EthiopianCalendar: JulianDayNumberConverting {
	/// The converter for the Ethiopian calendar.
	static let converter = JDNConverter(y: 4720, j: 124, m: 0, n: 13, r: 4, p: 1461, q: 0, v: 3, u: 1, s: 30, t: 0, w: 0)

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		converter.julianDayNumberFromDate(date)
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		converter.dateFromJulianDayNumber(J)
	}
}
