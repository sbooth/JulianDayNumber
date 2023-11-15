//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

extension EgyptianCalendar: JulianDayNumberConverting {
	/// A date in the Egyptian calendar consists of a year, month, and day.
	public typealias DateType = (year: Year, month: Month, day: Day)

	/// The intercalating cycle of the Egyptian calendar is 1 year of 365 days.
	static let intercalatingCycle = (years: 1, days: 365)

	/// The date for Julian day number zero in the proleptic Egyptian calendar.
	static let julianDayNumberZero = (year: -3968, month: 2, day: 2)

	/// Algorithm parameters for Egyptian calendar conversions.
	static let conversionParameters = JDNConversionParameters(y: 3968, j: 47, m: 0, n: 13, r: 1, p: 365, q: 0, v: 0, u: 1, s: 30, t: 0, w: 0)

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		jdnFromDate(date, conversionParameters: conversionParameters, jdnZero: julianDayNumberZero, intercalatingCycle: intercalatingCycle)
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		dateFromJDN(J, conversionParameters: conversionParameters, intercalatingCycle: intercalatingCycle)
	}
}
