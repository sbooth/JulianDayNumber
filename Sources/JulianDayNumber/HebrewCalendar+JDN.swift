//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

// Algorithm from the Explanatory Supplement to the Astronomical Almanac, 3rd edition, S.E Urban and P.K. Seidelmann eds., (Mill Valley, CA: University Science Books), Chapter 15, pp. 585-624.

/// The number of years in a cycle of the Hebrew calendar.
///
/// A cycle in the Hebrew calendar consists of 689,472 years, 8,527,680 months, 35,975,351 weeks, or 251,827,457 days.
let hebrewCalendarCycleYears = 689472

/// The number of days in a cycle of the Hebrew calendar.
///
/// A cycle in the Hebrew calendar consists of 689,472 years, 8,527,680 months, 35,975,351 weeks, or 251,827,457 days.
let hebrewCalendarCycleDays = 251827457

extension HebrewCalendar {
	/// Returns the Julian day number of the first day of Tishrei in the specified year.
	///
	/// - note: No validation check is performed on the year value.
	///
	/// - parameter Y: A year A.M.
	///
	/// - returns: The Julian day number of the first day of Tishrei in the specified year.
	static func firstDayOfTishrei(year Y: Int) -> JulianDayNumber {
//		precondition(Y > 0, "First day of Tishrei calculations only valid for year numbers > 0")
//		precondition(Y < 974245219737, "Year values above 974245219736 cause numerical overflow using 64-bit integers")

		// It is possible to adjust the year by a multiple of the cycle to have this function
		// calculate correct values for the first day of Tishrei in proleptic years. However,
		// this isn't a public function and the callers perform the translation before calling.

		let b = 31524 + 765433 * ((235 * Y - 234) / 19)
		var d = b / 25920
		let e = b % 25920
		let f = 1 + (d % 7)
		let g = ((7 * Y + 13) % 19) / 12
		let h = ((7 * Y + 6) % 19) / 12
		if e >= 19440 || (e >= 9924 && f == 3 && g == 0) || (e >= 16788 && f == 2 && g == 0 && h == 1) {
			d = d + 1
		}
		return d + (((d + 5) % 7) % 2) + 347997
	}

	/// Returns the year A.M. containing the specified Julian day number.
	///
	/// - parameter J: A Julian day number.
	///
	/// - returns: The year containing the specified Julian day number.
	static func yearContaining(julianDayNumber J: JulianDayNumber) -> Int {
//		precondition(J >= epochJulianDayNumber, "Julian day number must be >= epoch")
//		precondition(J < 355839970905665, "Julian day numbers above 355839970905664 cause numerical overflow using 64-bit integers")

		let M = (25920 * (J - 347996)) / 765433 + 1
		var Y = 19 * (M / 235) + (19 * (M % 235) - 2) / 235 + 1
		let K = firstDayOfTishrei(year: Y)
		if K > J {
			Y = Y - 1
		}
		return Y
	}
}

extension HebrewCalendar: JulianDayNumberConverting {
	/// A date in the Hebrew calendar consists of a year, month, and day.
	public typealias DateType = (year: Year, month: Month, day: Day)

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		var Y = date.year
		var ΔcalendarCycles = 0

		if Y < 1 {
			ΔcalendarCycles = (1 - Y) / hebrewCalendarCycleYears + 1
			Y += ΔcalendarCycles * hebrewCalendarCycleYears
		}

		let a = firstDayOfTishrei(year: Y)
		let b = firstDayOfTishrei(year: Y + 1)
		let K = b - a - 352 - 27 * (((7 * Y + 13) % 19) / 12)
		var J = a + A[K - 1][date.month - 1] + date.day - 1

		if ΔcalendarCycles > 0 {
			J -= ΔcalendarCycles * hebrewCalendarCycleDays
		}

		return J
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		var J = J
		var ΔcalendarCycles = 0

		if J < epochJulianDayNumber {
			ΔcalendarCycles = (epochJulianDayNumber - J) / hebrewCalendarCycleDays + 1
			J += ΔcalendarCycles * hebrewCalendarCycleDays
		}

		var Y = yearContaining(julianDayNumber: J)
		let a = firstDayOfTishrei(year: Y)
		let b = firstDayOfTishrei(year: Y + 1)
		let K = b - a - 352 - 27 * (((7 * Y + 13) % 19) / 12)
		let c = J - a + 1
//		precondition(c >= 0)
		let AK = A[K - 1]
		let M = AK.lastIndex(where: {$0 < c})! + 1
		let D = c - AK[M - 1]

		if ΔcalendarCycles > 0 {
			Y -= ΔcalendarCycles * hebrewCalendarCycleYears
		}

		return (Y, M, D)
	}
}

/// The number of days preceding the first of the month in a year with characterization K.
///
/// The array is indexed first by `K - 1` and the resultant array by `M - 1`.
private let A = [
	// A deficient common year.
	[0, 30, 59, 88, 117, 147, 176, 206, 235, 265, 294, 324],
	// A regular common year.
	[0, 30, 59, 89, 118, 148, 177, 207, 236, 266, 295, 325],
	// An abundant common year.
	[0, 30, 60, 90, 119, 149, 178, 208, 237, 267, 296, 326],
	// A deficient leap year.
	[0, 30, 59, 88, 117, 147, 177, 206, 236, 265, 295, 324, 354],
	// A regular leap year.
	[0, 30, 59, 89, 118, 148, 178, 207, 237, 266, 296, 325, 355],
	// An abundant leap year.
	[0, 30, 60, 90, 119, 149, 179, 208, 238, 267, 297, 326, 356],
]