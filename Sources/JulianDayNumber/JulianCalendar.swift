//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

/// The Julian calendar is a solar calendar with 365 days in the year plus an additional leap day every fourth year.
///
/// The year consists of twelve months. The second month contains an additional day in leap years.
///
/// | Month | Name | Days |
/// | ---: | --- | --- |
/// | 1 | January | 31 |
/// | 2 | February | 28 (29 in leap years) |
/// | 3 | March | 31 |
/// | 4 | April | 30 |
/// | 5 | May | 31 |
/// | 6 | June | 30 |
/// | 7 | July | 31 |
/// | 8 | August | 31 |
/// | 9 | September | 30 |
/// | 19 | October | 31 |
/// | 11 | November | 30 |
/// | 12 | December | 31 |
///
/// The Julian calendar took effect on January 1, 45 BCE.
///
/// The Julian calendar epoch in the Julian calendar is January 1, 1 CE.
///
/// - seealso: [Julian calendar](https://en.wikipedia.org/wiki/Julian_calendar)
public struct JulianCalendar: Calendar {
	/// The Julian day number of the epoch of the Julian calendar.
	///
	/// This JDN corresponds to January 1, 1 CE in the Julian calendar.
	public static let epoch: JulianDayNumber = 1721424

	/// The recurrence (solar) cycle of the Julian calendar is 21 common years of 365 days and 7 leap years of 366 days.
	static let recurrenceCycle = (years: 28, days: 10227)

	/// The Julian calendar date corresponding to JDN 0.
	static let jdnZero: DateType = (-4712, 1, 1)

#if _pointerBitWidth(_64)
	// The Julian calendar date corresponding to JDN `Int64.max`
	static let upperLimit: DateType = (25252216391110348, 5, 22)
	// The Julian calendar date corresponding to JDN `Int64.min`
	static let lowerLimit: DateType = (-25252216391119773, 8, 11)
#elseif _pointerBitWidth(_32)
	// The Julian calendar date corresponding to JDN `Int32.max`
	static let upperLimit: DateType = (5874777, 10, 17)
	// The Julian calendar date corresponding to JDN `Int32.min`
	static let lowerLimit: DateType = (-5884202, 3, 16)
#else
#error("Unsupported pointer bit width")
#endif

	// These algorithms are valid for all Julian calendar dates
	// corresponding to JDN ≥ 0.
	//
	// The formula for computing JDN from Y, M, D was constructed by
	// Fliegel (1990) as an entry in "The Great Julian Day Contest"
	// held at the Jet Propulsion Laboratory in 1970.

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
//		guard date <= upperLimit else { return .max }
//		guard date >= lowerLimit else { return .min }

		// Years greater than `maxY` cause arithmetic overflow
		// when computing `J` even when the final result is ≤ `.max`
		let maxY = .max / 367

		var Y = date.year
		var cycles = 0
		var adjustment = TemporalTranslation.none

		// Translate out-of-range dates into the valid range using
		// multiples of the Julian calendar's 28 year recurrence cycle
		if Y > maxY {
			adjustment = .negative
			cycles = (Y - maxY) / recurrenceCycle.years
			Y -= cycles * recurrenceCycle.years + recurrenceCycle.years
		} else if Y < jdnZero.year {
			adjustment = .positive
			cycles = (Y - jdnZero.year) / -recurrenceCycle.years
			Y += cycles * recurrenceCycle.years + recurrenceCycle.years
		}

		var J = 367 * Y
				- (7 * (Y + 5001 + (date.month - 9) / 7)) / 4
				+ (275 * date.month) / 9
				+ date.day
				+ 1729777

		if adjustment == .negative {
			J += cycles * recurrenceCycle.days
			J += recurrenceCycle.days
		} else if adjustment == .positive {
			J -= cycles * recurrenceCycle.days
			J -= recurrenceCycle.days
		}

		return J
	}

	public static func dateFromJulianDayNumber(_ JD: JulianDayNumber) -> DateType {
		// JDN values greater than `maxJD` cause arithmetic overflow
		// when computing `J`
		let maxJD = .max - 1402

		var JD = JD
		var cycles = 0

		// Translate out-of-range JDNs into the valid range using
		// multiples of the Julian calendar's 10227 day recurrence cycle
		if JD > maxJD || JD < 0 {
			let qr = JD.quotientAndRemainder(dividingBy: -recurrenceCycle.days)
			cycles = qr.quotient + 1
			JD = recurrenceCycle.days + qr.remainder
		}

		var J = JD + 1402
		let K = (J - 1) / 1461
		let L = J - 1461 * K
		let N = (L - 1) / 365 - L / 1461
		var I = L - 365 * N + 30
		J = (80 * I) / 2447
		let D = I - (2447 * J) / 80
		I = J / 11
		let M = J + 2 - 12 * I
		var Y = 4 * K + N + I - 4716

		if cycles != 0 {
			Y -= cycles * recurrenceCycle.years
		}

		return (Y, M, D)
	}

	/// The Julian day number when the Julian calendar took effect.
	///
	/// This JDN corresponds to January 1, 45 BCE in the Julian calendar.
	public static let effectiveJulianDayNumber: JulianDayNumber = 1704987

	/// The number of months in one year.
	public static let numberOfMonthsInYear = 12

	/// The number of days in each month indexed from `0` (January) to `11` (December).
	static let monthLengths = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ]

	/// Returns `true` if the specified Julian day number occurred before the Julian calendar took effect.
	///
	/// The Julian calendar took effect on JDN 1704987.
	///
	/// - parameter julianDayNumber: A Julian day number.
	///
	/// - returns: `true` if the specified specified Julian day number occurred before the Julian calendar took effect.
	public static func isProleptic(julianDayNumber: JulianDayNumber) -> Bool {
		julianDayNumber < effectiveJulianDayNumber
	}

	/// Returns `true` if the specified year is a leap year in the Julian calendar.
	///
	/// A Julian year is a leap (bissextile) year if its numerical designation is divisible by 4.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: `true` if the specified year is a leap year in the Julian calendar.
	public static func isLeapYear(_ Y: Year) -> Bool {
		Y % 4 == 0
	}

	public static func numberOfMonths(inYear Y: Year) -> Int {
		numberOfMonthsInYear
	}

	public static func numberOfDays(inYear Y: Year) -> Int {
		isLeapYear(Y) ? 366 : 365
	}

	public static func numberOfDaysIn(month M: Month, year Y: Year) -> Int {
		guard M > 0, M <= numberOfMonthsInYear else {
			return 0
		}

		if M == 2 {
			return isLeapYear(Y) ? 29 : 28
		} else {
			return monthLengths[M - 1]
		}
	}
}

extension JulianCalendar {
	/// A day of the week number from `1` (Sunday) to `7` (Saturday).
	public typealias DayOfWeek = Int

	/// Returns the day of the week for the specified Julian day number in the Julian calendar.
	///
	/// - parameter J: A Julian day number.
	///
	/// - returns: The day of the week for the specified Julian day number.
	public static func dayOfWeek(_ J: JulianDayNumber) -> DayOfWeek {
		DayOfWeek(1 + ((J % 7) + 8) % 7)
	}

	/// Returns the month and day of Easter in the specified year in the Julian calendar.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: The month and day of Easter in the specified year.
	public static func easter(year Y: Year) -> (month: Month, day: Day) {
		// Algorithm from the Explanatory Supplement to the Astronomical Almanac, 3rd edition, S.E Urban and P.K. Seidelmann eds., (Mill Valley, CA: University Science Books), Chapter 15, pp. 585-624.
		let a = 22 + ((225 - 11 * (Y % 19)) % 30)
		let g = a + ((56 + 6 * Y - Y / 4 - a) % 7)
		let M = 3 + g / 32
		let D = 1 + ((g - 1) % 31)
		return (M, D)
	}
}
