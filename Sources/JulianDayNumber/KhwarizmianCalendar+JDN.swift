//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

extension KhwarizmianCalendar: YearMonthDayJulianDayNumberConverting {
	/// A date in the Khwarizmian calendar consists of a year, month, and day.
	public typealias DateType = (year: Year, month: Month, day: Day)

	/// The number of years in a cycle of the Khwarizmian calendar.
	///
	/// A cycle in the Khwarizmian calendar consists of 1 year.
	static let calendarCycleYears = 1

	/// The number of days in a cycle of the Khwarizmian calendar.
	///
	/// A cycle in the Khwarizmian calendar consists of 1 year of 365 days.
	static let calendarCycleDays = 365

	/// The date for Julian day number zero in the proleptic Julian calendar.
	static let julianDayNumberZero = (year: -5348, month: 11, day: 18)

	// Constants for Khwarizmian calendar conversions
	static let y = 5348
	static let j = 317
	static let m = 0
	static let n = 13
	static let r = 1
	static let p = 365
	static let q = 0
	static let v = 0
	static let u = 1
	static let s = 30
	static let t = 0
	static let w = 0
}
