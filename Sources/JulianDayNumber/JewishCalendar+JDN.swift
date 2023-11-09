//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

// Algorithm from the Explanatory Supplement to the Astronomical Almanac, 3rd edition, S.E Urban and P.K. Seidelmann eds., (Mill Valley, CA: University Science Books), Chapter 15, pp. 585-624.

/// The number of years in a cycle of the Jewish calendar.
///
/// A cycle in the Jewish calendar consists of 689,472 years, 8,527,680 months, 35,975,351 weeks, or 251,827,457 days.
let jewishCalendarCycleYears = 689472

/// The number of days in a cycle of the Jewish calendar.
///
/// A cycle in the Jewish calendar consists of 689,472 years, 8,527,680 months, 35,975,351 weeks, or 251,827,457 days.
let jewishCalendarCycleDays = 251827457

extension JewishCalendar {
	/// Returns the Julian day number of the first day of Tishri in the specified year.
	///
	/// - note: No validation check is performed on the year value.
	///
	/// - parameter Y: A year A.M.
	///
	/// - returns: The Julian day number of the first day of Tishri in the specified year.
	static func firstDayOfTishri(year Y: Int) -> JulianDayNumber {
//		precondition(Y > 0, "First day of Tishri calculations only valid for year numbers > 0")
//		precondition(Y < 974245219737, "Year values above 974245219736 cause numerical overflow using 64-bit integers")

		// It is possible to adjust the year by a multiple of the cycle to have this function
		// calculate correct values for the first day of Tishri in proleptic years. However,
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
		let K = firstDayOfTishri(year: Y)
		if K > J {
			Y = Y - 1
		}
		return Y
	}
}

extension JewishCalendar: JulianDayNumberConverting {
	/// Converts a year, month, and day in the Jewish calendar to a Julian day number.
	///
	/// - note: No validation checks are performed on the date values.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number between `1` (Tishri) and `12` (Elul) for common years and `1` (Tishri) and `13` (Elul) for leap years.
	/// - parameter D: A day number between `1` and the maximum number of days in month `M` for year `Y`.
	///
	/// - returns: The Julian day number corresponding to the specified year, month, and day.
	public static func dateToJulianDayNumber(year Y: Int, month M: Int, day D: Int) -> JulianDayNumber {
		var Y = Y
		var ΔcalendarCycles = 0

		if Y < 1 {
			ΔcalendarCycles = (1 - Y) / jewishCalendarCycleYears + 1
			Y += ΔcalendarCycles * jewishCalendarCycleYears
		}

		let a = firstDayOfTishri(year: Y)
		let b = firstDayOfTishri(year: Y + 1)
		let K = b - a - 352 - 27 * (((7 * Y + 13) % 19) / 12)
		var J = a + A[K - 1][M - 1] + D - 1

		if ΔcalendarCycles > 0 {
			J -= ΔcalendarCycles * jewishCalendarCycleDays
		}

		return J
	}

	/// Converts a Julian day number to a year, month, and day in the Jewish calendar.
	///
	/// - parameter J: A Julian day number.
	///
	/// - returns: The year, month, and day corresponding to the specified Julian day number.
	public static func julianDayNumberToDate(_ J: JulianDayNumber) -> (year: Int, month: Int, day: Int) {
		var J = J
		var ΔcalendarCycles = 0

		if J < epochJulianDayNumber {
			ΔcalendarCycles = (epochJulianDayNumber - J) / jewishCalendarCycleDays + 1
			J += ΔcalendarCycles * jewishCalendarCycleDays
		}

		var Y = yearContaining(julianDayNumber: J)
		let a = firstDayOfTishri(year: Y)
		let b = firstDayOfTishri(year: Y + 1)
		let K = b - a - 352 - 27 * (((7 * Y + 13) % 19) / 12)
		let c = J - a + 1
//		precondition(c >= 0)
		let AK = A[K - 1]
		let M = AK.lastIndex(where: {$0 < c})! + 1
		let D = c - AK[M - 1]

		if ΔcalendarCycles > 0 {
			Y -= ΔcalendarCycles * jewishCalendarCycleYears
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
