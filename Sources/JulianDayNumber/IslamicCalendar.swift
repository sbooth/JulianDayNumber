//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// The Islamic calendar.
///
/// The Islamic calendar is a lunar calendar consisting of 12 lunar months in a year of 354 or 355 days.
///
/// The Islamic calendar epoch in the Julian calendar is July 16, 622.
///
/// - seealso: [Islamic calendar](https://en.wikipedia.org/wiki/Islamic_calendar)
public struct IslamicCalendar {
	/// The Julian day number of the epoch of the Islamic calendar.
	///
	/// This JDN corresponds to noon on July 16, 622 in the Julian calendar.
	public static let epochJulianDayNumber: JulianDayNumber = 1948440

	/// The Julian date of the epoch of the Islamic calendar.
	///
	/// This JD corresponds to midnight on July 16, 622 in the Julian calendar.
	public static let epochJulianDate: JulianDate = 1948439.5

	/// A year in the Islamic calendar.
	public typealias Year = Int

	/// A month in the Islamic calendar numbered from `1` (Muharram) to `12` (Dhú’l-Hijjab).
	public typealias Month = Int

	/// A day in the Islamic calendar numbered starting from `1`.
	public typealias Day = Int

	/// Returns `true` if the specified year, month, and day form a valid date in the Islamic calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	/// - parameter D: A day number.
	///
	/// - returns: `true` if the specified year, month, and day form a valid date in the Islamic calendar.
	public static func isDateValid(year Y: Year, month M: Month, day D: Day) -> Bool {
		M > 0 && M <= 12 && D > 0 && D <= daysInMonth(year: Y, month: M)
	}

	/// Returns `true` if the specified year is a leap year in the Islamic calendar.
	///
	/// There are eleven leap years in a cycle of thirty years.
	/// These are years 2, 5, 7, 10, 13, 16, 18, 21, 24, 26, and 29 of the cycle.
	/// The year 1 AH was the first of a cycle.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: `true` if `Y` is a leap year in the Islamic calendar.
	public static func isLeapYear(_ Y: Year) -> Bool {
		let yearInCycle = (Y - 1) % 30 + (Y < 1 ? 31 : 1)
		return yearInCycle == 2 || yearInCycle == 5 || yearInCycle == 7 || yearInCycle == 10 || yearInCycle == 13 || yearInCycle == 16 || yearInCycle == 18 || yearInCycle == 21 || yearInCycle == 24 || yearInCycle == 26 || yearInCycle == 29
	}

	/// The number of months in one year.
	public static let monthsInYear = 12

	/// The number of days in each month indexed from `0` (Muharram) to `11` (Dhú’l-Hijjab).
	static let monthLengths = [ 30, 29, 30, 29, 30, 29, 30, 29, 30, 29, 30, 29 ]

	/// Returns the number of days in the specified month and year in the Islamic calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	///
	/// - returns: The number of days in the specified month and year.
	public static func daysInMonth(year Y: Year, month M: Month) -> Int {
		guard M > 0, M <= 12 else {
			return 0
		}

		if M == 12 {
			return isLeapYear(Y) ? 30 : 29
		} else {
			return monthLengths[M - 1]
		}
	}
}

extension IslamicCalendar {
	/// The months in the Islamic calendar.
	public enum MonthName: Int {
		/// al-Muḥarram (ٱلْمُحَرَّم), 30 days.
		case alMuḥarram = 1
		/// Ṣafar (صَفَر), 29 days.
		case safar
		/// Rabīʿ al-ʾAwwal (رَبِيع ٱلْأَوَّل), 30 days.
		case rabīʿalʾAwwal
		/// Rabīʿ ath-Thānī (رَبِيع ٱلثَّانِي), 29 days.
		case rabīʿathThānī
		/// Jumādā al-ʾŪlā (جُمَادَىٰ ٱلْأُولَىٰ), 30 days.
		case jumādāalʾŪlā
		/// Jumādā ath-Thāniyah (جُمَادَىٰ ٱلثَّانِيَة), 29 days.
		case jumādāathThāniyah
		/// Rajab (رَجَب), 30 days.
		case rajab
		/// Shaʿbān (شَعْبَان), 29 days.
		case shaʿbān
		/// Ramaḍān (رَمَضَان), 30 days.
		case ramaḍān
		/// Shawwāl (شَوَّال), 29 days.
		case shawwāl
		/// Ḏū al-Qaʿdah (ذُو ٱلْقَعْدَة), 30 days.
		case dūalQaʿdah
		/// Ḏū al-Ḥijjah (ذُو ٱلْحِجَّة), 29 days (common year) or 30 days (leap year).
		case dūalḤijjah
	}
}
