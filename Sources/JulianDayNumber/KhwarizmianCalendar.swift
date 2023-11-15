//
//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// The Khwarizmian calendar is a solar calendar with 365 days in the year.
///
/// The year consists of twelve months having 30 days each. The twelfth month is followed by five epagomenal days.
///
/// | Month | Days |
/// | ---: | --- |
/// | 1 | 30 |
/// | 2 | 30 |
/// | 3 | 30 |
/// | 4 | 30 |
/// | 5 | 30 |
/// | 6 | 30 |
/// | 7 | 30 |
/// | 8 | 30 |
/// | 9 | 30 |
/// | 10 | 30 |
/// | 11 | 30 |
/// | 12 | 30 |
/// | 13 | 5 |
///
/// The Khwarizmian calendar epoch in the Julian calendar is June 21, 632 CE.
public struct KhwarizmianCalendar {
	/// The Julian day number of the epoch of the Khwarizmian calendar.
	///
	/// This JDN corresponds to noon on June 21, 632 CE in the Julian calendar.
	public static let epochJulianDayNumber: JulianDayNumber = 1952068

	/// The Julian date of the epoch of the Khwarizmian calendar.
	///
	/// This JD corresponds to midnight on June 21, 632 CE in the Julian calendar.
	public static let epochJulianDate: JulianDate = 1952067.5

	/// A year in the Khwarizmian calendar.
	public typealias Year = Int

	/// A month in the Khwarizmian calendar numbered from `1`.
	public typealias Month = Int

	/// A day in the Khwarizmian calendar numbered starting from `1`.
	public typealias Day = Int


	/// Returns `true` if the specified year, month, and day form a valid date in the Khwarizmian calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	/// - parameter D: A day number.
	///
	/// - returns: `true` if the specified year, month, and day form a valid date in the Khwarizmian calendar.
	public static func isDateValid(year Y: Year, month M: Month, day D: Day) -> Bool {
		M > 0 && M <= 13 && D > 0 && D <= daysInMonth(M)
	}

	/// The number of months in one year.
	public static let monthsInYear = 13

	/// The number of days in each month indexed from `0` (?) to `11` (?), with the epagomenal days (?) treated as month `12`.
	static let monthLengths = [ 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 5 ]

	/// Returns the number of days in the specified month in the Khwarizmian calendar.
	///
	/// - parameter M: A month number.
	///
	/// - returns: The number of days in the specified month.
	public static func daysInMonth(_ M: Month) -> Int {
		guard M > 0, M <= 13 else {
			return 0
		}
		return monthLengths[M - 1]
	}
}

extension KhwarizmianCalendar: JulianDayNumberConverting {
	/// A date in the Khwarizmian calendar consists of a year, month, and day.
	public typealias DateType = (year: Year, month: Month, day: Day)

	/// The date for Julian day number zero in the proleptic Khwarizmian calendar.
	static let julianDayNumberZero = (year: -5348, month: 11, day: 18)

	/// Algorithm parameters for Khwarizmian calendar conversions.
	static let conversionParameters = JDNConversionParameters(y: 5348, j: 317, m: 0, n: 13, r: 1, p: 365, q: 0, v: 0, u: 1, s: 30, t: 0, w: 0)

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		jdnFromDate(date, conversionParameters: conversionParameters, jdnZero: julianDayNumberZero)
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		dateFromJDN(J, conversionParameters: conversionParameters)
	}
}
