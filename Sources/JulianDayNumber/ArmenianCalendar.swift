//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// The Armenian calendar is a solar calendar with 365 days in the year.
///
/// The year consists of twelve months having 30 days each. The twelfth month is followed by five epagomenal days (Aweleach).
///
/// | Month | Name | | Days |
/// | ---: | --- | --- | --- |
/// | 1 | Nawasardi | նաւասարդ | 30 |
/// | 2 | Hoṙi | հոռի | 30 |
/// | 3 | Sahmi | սահմի | 30 |
/// | 4 | Trē | տրէ | 30 |
/// | 5 | Kʿałoch | քաղոց | 30 |
/// | 6 | Arach | արաց | 30 |
/// | 7 | Mehekani | մեհեկան | 30 |
/// | 8 | Areg | արեգ | 30 |
/// | 9 | Ahekani | ահեկան | 30 |
/// | 10 | Mareri | մարերի | 30 |
/// | 11 | Margach | մարգաց | 30 |
/// | 12 | Hrotich | հրոտից | 30 |
/// | 13 | Aweleach | աւելեաց | 5 |
///
/// The Armenian calendar epoch in the Julian calendar is July 11, 552 CE.
///
/// - seealso: [Armenian calendar](https://en.wikipedia.org/wiki/Armenian_calendar)
public struct ArmenianCalendar {
	/// The Julian day number of the epoch of the Armenian calendar.
	///
	/// This JDN corresponds to noon on July 11, 552 CE in the Julian calendar.
	public static let epochJulianDayNumber: JulianDayNumber = 1922868

	/// The Julian date of the epoch of the Armenian calendar.
	///
	/// This JD corresponds to midnight on July 11, 552 CE in the Julian calendar.
	public static let epochJulianDate: JulianDate = 1922867.5

	/// A year in the Armenian calendar.
	public typealias Year = Int

	/// A month in the Armenian calendar numbered from `1` (Nawasardi) to `12` (Hrotich) with the five epagomenal days (Aweleach) treated as month `13`.
	public typealias Month = Int

	/// A day in the Armenian calendar numbered starting from `1`.
	public typealias Day = Int

	/// Returns `true` if the specified year, month, and day form a valid date in the Armenian calendar.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	/// - parameter D: A day number.
	///
	/// - returns: `true` if the specified year, month, and day form a valid date in the Armenian calendar.
	public static func isDateValid(year Y: Year, month M: Month, day D: Day) -> Bool {
		M > 0 && M <= 13 && D > 0 && D <= daysInMonth(M)
	}

	/// The number of months in one year.
	public static let monthsInYear = 13

	/// The number of days in each month indexed from `0` (Nawasardi) to `11` (Hrotich), with the epagomenal days (Aweleach) treated as month `12`.
	static let monthLengths = [ 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 5 ]

	/// Returns the number of days in the specified month in the Armenian calendar.
	///
	/// - parameter M: A month number.
	///
	/// - returns: The number of days in the specified month.
	public static func daysInMonth(_ M: Month) -> Int {
		guard M > 0, M <= 13 else {
			return 0
		}
		return monthLengths[M - 1]
	}
}
