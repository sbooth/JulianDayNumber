//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// The Armenian calendar.
///
/// The Armenian calendar is a solar calendar of 365 days in every year.
///
/// The Armenian calendar epoch in the Julian calendar is July 11, 552.
///
/// - seealso: [Armenian calendar](https://en.wikipedia.org/wiki/Armenian_calendar)
public struct ArmenianCalendar {
	/// The Julian day number of the epoch of the Armenian calendar.
	///
	/// This JDN corresponds to noon on July 11, 552 in the Julian calendar.
	public static let epochJulianDayNumber: JulianDayNumber = 1922868

	/// The Julian date of the epoch of the Armenian calendar.
	///
	/// This JD corresponds to midnight on July 11, 552 in the Julian calendar.
	public static let epochJulianDate: JulianDate = 1922867.5

	/// A year in the Armenian calendar.
	public typealias Year = Int

	/// A month in the Armenian calendar numbered from `1` (Nawasardi) to `12` (Hrotich) with the five epagomenal days (Aweleach) treated as month `13`.
	public typealias Month = Int

	/// A day in the Armenian calendar numbered starting from `1`.
	public typealias Day = Int
}
