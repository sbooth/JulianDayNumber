//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

/// The Baháʼí calendar is a solar calendar with 365 days in the year plus an additional leap day in certain years.
///
/// The year consists of nineteen months having 19 days each. The eighteenth month is followed by four epagomenal days (Ayyám-i-Há) with a fifth in leap years.
///
/// | Month | Name | | Days |
/// | ---: | --- | --- | --- |
/// | 1 | Bahá | بهاء | 19 |
/// | 2 | Jalál | جلال | 19 |
/// | 3 | Jamál | جمال | 19 |
/// | 4 | ʻAẓamat | عظمة | 19 |
/// | 5 | Núr | نور | 19 |
/// | 6 | Raḥmat | رحمة | 19 |
/// | 7 | Kalimát | كلمات | 19 |
/// | 8 | Kamál | كمال | 19 |
/// | 9 | Asmáʼ | اسماء | 19 |
/// | 10 | ʻIzzat | عزة | 19 |
/// | 11 | Mas͟híyyat | مشية | 19 |
/// | 12 | ʻIlm | علم | 19 |
/// | 13 | Qudrat | قدرة | 19 |
/// | 14 | Qawl | قول | 19 |
/// | 15 | Masáʼil | مسائل | 19 |
/// | 16 | S͟haraf | شرف | 19 |
/// | 17 | Sulṭán | سلطان | 19 |
/// | 18 | Mulk | ملك | 19 |
/// | 19 | Ayyám-i-Há | ايام الهاء | 4 (5 in leap years) |
/// | 20 | ʻAláʼ | علاء | 19 |
///
/// The Baháʼí calendar epoch in the Gregorian calendar is March 21, 1844.
///
/// - seealso: [Baháʼí calendar](https://en.wikipedia.org/wiki/Baháʼí_calendar)
public struct BahaiCalendar: Calendar {
	/// The Julian day number of the epoch of the Baháʼí calendar.
	///
	/// This JDN corresponds to March 21, 1844 in the Gregorian calendar.
	public static let epoch: JulianDayNumber = 2394647

	/// The converter for the Baháʼí calendar.
	static let converter = JDNGregorianConverter(y: 6560, j: 1412, m: 19, n: 20, r: 4, p: 1461, q: 0, v: 3, u: 1, s: 19, t: 0, w: 0, A: 184, B: 274273, C: -50)

	public static func julianDayNumberFromDate(_ date: DateType) throws -> JulianDayNumber {
		try converter.julianDayNumberFromDate(date)
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) throws -> DateType {
		try converter.dateFromJulianDayNumber(J)
	}

	/// The number of months in one year.
	public static let numberOfMonthsInYear = 20

	/// The number of days in each month indexed from `0` (Bahá) to `19` (ʻAláʼ), with the epagomenal days (Ayyám-i-Há) treated as month `18`.
	static let monthLengths = [ 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 4, 19 ]

	/// Returns `true` if the specified year is a leap year in the Baháʼí calendar.
	///
	/// A Baháʼí year is a leap year if its numerical designation plus 1844 would be a leap year in the Gregorian calendar.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: `true` if the specified year is a leap year in the Baháʼí calendar.
	public static func isLeapYear(_ Y: Year) -> Bool {
		GregorianCalendar.isLeapYear(Y + 1844)
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

		if M == 19 {
			return isLeapYear(Y) ? 5 : 4
		} else {
			return monthLengths[M - 1]
		}
	}
}
