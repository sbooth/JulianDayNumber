//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// The Khwarizmian calendar is a solar calendar with 365 days in the year.
///
/// The year consists of twelve months having 30 days each.  The twelfth month is followed by five epagomenal days.
///
/// The Khwarizmian calendar epoch in the Julian calendar is June 21, 632 CE.
public struct KhwarizmianCalendar {
	/// The Julian day number of the epoch of the Khwarizmian calendar.
	///
	/// This JDN corresponds to noon on June 21, 632 CE in the Julian calendar.
	public static let epochJulianDayNumber: JulianDayNumber = 1952068

	/// The Julian date of the epoch of the Khwarizmian calendar.
	///
	/// This JD corresponds to midnight on June 21, 632 CE in the Julian calendar.
	public static let epochJulianDate: JulianDate = 1952067.5

	/// A year in the Khwarizmian calendar.
	public typealias Year = Int

	/// A month in the Khwarizmian calendar numbered from `1`.
	public typealias Month = Int

	/// A day in the Khwarizmian calendar numbered starting from `1`.
	public typealias Day = Int
}
