//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

extension IslamicCalendar: YearMonthDayJulianDayNumberConverting {
	/// A date in the Islamic calendar consists of a year, month, and day.
	public typealias DateType = (year: Year, month: Month, day: Day)

	/// The number of years in a cycle of the Islamic calendar.
	///
	/// A cycle in the Islamic calendar consists of 19 common years and 11 leap years.
	static let calendarCycleYears = 30

	/// The number of days in a cycle of the Islamic calendar.
	///
	/// A cycle in the Islamic calendar consists of 19 years of 354 days and 11 leap years of 355 days.
	static let calendarCycleDays = 10631

	/// The date for Julian day number zero in the proleptic Julian calendar.
	static let julianDayNumberZero = (year: -5498, month: 8, day: 16)

	// Constants for Islamic calendar conversions
	static let y = 5519
	static let j = 7664
	// Islamic A is identical except j = 7665
	static let m = 0
	static let n = 12
	static let r = 30
	static let p = 10631
	static let q = 14
	static let v = 15
	static let u = 100
	static let s = 2951
	static let t = 51
	static let w = 10
}
