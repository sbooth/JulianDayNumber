//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

extension EthiopianCalendar: YearMonthDayJulianDayNumberConverting {
	/// A date in the Ethiopian calendar consists of a year, month, and day.
	public typealias DateType = (year: Year, month: Month, day: Day)

	/// The number of years in a cycle of the Ethiopian calendar.
	///
	/// A cycle in the Ethiopian calendar consists of 3 common years and 1 leap year.
	static let calendarCycleYears = 4

	/// The number of days in a cycle of the Ethiopian calendar.
	///
	/// A cycle in the Ethiopian calendar consists of 3 years of 365 days and 1 leap year of 366 days.
	static let calendarCycleDays = 1461

	/// The date for Julian day number zero in the proleptic Ethiopian calendar.
	static let julianDayNumberZero = (year: -4720, month: 5, day: 5)

	// Constants for Ethiopian calendar conversions
	static let y = 4720
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
