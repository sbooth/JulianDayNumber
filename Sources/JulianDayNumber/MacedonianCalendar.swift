//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// The Macedonian calendar is a lunisolar calendar with 354 days in the year, with seven intercalary months added in each 19-year cycle.
///
/// The Macedonian calendar epoch in the Julian calendar is September 1, 312 BCE.
///
/// - seealso: [Macedonian calendar](https://en.wikipedia.org/wiki/Ancient_Macedonian_calendar)
public struct MacedonianCalendar {
	/// The Julian day number of the epoch of the Macedonian calendar.
	///
	/// This JDN corresponds to noon on September 1, 312 BCE in the Julian calendar.
	public static let epochJulianDayNumber: JulianDayNumber = 1607709

	/// The Julian date of the epoch of the Macedonian calendar.
	///
	/// This JD corresponds to midnight on September 1, 312 BCE in the Julian calendar.
	public static let epochJulianDate: JulianDate = 1607708.5

	/// A year in the Macedonian calendar.
	public typealias Year = Int

	/// A month in the Macedonian calendar numbered from `1`,
	public typealias Month = Int

	/// A day in the Macedonian calendar numbered starting from `1`.
	public typealias Day = Int
}
