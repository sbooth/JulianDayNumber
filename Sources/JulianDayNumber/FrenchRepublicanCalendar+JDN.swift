//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

extension FrenchRepublicanCalendar: GregorianIntercalatingJulianDayNumberConverting {
	/// A date in the French Republican calendar consists of a year, month, and day.
	public typealias DateType = (year: Year, month: Month, day: Day)

	/// The number of years in a cycle of the French Republican calendar.
	///
	/// A cycle in the modified French Republican calendar consists of 303 common years and 97 leap years.
	static let calendarCycleYears = 400

	/// The number of days in a cycle of the French Republican calendar.
	///
	/// A cycle in the modified French Republican calendar consists of 303 years of 365 days and 97 leap year of 366 days.
	static let calendarCycleDays = 146097

	/// The date for Julian day number zero in the proleptic French Republican calendar.
	static let julianDayNumberZero = (year: -6504, month: 3, day: 3)

	// Constants for French Republican calendar conversions
	static let y = 6504
	static let j = 111
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
	static let A = 396
	static let B = 578797
	static let C = -51
}
