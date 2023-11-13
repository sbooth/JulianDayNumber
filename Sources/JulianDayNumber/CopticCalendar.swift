//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// The Coptic calendar.
///
/// The Coptic calendar is a solar calendar of 365 days in every year with an additional leap day every fourth year.
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

extension CopticCalendar {
	/// The months in the Coptic calendar.
	public enum MonthName: Int {
		/// Thout (Ⲑⲟⲟⲩⲧ), 30 days.
		case thout = 1
		/// Paopi (Ⲡⲁⲱⲡⲉ), 30 days.
		case paopi
		/// Hathor (Ϩⲁⲑⲱⲣ), 30 days.
		case hathor
		/// Koiak (Ⲕⲟⲓⲁϩⲕ), 30 days.
		case koiak
		/// Tobi (Ⲧⲱⲃⲉ), 30 days.
		case tobi
		/// Meshir (Ⲙϣⲓⲣ), 30 days.
		case meshir
		/// Paremhat (Ⲡⲁⲣⲙϩⲟⲧⲡ), 30 days.
		case paremhat
		/// Parmouti (Ⲡⲁⲣⲙⲟⲩⲧⲉ), 30 days.
		case parmouti
		/// Pashons (Ⲡⲁϣⲟⲛⲥ), 30 days.
		case pashons
		/// Paoni (Ⲡⲁⲱⲛⲉ), 30 days.
		case paoni
		/// Epip (Ⲉⲡⲏⲡ), 30 days.
		case epip
		/// Mesori (Ⲙⲉⲥⲱⲣⲏ), 30 days.
		case mesori
		/// Pi Kogi Enavot (Ⲉⲡⲁⲅⲟⲙⲉⲛⲁⲓ), 5 days (common year) or 6 days (leap year).
		case piKogiEnavot
	}
}
