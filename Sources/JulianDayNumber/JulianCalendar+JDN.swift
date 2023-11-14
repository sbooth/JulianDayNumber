//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

extension JulianCalendar: YearMonthDayJulianDayNumberConverting {
	/// A date in the Julian calendar consists of a year, month, and day.
	public typealias DateType = (year: Year, month: Month, day: Day)

	/// The number of years in a cycle of the Julian calendar.
	///
	/// A cycle in the Julian calendar consists of 3 common years and 1 leap year.
	static let calendarCycleYears = 4

	/// The number of days in a cycle of the Julian calendar.
	///
	/// A cycle in the Julian calendar consists of 3 years of 365 days and 1 leap year of 366 days.
	static let calendarCycleDays = 1461

	/// The date for Julian day number zero in the proleptic Julian calendar
	static let julianDayNumberZero = (year: -4712, month: 1, day: 1)

	// Constants for Julian calendar conversions
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
}
