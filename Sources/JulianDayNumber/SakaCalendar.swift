//
// SPDX-FileCopyrightText: 2021 Stephen F. Booth <contact@sbooth.dev>
// SPDX-License-Identifier: MIT
//
// Part of https://github.com/sbooth/JulianDayNumber
//

/// The Śaka calendar is a solar calendar with 365 days in the year plus an additional leap day in certain years.
///
/// The year consists of twelve months. The first month contains an additional day in leap years.
///
/// | Month | Name | | Days |
/// | ---: | --- | --- | --- |
/// | 1 | Chaitra | चैत्र | 30 (31 in leap years) |
/// | 2 | Vaiśākha | वैशाख | 31 |
/// | 3 | Jyēṣṭha | ज्येष्ठ | 31 |
/// | 4 | Āshādha | आषाढ | 31 |
/// | 5 | Śrāvana | श्रावण | 31 |
/// | 6 | Bhādra | भाद्रपद | 31 |
/// | 7 | Āśvin | अश्विन् | 30 |
/// | 8 | Kārtika | कार्तिक | 31 |
/// | 9 | Mārgaśīrṣa | अग्रहायण | 30 |
/// | 10 | Pauṣa | पौष | 30 |
/// | 11 | Māgha | माघ | 30 |
/// | 12 | Phālguna | फाल्गुन | 30 |
///
/// The Śaka calendar took effect on March 22, 1957 in the Gregorian calendar.
///
/// The Śaka calendar epoch in the Julian calendar is March 24, 79 CE.
///
/// - seealso: [Indian national calendar](https://en.wikipedia.org/wiki/Indian_national_calendar)
public struct SakaCalendar: Calendar {
	/// The Julian day number of the epoch of the Śaka calendar.
	///
	/// This JDN corresponds to March 24, 79 CE in the Julian calendar.
	public static let epoch: JulianDayNumber = 1749995

	/// The converter for the Śaka calendar.
	static let converter = JDNSakaConverter()

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		converter.julianDayNumberFromDate(date)
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		converter.dateFromJulianDayNumber(J)
	}

	/// The Julian day number when the Śaka calendar took effect.
	///
	/// This JDN corresponds to March 22, 1957 in the Gregorian calendar.
	public static let effectiveJulianDayNumber: JulianDayNumber = 2435920

	/// The number of months in one year.
	public static let numberOfMonthsInYear = 12

	/// The number of days in each month indexed from `0` (Chaitra) to `11` (Phālguna).
	static let monthLengths = [ 30, 31, 31, 31, 31, 31, 30, 30, 30, 30, 30, 30 ]

	/// Returns `true` if the specified Julian day number occurred before the Śaka calendar took effect.
	///
	/// The Śaka calendar took effect on JDN 2435920.
	///
	/// - parameter julianDayNumber: A Julian day number.
	///
	/// - returns: `true` if the specified specified Julian day number occurred before the Śaka calendar took effect.
	public static func isProleptic(julianDayNumber: JulianDayNumber) -> Bool {
		julianDayNumber < effectiveJulianDayNumber
	}

	/// Returns `true` if the specified year is a leap year in the Śaka calendar.
	///
	/// A Śaka year is a leap year if its numerical designation plus 78 would be a leap year in the Gregorian calendar.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: `true` if the specified year is a leap year in the Śaka calendar.
	public static func isLeapYear(_ Y: Year) -> Bool {
		let maxY = .max - 78
		if Y > maxY {
			return GregorianCalendar.isLeapYear(Y + (78 - 400))
		} else {
			return GregorianCalendar.isLeapYear(Y + 78)
		}
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

		if M == 1 {
			return isLeapYear(Y) ? 31 : 30
		} else {
			return monthLengths[M - 1]
		}
	}
}
