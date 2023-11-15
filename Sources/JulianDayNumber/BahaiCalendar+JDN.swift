//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

extension BahaiCalendar: JulianDayNumberConverting {
	/// A date in the Baháʼí calendar consists of a year, month, and day.
	public typealias DateType = (year: Year, month: Month, day: Day)

	/// The intercalating cycle of the Baháʼí calendar is 303 common years of 365 days and 97 leap years of 366 days.
	static let intercalatingCycle = (years: 400, days: 146097)

	/// The date for Julian day number zero in the proleptic Baháʼí calendar.
	static let julianDayNumberZero = (year: -6556, month: 14, day: 2)

	/// Algorithm parameters for Baháʼí calendar conversions.
	static let conversionParameters = JDNConversionParameters(y: 6560, j: 1412, m: 19, n: 20, r: 4, p: 1461, q: 0, v: 3, u: 1, s: 19, t: 0, w: 0)

	/// Gregorian intercalating parameters for Baháʼí calendar conversions.
	static let gregorianIntercalatingParameters = JDNGregorianIntercalatingParameters(A: 184, B: 274273, C: -50)

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		jdnFromDate(date, conversionParameters: conversionParameters, gregorianIntercalatingParameters: gregorianIntercalatingParameters, jdnZero: julianDayNumberZero, intercalatingCycle: intercalatingCycle)
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		dateFromJDN(J, conversionParameters: conversionParameters, gregorianIntercalatingParameters: gregorianIntercalatingParameters, intercalatingCycle: intercalatingCycle)
	}
}
