//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

extension GregorianCalendar: JulianDayNumberConverting {
	/// A date in the Gregorian calendar consists of a year, month, and day.
	public typealias DateType = JulianCalendar.DateType

	/// The intercalating cycle of the Gregorian calendar is 303 common years of 365 days and 97 leap years of 366 days.
	static let intercalatingCycle = (years: 400, days: 146097)

	/// The date for Julian day number zero in the proleptic Gregorian calendar.
	static let julianDayNumberZero = (year: -4713, month: 11, day: 24)

	/// Algorithm parameters for Gregorian calendar conversions.
	static let conversionParameters = JDNConversionParameters(y: 4716, j: 1401, m: 2, n: 12, r: 4, p: 1461, q: 0, v: 3, u: 5, s: 153, t: 2, w: 2)

	/// Gregorian intercalating parameters for Gregorian calendar conversions.
	static let gregorianIntercalatingParameters = JDNGregorianIntercalatingParameters(A: 184, B: 274277, C: -38)

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		jdnFromDate(date, conversionParameters: conversionParameters, gregorianIntercalatingParameters: gregorianIntercalatingParameters, jdnZero: julianDayNumberZero, intercalatingCycle: intercalatingCycle)
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		dateFromJDN(J, conversionParameters: conversionParameters, gregorianIntercalatingParameters: gregorianIntercalatingParameters, intercalatingCycle: intercalatingCycle)
	}
}
