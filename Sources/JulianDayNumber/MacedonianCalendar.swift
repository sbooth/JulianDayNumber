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

extension MacedonianCalendar: JulianDayNumberConverting {
	/// A date in the Macedonian calendar consists of a year, month, and day.
	public typealias DateType = (year: Year, month: Month, day: Day)

	/// The converter for the Macedonian calendar.
	static let converter = JDNConverter(y: 4405, j: 1401, m: 6, n: 12, r: 4, p: 1461, q: 0, v: 3, u: 5, s: 153, t: 2, w: 2)

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		converter.julianDayNumberFromDate(date)
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		converter.dateFromJulianDayNumber(J)
	}
}
