//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// The administrative Babylonian calendar.
///
/// The true Babylonian calendar is a lunisolar calendar.
///
/// The Babylonian calendar epoch in the Julian calendar is April 3, 312 BCE.
///
/// - seealso: [Babylonian calendar](https://en.wikipedia.org/wiki/Babylonian_calendar)
public struct BabylonianCalendar {
	/// The Julian day number of the epoch of the Babylonian calendar.
	///
	/// This JDN corresponds to April 3, 312 BCE in the Julian calendar.
	public static let epoch: JulianDayNumber = 1607558

	/// A year in the Babylonian calendar.
	public typealias Year = Int

	/// A month in the Babylonian calendar numbered from `1`.
	public typealias Month = Int

	/// A day in the Babylonian calendar numbered starting from `1`.
	public typealias Day = Int
}

extension BabylonianCalendar: JulianDayNumberConverting {
	/// A date in the Babylonian calendar consists of a year, month, and day.
	public typealias DateType = (year: Year, month: Month, day: Day)

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		flooredQuotient(6940 * (flooredQuotient(235 * date.year + 13, dividedBy: 19) + date.month - 1), dividedBy: 235) + date.day + 1607174
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		let (m1, ε1) = flooredQuotientAndRemainder(235 * J - 377685891, dividedBy: 6940)
		let (a, ε2) = flooredQuotientAndRemainder(19 * m1 + 5, dividedBy: 235)
		let m = flooredQuotient(ε2, dividedBy: 19) + 1
		let d = flooredQuotient(ε1, dividedBy: 235) + 1
		return (a, m, d)
	}
}
