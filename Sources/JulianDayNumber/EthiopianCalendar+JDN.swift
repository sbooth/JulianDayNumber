//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

extension EthiopianCalendar: JulianDayNumberConverting {
	/// A date in the Ethiopian calendar consists of a year, month, and day.
	public typealias DateType = (year: Year, month: Month, day: Day)

	/// The intercalating cycle of the Ethiopian calendar is 3 common years of 365 days and 1 leap year of 366 days.
	static let intercalatingCycle = (years: 4, days: 1461)

	/// The date for Julian day number zero in the proleptic Ethiopian calendar.
	static let julianDayNumberZero = (year: -4720, month: 5, day: 5)

	/// Algorithm parameters for Ethiopian calendar conversions.
	static let conversionParameters = JDNConversionParameters(y: 4720, j: 124, m: 0, n: 13, r: 4, p: 1461, q: 0, v: 3, u: 1, s: 30, t: 0, w: 0)

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		jdnFromDate(date, conversionParameters: conversionParameters, jdnZero: julianDayNumberZero, intercalatingCycle: intercalatingCycle)
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		dateFromJDN(J, conversionParameters: conversionParameters, intercalatingCycle: intercalatingCycle)
	}
}
