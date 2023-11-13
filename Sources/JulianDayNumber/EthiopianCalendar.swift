//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// The Ethiopian calendar.
///
/// The Ethiopian calendar is a solar calendar of 365 days in every year with an additional leap day every fourth year.
///
/// The Ethiopian calendar epoch in the Julian calendar is August 29, 8.
///
/// - seealso: [Ethiopian calendar](https://en.wikipedia.org/wiki/Ethiopian_calendar)
public struct EthiopianCalendar {
	/// The Julian day number of the epoch of the Ethiopian calendar.
	///
	/// This JDN corresponds to noon on August 29, 8 in the Julian calendar.
	public static let epochJulianDayNumber: JulianDayNumber = 1724221

	/// The Julian date of the epoch of the Ethiopian calendar.
	///
	/// This JD corresponds to midnight on August 29, 8 in the Julian calendar.
	public static let epochJulianDate: JulianDate = 1724220.5

	/// A year in the Ethiopian calendar.
	public typealias Year = Int

	/// A month in the Ethiopian calendar numbered from `1` (Mäskäräm) to `13` (Ṗagume).
	public typealias Month = Int

	/// A day in the Ethiopian calendar numbered starting from `1`.
	public typealias Day = Int

	/// Returns `true` if the specified year, month, and day form a valid date in the Ethiopian calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	/// - parameter D: A day number.
	///
	/// - returns: `true` if the specified year, month, and day form a valid date in the Ethiopian calendar.
	public static func isDateValid(year Y: Year, month M: Month, day D: Day) -> Bool {
		M > 0 && M <= 13 && D > 0 && D <= daysInMonth(year: Y, month: M)
	}

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

	/// The number of months in one year.
	public static let monthsInYear = 13

	/// The number of days in each month indexed from `0` (Mäskäräm) to `12` (Ṗagume).
	static let monthLengths = [ 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 5 ]

	/// Returns the number of days in the specified month and year in the Ethiopian calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	///
	/// - returns: The number of days in the specified month and year.
	public static func daysInMonth(year Y: Year, month M: Month) -> Int {
		guard M > 0, M <= 13 else {
			return 0
		}

		if M == 13 {
			return isLeapYear(Y) ? 6 : 5
		} else {
			return monthLengths[M - 1]
		}
	}
}

extension EthiopianCalendar {
	/// The months in the Ethiopian calendar.
	enum MonthName: Int {
		/// Mäskäräm (መስከረም), 30 days
		case mäskäräm = 1
		/// Ṭəqəmt (ጥቅምት), 30 days
		case təqəmt
		/// Ḫədar (ኅዳር), 30 days
		case hədar
		/// Taḫśaś (ታኅሣሥ), 30 days
		case taḫśaś
		/// Ṭərr (ጥር), 30 days
		case tərr
		/// Yäkatit (የካቲት), 30 days
		case yäkatit
		/// Mägabit (መጋቢት), 30 days
		case mägabit
		/// Miyazya (ሚያዝያ), 30 days
		case miyazya
		/// Gənbo (ግንቦት), 30 days
		case gənbo
		/// Säne (ሰኔ), 30 days
		case säne
		/// Ḥamle (ሐምሌ), 30 days
		case hamle
		/// Nähase (ነሐሴ), 30 days
		case nähase
		/// Ṗagume (ጳጉሜ), 5 days (common year) or 6 days (leap year)
		case pagume
	}
}
