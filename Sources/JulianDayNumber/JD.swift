//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// A Julian date.
///
/// The Julian date (JD) is the Julian day number (JDN) plus the fraction of a day since the preceding noon in Universal Time.
/// Julian dates are expressed as a JDN with a decimal fraction added.
public typealias JulianDate = Double

/// Julian date to year, month, day, hour, minute, and second conversion.
extension JulianDayNumberConverting {
	/// Converts the specified year, month, day, hour, minute, and second to a Julian date and returns the result.
	///
	/// - note: No validation checks are performed on the date values.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	/// - parameter D: A day number.
	/// - parameter h: An hour number between `0` and `23`.
	/// - parameter m: A minute number between `0` and `59`.
	/// - parameter s: A second number between `0` and `59`.
	///
	/// - returns: The Julian date corresponding to the specified year, month, day, hour, minute, and second.
	public static func dateToJulianDate(year Y: Int, month M: Int, day D: Int, hour h: Int = 0, minute m: Int = 0, second s: Double = 0) -> JulianDate {
		dateToJulianDate(year: Y, month: M, day: Double(D) + timeToFractionalDay(hour: h, minute: m, second: s))
	}

	/// Converts the specified year, month, and decimal day to a Julian date and returns the result.
	///
	/// - note: No validation checks are performed on the date values.
	///
	/// - parameter Y: A year number.
	/// - parameter M: A month number.
	/// - parameter D: A day number.
	///
	/// - returns: The Julian date corresponding to the specified year, month, and decimal day.
	public static func dateToJulianDate(year Y: Int, month M: Int, day D: Double) -> JulianDate {
		let (day, dayFraction) = modf(D)
		return Double(dateToJulianDayNumber(year: Y, month: M, day: Int(day))) - 0.5 + dayFraction
	}

	/// Converts the specified Julian date to a year, month, day, hour, minute, and second and returns the result.
	///
	/// - parameter julianDate: A Julian date.
	///
	/// - returns: The year, month, day, hour, minute, and second corresponding to the specified Julian date.
	public static func julianDateToDate(_ julianDate: JulianDate) -> (year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Double) {
		let julianDatePlus12Hours = julianDate + 0.5
		let J = Int(julianDatePlus12Hours.rounded(.down))
		let (Y, M, D) = julianDayNumberToDate(J)
		var (_, dayFraction) = modf(julianDatePlus12Hours)
		if dayFraction < 0 {
			dayFraction += 1
		}
		let (h, m, s) = fractionalDayToTime(dayFraction)
		return (Y, M, D, h, m, s)
	}
}

// MARK: - Internal Functions

/// Converts an hour, minute, and second to a decimal fractional day and returns the result.
///
/// This function assumes a day is exactly 24 hours, an hour is exactly 60 minutes, and a minute is exactly 60 seconds.
///
/// - parameter h: An hour number between `0` and `23`.
/// - parameter m: A minute number between `0` and `59`.
/// - parameter s: A second number between `0` and `59`.
///
/// - returns: The decimal fractional day for the specified hour, minute, and second.
func timeToFractionalDay(hour h: Int, minute m: Int, second s: Double) -> Double {
	(Double(h) / 24) + (Double(m) / 1440) + (s / 86400)
}

/// Converts a decimal fractional day to an hour, minute, and second and returns the result.
///
/// This function assumes a day is exactly 24 hours, an hour is exactly 60 minutes, and a minute is exactly 60 seconds.
///
/// - parameter fractionalDay: A decimal fractional day in the half-open interval `[0,1)`.
///
/// - returns: The hour, minute, and second for the specified decimal fractional day.
func fractionalDayToTime(_ fractionalDay: Double) -> (hour: Int, minute: Int, second: Double) {
	let (hour, hourFraction) = modf(fractionalDay * 24)
	let (minute, minuteFraction) = modf(hourFraction * 60)
	let second = minuteFraction * 60
	return (Int(hour), Int(minute), second)
}
