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
public struct CopticCalendar: Calendar {
	/// The Julian day number of the epoch of the Coptic calendar.
	///
	/// This JDN corresponds to August 29, 284 CE in the Julian calendar.
	public static let epoch: JulianDayNumber = 1825030

	/// The number of months in one year.
	public static let numberOfMonthsInYear = 13

	/// The number of days in each month indexed from `0` (Thout) to `12` (Pi Kogi Enavot).
	static let monthLengths = [ 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 5 ]

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

	public static func numberOfMonths(inYear Y: Year) -> Int {
		numberOfMonthsInYear
	}

	public static func numberOfDays(inYear Y: Year) -> Int {
		isLeapYear(Y) ? 366 : 365
	}

	public static func numberOfDaysIn(month M: Month, year Y: Int) -> Int {
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

extension CopticCalendar: JulianDayNumberConverting {
	/// The converter for the Coptic calendar.
	static let converter = JDNConverter(y: 4996, j: 124, m: 0, n: 13, r: 4, p: 1461, q: 0, v: 3, u: 1, s: 30, t: 0, w: 0)

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		converter.julianDayNumberFromDate(date)
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		converter.dateFromJulianDayNumber(J)
	}
}
