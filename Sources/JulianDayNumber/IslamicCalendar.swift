//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

/// The Islamic calendar is a lunar calendar with 354 days in the year plus an additional leap day in certain years.
///
/// The year consists of twelve months having 29 or 30 days each. The twelfth month contains an additional day in leap years.
///
/// | Month | Name | | Days |
/// | ---: | --- | --- | --- |
/// | 1 | al-Muḥarram | ٱلْمُحَرَّم | 30 |
/// | 2 | Ṣafar | صَفَر | 29 |
/// | 3 | Rabīʿ al-ʾAwwal | رَبِيع ٱلْأَوَّل | 30 |
/// | 4 | Rabīʿ ath-Thānī | رَبِيع ٱلثَّانِي | 29 |
/// | 5 | Jumādā al-ʾŪlā | جُمَادَىٰ ٱلْأُولَىٰ | 30 |
/// | 6 | Jumādā ath-Thāniyah | جُمَادَىٰ ٱلثَّانِيَة | 29 |
/// | 7 | Rajab | رَجَب | 30 |
/// | 8 | Shaʿbān | شَعْبَان | 29 |
/// | 9 | Ramaḍān | رَمَضَان | 30 |
/// | 10 | Shawwāl | شَوَّال | 29 |
/// | 11 | Ḏū al-Qaʿdah | ذُو ٱلْقَعْدَة | 30 |
/// | 12 | Ḏū al-Ḥijjah | ذُو ٱلْحِجَّة | 29 (30 in leap years) |
///
/// The Islamic calendar epoch in the Julian calendar is July 16, 622 CE.
///
/// The true Islamic calendar is a purely lunar calendar in which months correspond to the lunar phases. This implementation
/// is an arithmetic calendar, sometimes called the civil Islamic calendar, that approximates the lunar phases.
///
/// - seealso: [Islamic calendar](https://en.wikipedia.org/wiki/Islamic_calendar)
public struct IslamicCalendar: Calendar {
	/// The Julian day number of the epoch of the Islamic calendar.
	///
	/// This JDN corresponds to July 16, 622 CE in the Julian calendar.
	public static let epoch: JulianDayNumber = 1948440

	/// The converter for the Islamic calendar.
	static let converter = JDNConverter(y: 5519, j: 7664, m: 0, n: 12, r: 30, p: 10631, q: 14, v: 15, u: 100, s: 2951, t: 51, w: 10)

	public static func julianDayNumberFromDate(_ date: DateType) throws -> JulianDayNumber {
		try converter.julianDayNumberFromDate(date)
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) throws -> DateType {
		try converter.dateFromJulianDayNumber(J)
	}

	/// The number of months in one year.
	public static let numberOfMonthsInYear = 12

	/// The number of days in each month indexed from `0` (Muharram) to `11` (Dhú’l-Hijjab).
	static let monthLengths = [ 30, 29, 30, 29, 30, 29, 30, 29, 30, 29, 30, 29 ]

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
		let yearInCycle = Y > 0 ? (Y - 1) % 30 + 1 : (Y % 30) + 30
		return yearInCycle == 2 || yearInCycle == 5 || yearInCycle == 7 || yearInCycle == 10 || yearInCycle == 13 || yearInCycle == 16 || yearInCycle == 18 || yearInCycle == 21 || yearInCycle == 24 || yearInCycle == 26 || yearInCycle == 29
	}

	public static func numberOfMonths(inYear Y: Year) -> Int {
		numberOfMonthsInYear
	}

	public static func numberOfDays(inYear Y: Year) -> Int {
		isLeapYear(Y) ? 355 : 354
	}

	public static func numberOfDaysIn(month M: Month, year Y: Year) -> Int {
		guard M > 0, M <= numberOfMonthsInYear else {
			return 0
		}

		if M == 12 {
			return isLeapYear(Y) ? 30 : 29
		} else {
			return monthLengths[M - 1]
		}
	}
}
