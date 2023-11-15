//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

extension CopticCalendar: YearMonthDayJulianDayNumberConverting {
	/// A date in the Coptic calendar consists of a year, month, and day.
	public typealias DateType = (year: Year, month: Month, day: Day)

	/// The number of years in a cycle of the Coptic calendar.
	///
	/// A cycle in the Coptic calendar consists of 3 common years and 1 leap year.
	static let calendarCycleYears = 4

	/// The number of days in a cycle of the Coptic calendar.
	///
	/// A cycle in the Coptic calendar consists of 3 years of 365 days and 1 leap year of 366 days.
	static let calendarCycleDays = 1461

	/// The date for Julian day number zero in the proleptic Coptic calendar.
	static let julianDayNumberZero = (year: -4996, month: 5, day: 5)

	// Constants for Coptic calendar conversions
	static let y = 4996
	static let j = 124
	static let m = 0
	static let n = 13
	static let r = 4
	static let p = 1461
	static let q = 0
	static let v = 3
	static let u = 1
	static let s = 30
	static let t = 0
	static let w = 0
}
