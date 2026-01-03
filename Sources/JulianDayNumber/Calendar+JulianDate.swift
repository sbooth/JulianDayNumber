//
// SPDX-FileCopyrightText: 2021 Stephen F. Booth <contact@sbooth.dev>
// SPDX-License-Identifier: MIT
//
// Part of https://github.com/sbooth/JulianDayNumber
//

import Foundation

/// A Julian date.
///
/// The Julian date (JD) is the Julian day number (JDN) plus the fraction of a day since the preceding noon in Universal Time.
/// Julian dates are expressed as a JDN with a decimal fraction added.
///
/// - seealso: [Julian day](https://en.wikipedia.org/wiki/Julian_day)
public typealias JulianDate = Double

extension Calendar {
	/// An hour number on the half-open interval `[0, 24)`.
	public typealias Hour = Int

	/// A minute number on the half-open interval `[0, 60)`.
	public typealias Minute = Int

	/// A second number on the half-open interval `[0, 60)`.
	public typealias Second = Double

	/// A decimal fractional day number.
	public typealias FractionalDay = Double

	/// Converts the specified year, month, day, hour, minute, and second to a Julian date and returns the result.
	///
	/// - important: No validation checks are performed on the date values.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	/// - parameter D: A day number.
	/// - parameter h: An hour number on the half-open interval `[0, 24)`.
	/// - parameter m: A minute number on the half-open interval `[0, 60)`.
	/// - parameter s: A second number on the half-open interval `[0, 60)`.
	///
	/// - returns: The Julian date corresponding to the specified year, month, day, hour, minute, and second.
	public static func julianDateFrom(year Y: Year, month M: Month, day D: Day, hour h: Hour = 0, minute m: Minute = 0, second s: Second = 0) -> JulianDate {
		julianDateFrom(year: Y, month: M, day: Double(D) + fractionalDayFrom(hour: h, minute: m, second: s))
	}

	/// Converts the specified year, month, and decimal fractional day to a Julian date and returns the result.
	///
	/// - important: No validation checks are performed on the date values.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	/// - parameter D: A decimal fractional day number.
	///
	/// - returns: The Julian date corresponding to the specified year, month, and decimal day.
	public static func julianDateFrom(year Y: Year, month M: Month, day D: FractionalDay) -> JulianDate {
		let (day, dayFraction) = modf(D)
		return Double(julianDayNumberFrom(year: Y, month: M, day: Int(day))) - 0.5 + dayFraction
	}

	/// Converts the specified Julian date to a year, month, day, hour, minute, and second and returns the result.
	///
	/// - parameter julianDate: A Julian date.
	///
	/// - returns: The year, month, day, hour, minute, and second corresponding to the specified Julian date.
	public static func dateAndTimeFromJulianDate(_ julianDate: JulianDate) -> (year: Year, month: Month, day: Day, hour: Hour, minute: Minute, second: Second) {
		let julianDatePlus12Hours = julianDate + 0.5
		let J = JulianDayNumber(julianDatePlus12Hours.rounded(.down))
		let (Y, M, D) = dateFromJulianDayNumber(J)
		var (_, dayFraction) = modf(julianDatePlus12Hours)
		if dayFraction < 0 {
			dayFraction += 1
		}
		let (h, m, s) = timeFromFractionalDay(dayFraction)
		return (Y, M, D, h, m, s)
	}
}

// MARK: - Internal Functions

/// Converts an hour, minute, and second to a decimal fractional day and returns the result.
///
/// This function assumes a day is exactly 24 hours, an hour is exactly 60 minutes, and a minute is exactly 60 seconds.
///
/// - parameter h: An hour number on the half-open interval `[0, 24)`.
/// - parameter m: A minute number on the half-open interval `[0, 60)`.
/// - parameter s: A second number on the half-open interval `[0, 60)`.
///
/// - returns: The decimal fractional day for the specified hour, minute, and second.
func fractionalDayFrom(hour h: Calendar.Hour, minute m: Calendar.Minute, second s: Calendar.Second) -> Calendar.FractionalDay {
	(Double(h) / 24) + (Double(m) / 1440) + (s / 86400)
}

/// Converts a decimal fractional day to an hour, minute, and second and returns the result.
///
/// This function assumes a day is exactly 24 hours, an hour is exactly 60 minutes, and a minute is exactly 60 seconds.
///
/// - parameter fractionalDay: A decimal fractional day in the half-open interval `[0,1)`.
///
/// - returns: The hour, minute, and second for the specified decimal fractional day.
func timeFromFractionalDay(_ fractionalDay: Calendar.FractionalDay) -> (hour: Calendar.Hour, minute: Calendar.Minute, second: Calendar.Second) {
	let (hour, hourFraction) = modf(fractionalDay * 24)
	let (minute, minuteFraction) = modf(hourFraction * 60)
	let second = minuteFraction * 60
	return (Int(hour), Int(minute), second)
}
