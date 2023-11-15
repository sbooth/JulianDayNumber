//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

extension JulianCalendar: JulianDayNumberConverting {
	/// A date in the Julian calendar consists of a year, month, and day.
	public typealias DateType = (year: Year, month: Month, day: Day)

	/// The intercalating cycle of the Julian calendar is 3 common years of 365 days and 1 leap year of 366 days.
	static let intercalatingCycle = (years: 4, days: 1461)

	/// The date for Julian day number zero in the proleptic Julian calendar.
	static let julianDayNumberZero = (year: -4712, month: 1, day: 1)

	/// Algorithm parameters for Julian calendar conversions.
	static let conversionParameters = JDNConversionParameters(y: 4716, j: 1401, m: 2, n: 12, r: 4, p: 1461, q: 0, v: 3, u: 5, s: 153, t: 2, w: 2)

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		jdnFromDate(date, conversionParameters: conversionParameters, jdnZero: julianDayNumberZero, intercalatingCycle: intercalatingCycle)
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		dateFromJDN(J, conversionParameters: conversionParameters, intercalatingCycle: intercalatingCycle)
	}
}
