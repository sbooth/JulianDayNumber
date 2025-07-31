//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

/// The Hebrew calendar is a lunisolar calendar with either 353, 354, 355, 383, 384, or 385 days in the year.
///
/// A common year has 353, 354, or 355 days. A leap year is always 30 days longer.
///
/// The number of days in a year depends on whether the year is a common or leap year and whether it is deficient, regular, or abundant.
///
/// | | Common Year | Leap Year |
/// | --- | --- | --- |
/// | Deficient | 353 | 383 |
/// | Regular | 354 | 384 |
/// | Abundant | 355 | 385 |
///
/// Common years consist of twelve months.
///
/// | Month | Name | | Days |
/// | ---: | --- | --- | --- |
/// | 1 | Tishrei | תִּשְׁרֵי‎ | 30 |
/// | 2 | Cheshvan | חֶשְׁוָן‎ | 29 (30 in abundant years) |
/// | 3 | Kislev | כִּסְלֵו‎ | 30 (29 in deficient years) |
/// | 4 | Tevet | טֵבֵת‎ | 29 |
/// | 5 | Shevat | שְׁבָט‎ | 30 |
/// | 6 | Adar | אֲדָר‎ | 29 |
/// | 7 | Nisan | נִיסָן‎ | 30 |
/// | 8 | Iyar | אִייָר‎ | 29 |
/// | 9 | Sivan | סִיוָן‎ | 30 |
/// | 10 | Tammuz | תַּמּוּז‎ | 29 |
/// | 11 | Av | אָב‎ | 30 |
/// | 12 | Elul | אֱלוּל‎ | 29 |
///
/// Leap years consist of thirteen months.
///
/// | Month | Name | | Days |
/// | ---: | --- | --- | --- |
/// | 1 | Tishrei | תִּשְׁרֵי‎ | 30 |
/// | 2 | Cheshvan | חֶשְׁוָן‎ | 29 (30 in abundant years) |
/// | 3 | Kislev | כִּסְלֵו‎ | 30 (29 in deficient years) |
/// | 4 | Tevet | טֵבֵת‎ | 29 |
/// | 5 | Shevat | שְׁבָט‎ | 30 |
/// | 6 | Adar | אדר א׳‎ | 30 |
/// | 7 | Adar II | אדר ב׳‎ | 29 |
/// | 8 | Nisan | נִיסָן‎ | 30 |
/// | 9 | Iyar | אִייָר‎ | 29 |
/// | 10 | Sivan | סִיוָן‎ | 30 |
/// | 11 | Tammuz | תַּמּוּז‎ | 29 |
/// | 12 | Av | אָב‎ | 30 |
/// | 13 | Elul | אֱלוּל‎ | 29 |
///
/// The Hebrew calendar epoch in the Julian calendar is October 7, 3761 BCE.
///
/// - seealso: [Hebrew calendar](https://en.wikipedia.org/wiki/Hebrew_calendar)
public struct HebrewCalendar: Calendar {
	/// The Julian day number of the epoch of the Hebrew calendar.
	///
	/// This JDN corresponds to October 7, 3761 BCE in the Julian calendar.
	public static let epoch: JulianDayNumber = 347998

	/// An intercalating cycle in the Hebrew calendar consists of 689,472 years, 8,527,680 months, 35,975,351 weeks, or 251,827,457 days.
	static let intercalatingCycle = (years: 689472, days: 251827457)

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		var Y = date.year
		var ΔcalendarCycles = 0

		if Y < 1 {
			ΔcalendarCycles = (1 - Y) / intercalatingCycle.years + 1
			Y += ΔcalendarCycles * intercalatingCycle.years
		}

		let a = firstDayOfTishrei(year: Y)
		let b = firstDayOfTishrei(year: Y + 1)
		let K = b - a - 352 - 27 * (((7 * Y + 13) % 19) / 12)
		var J = a + A[K - 1][date.month - 1] + date.day - 1

		if ΔcalendarCycles > 0 {
			J -= ΔcalendarCycles * intercalatingCycle.days
		}

		return J
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		var J = J
		var ΔcalendarCycles = 0

		if J < epoch {
			ΔcalendarCycles = (epoch - J) / intercalatingCycle.days + 1
			J += ΔcalendarCycles * intercalatingCycle.days
		}

		var Y = yearContaining(julianDayNumber: J)
		let a = firstDayOfTishrei(year: Y)
		let b = firstDayOfTishrei(year: Y + 1)
		let K = b - a - 352 - 27 * (((7 * Y + 13) % 19) / 12)
		let c = J - a + 1
		precondition(c >= 0)
		let AK = A[K - 1]
		let M = AK.lastIndex(where: {$0 < c})! + 1
		let D = c - AK[M - 1]

		if ΔcalendarCycles > 0 {
			Y -= ΔcalendarCycles * intercalatingCycle.years
		}

		return (Y, M, D)
	}

	/// The number of days preceding the first of the month in a year with characterization K.
	///
	/// The array is indexed first by `K - 1` and the resultant array by `M - 1`.
	static let A = [
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

	/// The number of days in each month for a year with characterization K.
	///
	/// The array is indexed first by `K - 1` and the resultant array by `M - 1`.
	static let monthLengths = [
		// A deficient common year.
		[ 30, 29, 29, 29, 30, 29, 30, 29, 30, 29, 30, 29 ],
		// A regular common year.
		[ 30, 29, 30, 29, 30, 29, 30, 29, 30, 29, 30, 29 ],
		// An abundant common year.
		[ 30, 30, 30, 29, 30, 29, 30, 29, 30, 29, 30, 29 ],
		// A deficient leap year.
		[ 30, 29, 29, 29, 30, 30, 29, 30, 29, 30, 29, 30, 29 ],
		// A regular leap year.
		[ 30, 29, 30, 29, 30, 30, 29, 30, 29, 30, 29, 30, 29 ],
		// An abundant leap year.
		[ 30, 30, 30, 29, 30, 30, 29, 30, 29, 30, 29, 30, 29 ],
	]

	/// Returns `true` if the specified year is an embolismic (leap) year in the Hebrew calendar.
	///
	/// There are seven embolismic years in a cycle of nineteen years.
	/// These are years 3, 6, 8, 11, 14, 17, and 19 of the cycle.
	/// The year 1 AM was the first of a cycle.
	///
	/// - parameter Y: A year number.
	///
	/// - returns: `true` if the specified year is an embolismic (leap) year in the Hebrew calendar.
	public static func isLeapYear(_ Y: Year) -> Bool {
		if Y > 0 {
			return (7 * Y + 1) % 19 < 7
		}
		let yearInCycle = (Y - 1) % 19 + (Y < 1 ? 20 : 1)
		return yearInCycle == 3 || yearInCycle == 6 || yearInCycle == 8 || yearInCycle == 11 || yearInCycle == 14 || yearInCycle == 17 || yearInCycle == 19
	}

	public static func numberOfMonths(inYear Y: Year) -> Int {
		isLeapYear(Y) ? 13 : 12
	}

	public static func numberOfDays(inYear Y: Year) -> Int {
		var Y = Y
		var ΔcalendarCycles = 0

		if Y < 1 {
			ΔcalendarCycles = (1 - Y) / intercalatingCycle.years + 1
			Y += ΔcalendarCycles * intercalatingCycle.years
		}

		let a = firstDayOfTishrei(year: Y)
		let b = firstDayOfTishrei(year: Y + 1)
		let K = b - a - 352 - 27 * (((7 * Y + 13) % 19) / 12)

		switch K {
		case 1: 	return 353
		case 2: 	return 354
		case 3: 	return 355
		case 4: 	return 383
		case 5: 	return 384
		case 6: 	return 385
		default: 	fatalError("Invalid value \(K) for K")
		}
	}

	public static func numberOfDaysIn(month M: Month, year Y: Year) -> Int {
		guard M > 0 else {
			return 0
		}

		var Y = Y
		var ΔcalendarCycles = 0

		if Y < 1 {
			ΔcalendarCycles = (1 - Y) / intercalatingCycle.years + 1
			Y += ΔcalendarCycles * intercalatingCycle.years
		}

		let a = firstDayOfTishrei(year: Y)
		let b = firstDayOfTishrei(year: Y + 1)
		let K = b - a - 352 - 27 * (((7 * Y + 13) % 19) / 12)

		if (K > 3 && M > 13) || (K < 4 && M > 12) {
			return 0
		}

		return monthLengths[K - 1][M - 1]
	}
}

// Algorithm adapted from the Explanatory Supplement to the Astronomical Almanac, 3rd edition, S.E Urban and P.K. Seidelmann eds., (Mill Valley, CA: University Science Books), Chapter 15, pp. 585-624.

extension HebrewCalendar {
	/// Returns the Julian day number of the first day of Tishrei in the specified year.
	///
	/// - parameter Y: A year A.M.
	///
	/// - returns: The Julian day number of the first day of Tishrei in the specified year.
	static func firstDayOfTishrei(year Y: Year) -> JulianDayNumber {
		precondition(Y > 0, "First day of Tishrei calculations only valid for year numbers > 0")

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
	static func yearContaining(julianDayNumber J: JulianDayNumber) -> Year {
		precondition(J >= epoch, "Julian day number must be >= epoch")

		let M = (25920 * (J - 347996)) / 765433 + 1
		var Y = 19 * (M / 235) + (19 * (M % 235) - 2) / 235 + 1
		let K = firstDayOfTishrei(year: Y)
		if K > J {
			Y = Y - 1
		}
		return Y
	}
}
