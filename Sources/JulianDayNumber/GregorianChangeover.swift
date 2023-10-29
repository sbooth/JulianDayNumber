//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// Returns `true` if year `Y`, month `M`, and day `D` occurred after the Gregorian changeover.
///
/// - note: The Gregorian changeover occurred on October 15, 1582.
/// - note: This date is interpreted in the Gregorian calendar.
///
/// - parameter Y: A year number.
/// - parameter M: A month number between `1` (January) and `12` (December).
/// - parameter D: A day number between `1` and the maximum number of days in month `M` for year `Y`.
/// - returns: `true` if `Y`, `M`, `D` occurred after the Gregorian changeover.
func atOrAfterGregorianChangeover(year Y: Int, month M: Int, day D: Int) -> Bool {
	Y > 1582 || (Y == 1582 && (M > 10 || (M == 10 && D >= 15)))
}

/// The JDN of the changeover from Julian to Gregorian calendars.
///
/// JDN values greater than or equal to this value are typically interpreted
/// as dates in the Gregorian calendar.
///
/// This JDN corresponds to 1582-Oct-15 12:00 in the Gregorian calendar.
let gregorianChangeoverJDN = 2299161

/// The JD of the changeover from Julian to Gregorian calendars.
///
/// JD values greater than or equal to this value are typically interpreted
/// as dates in the Gregorian calendar.
///
/// This JD corresponds to 1582-Oct-15 00:00 in the Gregorian calendar.
let gregorianChangeoverJD = 2299160.5
