//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// The modified French Republican calendar is an astronomical calendar with 365 days in the year plus an additional leap day in certain years.
///
/// The year began on the day of the autumnal equinox as observed in Paris.
///
/// The year consists of twelve months having 30 days each. The twelfth month is followed by five epagomenal days (Sansculottides) with a sixth in leap years.
///
/// | Month | Name | Days |
/// | ---: | --- | --- |
/// | 1 | Vendémiaire | 30 |
/// | 2 | Brumaire | 30 |
/// | 3 | Frimaire | 30 |
/// | 4 | Nivôse | 30 |
/// | 5 | Pluviôse | 30 |
/// | 6 | Ventôse | 30 |
/// | 7 | Germinal | 30 |
/// | 8 | Floréal | 30 |
/// | 9 | Prairial | 30 |
/// | 10 | Messidor | 30 |
/// | 11 | Thermidor | 30 |
/// | 12 | Fructidor | 30 |
/// | 13 | Sansculottides | 5 (6 in leap years) |
///
/// The French Republican calendar took effect on September 22, 1792 in the Gregorian calendar.
/// It was abolished by Napoleon in 1806.
///
/// The French Republican calendar epoch in the Gregorian calendar is September 22, 1792.
///
/// - seealso: [French Republican calendar](https://en.wikipedia.org/wiki/French_Republican_calendar)
public struct FrenchRepublicanCalendar {
	/// The Julian day number of the epoch of the French Republican calendar.
	///
	/// This JDN corresponds to September 22, 1792 in the Gregorian calendar.
	public static let epoch: JulianDayNumber = 2375840

	/// A year in the French Republican calendar.
	public typealias Year = Int

	/// A month in the French Republican calendar numbered from `1` (Vendémiaire) to `12` (Fructidor) with the epagomenal days (Sansculottides) treated as month `13`.
	public typealias Month = Int

	/// A day in the French Republican calendar numbered starting from `1`.
	public typealias Day = Int

	/// Returns `true` if the specified year, month, and day form a valid date in the French Republican calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	/// - parameter D: A day number.
	///
	/// - returns: `true` if the specified year, month, and day form a valid date in the French Republican calendar.
	public static func isDateValid(year Y: Year, month M: Month, day D: Day) -> Bool {
		M > 0 && M <= 13 && D > 0 && D <= daysInMonth(year: Y, month: M)
	}

	/// Returns `true` if the specified year is a leap year in the French Republican calendar.
	///
	/// A French Republican year is a leap year if its numerical designation plus one would be a leap year in the Gregorian calendar.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: `true` if the specified year is a leap year in the French Republican calendar.
	public static func isLeapYear(_ Y: Year) -> Bool {
		GregorianCalendar.isLeapYear(Y + 1)
	}

	/// The number of months in one year.
	public static let monthsInYear = 13

	/// The number of days in each month indexed from `0` (Vendémiaire) to `11` (Fructidor), with the epagomenal days (Sansculottides) treated as month `12`.
	static let monthLengths = [ 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 5 ]

	/// Returns the number of days in the specified month and year in the French Republican calendar.
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

extension FrenchRepublicanCalendar: JulianDayNumberConverting {
	/// A date in the French Republican calendar consists of a year, month, and day.
	public typealias DateType = (year: Year, month: Month, day: Day)

	/// The converter for the French Republican calendar.
	static let converter = JDNGregorianTypeConverter(y: 6504, j: 111, m: 0, n: 13, r: 4, p: 1461, q: 0, v: 3, u: 1, s: 30, t: 0, w: 0, A: 396, B: 578797, C: -51)

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		converter.julianDayNumberFromDate(date)
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		converter.dateFromJulianDayNumber(J)
	}
}
