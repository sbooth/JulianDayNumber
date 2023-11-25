//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// The Macedonian calendar is a solar calendar with 365 days in the year plus an additional leap day every fourth year.
///
/// The year consists of twelve months. The sixth month contains an additional day in leap years.
///
/// | Month | Name | Days |
/// | ---: | --- | --- |
/// | 1 | September | 30 |
/// | 2 | October | 31 |
/// | 3 | November | 30 |
/// | 4 | December | 31 |
/// | 5 | January | 31 |
/// | 6 | February | 28 (29 in leap years) |
/// | 7 | March | 31 |
/// | 8 | April | 30 |
/// | 9 | May | 31 |
/// | 10 | June | 30 |
/// | 11 | July | 31 |
/// | 12 | August | 31 |
///
/// The Macedonian calendar epoch in the Julian calendar is September 1, 312 BCE.
///
/// - seealso: [Macedonian calendar](https://en.wikipedia.org/wiki/Ancient_Macedonian_calendar)
public struct MacedonianCalendar {
	/// The Julian day number of the epoch of the Macedonian calendar.
	///
	/// This JDN corresponds to September 1, 312 BCE in the Julian calendar.
	public static let epoch: JulianDayNumber = 1607709

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
