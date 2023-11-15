//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

extension GregorianCalendar: GregorianIntercalatingJulianDayNumberConverting {
	/// A date in the Gregorian calendar consists of a year, month, and day.
	public typealias DateType = JulianCalendar.DateType

	/// The number of years in a cycle of the Gregorian calendar.
	///
	/// A cycle in the Gregorian calendar consists of 303 common years and 97 leap years.
	static let calendarCycleYears = 400

	/// The number of days in a cycle of the Gregorian calendar.
	///
	/// A cycle in the Gregorian calendar consists of 303 years of 365 days and 97 leap year of 366 days.
	static let calendarCycleDays = 146097

	/// The date for Julian day number zero in the proleptic Gregorian calendar
	static let julianDayNumberZero = (year: -4713, month: 11, day: 24)

	// Constants for Gregorian calendar conversions
	static let y = 4716
	static let j = 1401
	static let m = 2
	static let n = 12
	static let r = 4
	static let p = 1461
	static let q = 0
	static let v = 3
	static let u = 5
	static let s = 153
	static let t = 2
	static let w = 2
	static let A = 184
	static let B = 274277
	static let C = -38
}
