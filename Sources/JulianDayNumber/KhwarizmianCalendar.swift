//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

/// The Khwarizmian calendar is a solar calendar with 365 days in the year.
///
/// The year consists of twelve months having 30 days each. The twelfth month is followed by five epagomenal days.
///
/// | Month | Days |
/// | ---: | --- |
/// | 1 | 30 |
/// | 2 | 30 |
/// | 3 | 30 |
/// | 4 | 30 |
/// | 5 | 30 |
/// | 6 | 30 |
/// | 7 | 30 |
/// | 8 | 30 |
/// | 9 | 30 |
/// | 10 | 30 |
/// | 11 | 30 |
/// | 12 | 30 |
/// | 13 | 5 |
///
/// The Khwarizmian calendar epoch in the Julian calendar is June 21, 632 CE.
public struct KhwarizmianCalendar: Calendar {
	/// The Julian day number of the epoch of the Khwarizmian calendar.
	///
	/// This JDN corresponds to June 21, 632 CE in the Julian calendar.
	public static let epoch: JulianDayNumber = 1952068

	/// The number of months in one year.
	public static let numberOfMonthsInYear = 13

	/// The number of days in one year.
	public static let numberOfDaysInYear = 365

	/// Returns the number of days in the specified month in the Khwarizmian calendar.
	///
	/// - parameter M: A month number.
	///
	/// - returns: The number of days in the specified month.
	public static func numberOfDays(inMonth M: Month) -> Int {
		switch M {
		case 1...12:
			return 30
		case 13:
			return 5
		default:
			return 0
		}
	}

	public static func isValidDate(_ date: (year: Int, month: Int, day: Int)) -> Bool {
		date.month > 0 && date.month <= 13 && date.day > 0 && date.day <= numberOfDays(inMonth: date.month)
	}

	public static func numberOfMonths(inYear Y: Year) -> Int {
		numberOfMonthsInYear
	}

	public static func numberOfDays(inYear Y: Year) -> Int {
		numberOfDaysInYear
	}

	public static func numberOfDaysIn(month M: Month, year Y: Int) -> Int {
		numberOfDays(inMonth: M)
	}
}

extension KhwarizmianCalendar: JulianDayNumberConverting {
	/// The converter for the Khwarizmian calendar.
	static let converter = JDNConverter(y: 5348, j: 317, m: 0, n: 13, r: 1, p: 365, q: 0, v: 0, u: 1, s: 30, t: 0, w: 0)

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		converter.julianDayNumberFromDate(date)
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		converter.dateFromJulianDayNumber(J)
	}
}
