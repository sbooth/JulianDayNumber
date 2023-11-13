//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// The Coptic calendar is a solar calendar of 365 days in every year with an additional leap day every fourth year.
///
/// | Month | Name | | Days |
/// | --- | --- | --- | --- |
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
/// | 13 | Pi Kogi Enavot | Ⲉⲡⲁⲅⲟⲙⲉⲛⲁⲓ | 5 (common year) / 6 (leap year) |
///
/// The Coptic calendar epoch in the Julian calendar is August 29, 284.
///
/// - seealso: [Coptic calendar](https://en.wikipedia.org/wiki/Coptic_calendar)
public struct CopticCalendar {
	/// The Julian day number of the epoch of the Coptic calendar.
	///
	/// This JDN corresponds to noon on August 29, 284 in the Julian calendar.
	public static let epochJulianDayNumber: JulianDayNumber = 1825030

	/// The Julian date of the epoch of the Coptic calendar.
	///
	/// This JD corresponds to midnight on August 29, 284 in the Julian calendar.
	public static let epochJulianDate: JulianDate = 1825029.5

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
