//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// The Mayan calendar.
///
/// The Mayan calendar is a system of calendars consisting of several cycles of different lengths.
///
/// - seealso: [Maya calendar](https://en.wikipedia.org/wiki/Maya_calendar)
public struct MayanCalendar {
	/// The Julian day number of the Goodman-Martinez-Thompson correlation constant for the long count of the Mayan calendar.
	///
	/// This JDN corresponds to noon on September 6, 3114 BC in the Julian calendar.
	public static let longCountEpochJulianDayNumber: JulianDayNumber = 584283
}
