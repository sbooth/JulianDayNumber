//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

/// The Egyptian calendar is a solar calendar with 365 days in the year.
///
/// The year consists of twelve months having 30 days each. The twelfth month is followed by five epagomenal days.
///
/// | Month | Name | Days |
/// | ---: | --- | --- |
/// | 1 | Thoth | 30 |
/// | 2 | Phaophi | 30 |
/// | 3 | Athyr | 30 |
/// | 4 | Choiak | 30 |
/// | 5 | Tybi | 30 |
/// | 6 | Mechir | 30 |
/// | 7 | Phamenoth | 30 |
/// | 8 | Pharmuthi | 30 |
/// | 9 | Pachons | 30 |
/// | 10 | Payni | 30 |
/// | 11 | Epiphi | 30 |
/// | 12 | Mesore | 30 |
/// | 13 | | 5 |
///
/// The Egyptian calendar epoch in the Julian calendar is February 26, 747 BCE.
///
/// - seealso: [Egyptian calendar](https://en.wikipedia.org/wiki/Egyptian_calendar)
public struct EgyptianCalendar: Calendar {
	/// The Julian day number of the epoch of the Egyptian calendar.
	///
	/// This JDN corresponds to February 26, 747 BCE in the Julian calendar.
	public static let epoch: JulianDayNumber = 1448638

	/// The number of months in one year.
	public static let numberOfMonthsInYear = 13

	/// The number of days in one year.
	public static let numberOfDaysInYear = 365

	/// The number of days in each month indexed from `0` (Thoth) to `11` (Mesore), with the 5 epagomenal days treated as month `12`.
	static let monthLengths = [ 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 5 ]

	/// Returns the number of days in the specified month in the Egyptian calendar.
	///
	/// - parameter M: A month number.
	///
	/// - returns: The number of days in the specified month.
	public static func numberOfDays(inMonth M: Month) -> Int {
		guard M > 0, M <= numberOfMonthsInYear else {
			return 0
		}
		return monthLengths[M - 1]
	}

	public static func numberOfMonths(inYear Y: Year) -> Int {
		numberOfMonthsInYear
	}

	public static func numberOfDays(inYear Y: Year) -> Int {
		numberOfDaysInYear
	}

	public static func numberOfDaysIn(month M: Month, year Y: Year) -> Int {
		numberOfDays(inMonth: M)
	}
}

extension EgyptianCalendar: JulianDayNumberConverting {
	/// The converter for the Egyptian calendar.
	static let converter = JDNConverter(y: 3968, j: 47, m: 0, n: 13, r: 1, p: 365, q: 0, v: 0, u: 1, s: 30, t: 0, w: 0)

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		converter.julianDayNumberFromDate(date)
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		converter.dateFromJulianDayNumber(J)
	}
}
