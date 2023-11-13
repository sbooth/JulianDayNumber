//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// The Syrian calendar.
///
/// The Syrian calendar is a lunisolar calendar.
///
/// The Syrian calendar epoch in the Julian calendar is October 1, 312 BC.
///
/// - seealso: [Syrian calendar](https://en.wikipedia.org/wiki/Syrian_calendar)
public struct SyrianCalendar {
	/// The Julian day number of the epoch of the Syrian calendar.
	///
	/// This JDN corresponds to noon on October 1, 312 BC in the Julian calendar.
	public static let epochJulianDayNumber: JulianDayNumber = 1607739

	/// The Julian date of the epoch of the Syrian calendar.
	///
	/// This JD corresponds to midnight on October 1, 312 BC in the Julian calendar.
	public static let epochJulianDate: JulianDate = 1607738.5

	/// A year in the Syrian calendar.
	public typealias Year = Int

	/// A month in the Syrian calendar numbered from `1`.
	public typealias Month = Int

	/// A day in the Syrian calendar numbered starting from `1`.
	public typealias Day = Int
}
