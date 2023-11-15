//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

extension IslamicCalendar: JulianDayNumberConverting {
	/// A date in the Islamic calendar consists of a year, month, and day.
	public typealias DateType = (year: Year, month: Month, day: Day)

	/// The intercalating cycle of the Islamic calendar is 19 common years of 354 days and 11 leap years of 355 days.
	static let intercalatingCycle = (years: 30, days: 10631)

	/// The date for Julian day number zero in the proleptic Islamic calendar.
	static let julianDayNumberZero = (year: -5498, month: 8, day: 16)

	/// Algorithm parameters for Islamic calendar conversions.
	static let conversionParameters = JDNConversionParameters(y: 5519, j: 7664, m: 0, n: 12, r: 30, p: 10631, q: 14, v: 15, u: 100, s: 2951, t: 51, w: 10)

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		jdnFromDate(date, conversionParameters: conversionParameters, jdnZero: julianDayNumberZero, intercalatingCycle: intercalatingCycle)
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		dateFromJDN(J, conversionParameters: conversionParameters, intercalatingCycle: intercalatingCycle)
	}
}
