//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// The Syrian calendar is a solar calendar with 365 days in the year plus an additional leap day every fourth year.
///
/// The year consists of twelve months. The sixth month contains an additional day in leap years.
///
/// | Month | Days |
/// | ---: | --- |
/// | 1 | 30 |
/// | 2 | 31 |
/// | 3 | 30 |
/// | 4 | 31 |
/// | 5 | 31 |
/// | 6 | 28 (29 in leap years) |
/// | 7 | 31 |
/// | 8 | 30 |
/// | 9 | 31 |
/// | 10 | 30 |
/// | 11 | 31 |
/// | 12 | 31 |
///
/// The Syrian calendar epoch in the Julian calendar is October 1, 312 BCE.
///
/// - seealso: [Syrian calendar](https://en.wikipedia.org/wiki/Syrian_calendar)
public struct SyrianCalendar {
	/// The Julian day number of the epoch of the Syrian calendar.
	///
	/// This JDN corresponds to noon on October 1, 312 BCE in the Julian calendar.
	public static let epochJulianDayNumber: JulianDayNumber = 1607739

	/// The Julian date of the epoch of the Syrian calendar.
	///
	/// This JD corresponds to midnight on October 1, 312 BCE in the Julian calendar.
	public static let epochJulianDate: JulianDate = 1607738.5

	/// A year in the Syrian calendar.
	public typealias Year = Int

	/// A month in the Syrian calendar numbered from `1`.
	public typealias Month = Int

	/// A day in the Syrian calendar numbered starting from `1`.
	public typealias Day = Int
}

extension SyrianCalendar: JulianDayNumberConverting {
	/// A date in the Syrian calendar consists of a year, month, and day.
	public typealias DateType = (year: Year, month: Month, day: Day)

	/// The converter for the Syrian calendar.
	static let converter = JDNConverter(y: 4405, j: 1401, m: 5, n: 12, r: 4, p: 1461, q: 0, v: 3, u: 5, s: 153, t: 2, w: 2)

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		converter.julianDayNumberFromDate(date)
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		converter.dateFromJulianDayNumber(J)
	}
}

