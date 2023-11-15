//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

extension BahaiCalendar: GregorianIntercalatingJulianDayNumberConverting {
	/// A date in the Baháʼí calendar consists of a year, month, and day.
	public typealias DateType = (year: Year, month: Month, day: Day)

	/// The number of years in a cycle of the Baháʼí calendar.
	///
	/// A cycle in the Baháʼí calendar consists of 303 common years and 97 leap years.
	static let calendarCycleYears = 400

	/// The number of days in a cycle of the Baháʼí calendar.
	///
	/// A cycle in the Baháʼí calendar consists of 303 years of 365 days and 97 leap year of 366 days.
	static let calendarCycleDays = 146097

	/// The date for Julian day number zero in the Baháʼí Gregorian calendar.
	static let julianDayNumberZero = (year: -6556, month: 14, day: 2)

	// Constants for Baháʼí calendar conversions
	static let y = 6560
	static let j = 1412
	static let m = 19
	static let n = 20
	static let r = 4
	static let p = 1461
	static let q = 0
	static let v = 3
	static let u = 1
	static let s = 19
	static let t = 0
	static let w = 0
	static let A = 184
	static let B = 274273
	static let C = -50
}
