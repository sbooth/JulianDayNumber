//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

/// The Coptic calendar is a solar calendar with 365 days in the year plus an additional leap day every fourth year.
///
/// The year consists of twelve months having 30 days each. The twelfth month is followed by five epagomenal days (Pi Kogi Enavot) with a sixth in leap years.
///
/// | Month | Name | | Days |
/// | ---: | --- | --- | --- |
/// | 1 | Thout | Ⲑⲟⲟⲩⲧ | 30 |
/// | 2 | Paopi | Ⲡⲁⲱⲡⲉ | 30 |
/// | 3 | Hathor | Ϩⲁⲑⲱⲣ | 30 |
/// | 4 | Koiak | Ⲕⲟⲓⲁϩⲕ | 30 |
/// | 5 | Tobi | Ⲧⲱⲃⲉ | 30 |
/// | 6 | Meshir | Ⲙϣⲓⲣ | 30 |
/// | 7 | Paremhat | Ⲡⲁⲣⲙϩⲟⲧⲡ | 30 |
/// | 8 | Parmouti | Ⲡⲁⲣⲙⲟⲩⲧⲉ | 30 |
/// | 9 | Pashons | Ⲡⲁϣⲟⲛⲥ | 30 |
/// | 10 | Paoni | Ⲡⲁⲱⲛⲉ | 30 |
/// | 11 | Epip | Ⲉⲡⲏⲡ | 30 |
/// | 12 | Mesori | Ⲙⲉⲥⲱⲣⲏ | 30 |
/// | 13 | Pi Kogi Enavot | Ⲉⲡⲁⲅⲟⲙⲉⲛⲁⲓ | 5 (6 in leap years) |
///
/// The Coptic calendar epoch in the Julian calendar is August 29, 284 CE.
///
/// - seealso: [Coptic calendar](https://en.wikipedia.org/wiki/Coptic_calendar)
public struct CopticCalendar {
	/// The Julian day number of the epoch of the Coptic calendar.
	///
	/// This JDN corresponds to August 29, 284 CE in the Julian calendar.
	public static let epoch: JulianDayNumber = 1825030

	/// A year in the Coptic calendar.
	public typealias Year = Int

	/// A month in the Coptic calendar numbered from `1` (Thout) to `13` (Pi Kogi Enavot).
	public typealias Month = Int

	/// A day in the Coptic calendar numbered starting from `1`.
	public typealias Day = Int

	/// Returns `true` if the specified year, month, and day form a valid date in the Coptic calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	/// - parameter D: A day number.
	///
	/// - returns: `true` if the specified year, month, and day form a valid date in the Coptic calendar.
	public static func isDateValid(year Y: Year, month M: Month, day D: Day) -> Bool {
		M > 0 && M <= 13 && D > 0 && D <= daysInMonth(year: Y, month: M)
	}

	/// Returns `true` if the specified year is a leap year in the Coptic calendar.
	///
	/// A Coptic leap year occurs every four years and the first leap year was year 3.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: `true` if the specified year is a leap year in the Coptic calendar.
	public static func isLeapYear(_ Y: Year) -> Bool {
		Y > 0 ? Y % 4 == 3 : Y % 4 == -1
	}

	/// The number of months in one year.
	public static let monthsInYear = 13

	/// Returns the number of days in the specified year in the Coptic calendar.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: The number of days in the specified year.
	public static func daysInYear(_ Y: Year) -> Int {
		isLeapYear(Y) ? 366 : 365
	}

	/// The number of days in each month indexed from `0` (Thout) to `12` (Pi Kogi Enavot).
	static let monthLengths = [ 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 5 ]

	/// Returns the number of days in the specified month and year in the Coptic calendar.
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

extension CopticCalendar: JulianDayNumberConverting {
	/// A date in the Coptic calendar consists of a year, month, and day.
	public typealias DateType = (year: Year, month: Month, day: Day)

	/// The converter for the Coptic calendar.
	static let converter = JDNConverter(y: 4996, j: 124, m: 0, n: 13, r: 4, p: 1461, q: 0, v: 3, u: 1, s: 30, t: 0, w: 0)

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		converter.julianDayNumberFromDate(date)
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		converter.dateFromJulianDayNumber(J)
	}
}
