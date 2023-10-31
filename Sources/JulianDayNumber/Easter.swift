//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

// From the Explanatory Supplement to the Astronomical Almanac, 3rd edition, S.E Urban and P.K. Seidelmann eds., (Mill Valley, CA: University Science Books), Chapter 15, pp. 585-624.

/// Returns the month `M` and day `D` of Easter in year `Y`.
///
/// Years before 1582 are interpreted in the Julian calendar and years after
/// 1582 are interpreted in the Gregorian calendar.
///
/// - parameter year: A year number.
///
/// - returns: The month and day of Easter in the requested year.
public func easter(year Y: Int) -> (month: Int, day: Int) {
	return Y < 1582 ? easterInJulianCalendar(year: Y) : easterInGregorianCalendar(year: Y)
}

/// Returns the month `M` and day `D` of Easter in year `Y` in the Julian calendar.
///
/// - parameter year: A year number.
///
/// - returns: The month and day of Easter in the requested year.
public func easterInJulianCalendar(year Y: Int) -> (month: Int, day: Int) {
	let a = 22 + ((225 - 11 * (Y % 19)) % 30)
	let g = a + ((56 + 6 * Y - Y / 4 - a) % 7)
	let M = 3 + g / 32
	let D = 1 + ((g - 1) % 31)
	return (M, D)
}

/// Returns the month `M` and day `D` of Easter in year `Y` in the Gregorian calendar.
///
/// - parameter year: A year number.
///
/// - returns: The month and day of Easter in the requested year.
public func easterInGregorianCalendar(year Y: Int) -> (month: Int, day: Int) {
	let a = Y / 100
	let b = a - a / 4
	let c = (Y % 19)
	let e = ((15 + 19 * c + b - (a - (a - 17) / 25) / 3) % 30)
	let f = e - (c + 11 * e) / 319
	let g = 22 + f + ((140004 - Y - Y / 4 + b - f) % 7)
	let M = 3 + g / 32
	let D = 1 + ((g - 1) % 31)
	return (M, D)
}
