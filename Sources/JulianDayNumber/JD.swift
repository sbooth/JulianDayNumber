//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// A Julian date.
///
/// The Julian date (JD) is the Julian Day Number (JDN) plus the fraction of a day since the preceding noon in Universal Time.
/// Julian dates are expressed as a JDN with a decimal fraction added.
public struct JD: Hashable {
	/// The Julian date.
	public let julianDate: Double

	/// Initializes a Julian date to `julianDate`.
	///
	/// - parameter julianDate: A Julian date.
	public init(_ julianDate: Double) {
		self.julianDate = julianDate
	}
}

extension JD {
	public typealias Calendar = JDN.Calendar

	/// Converts a year, month, day, hour, minute, and second in `calendar` to a Julian date.
	///
	/// - note: No validation checks are performed on the date values.
	///
	/// - parameter Y: A year number between `-9999` and `99999`.
	/// - parameter M: A month number between `1` and the maximum number of months in year `Y`.
	/// - parameter D: A day number between `1` and the maximum number of days in month `M` for year `Y`.
	/// - parameter h: An hour number between `0` and `23`.
	/// - parameter m: A minute number between `0` and `59`.
	/// - parameter s: A second number between `0` and `59`.
	/// - parameter calendar: The calendar used to interpret the year, month, and day.
	public init(year Y: Int, month M: Int, day D: Int, hour h: Int = 0, minute m: Int = 0, second s: Double = 0, calendar: Calendar = .julianGregorian) {
		let J = JDN(year: Y, month: M, day: D, calendar: calendar)
		self.init(Double(J.julianDayNumber) - 0.5 + timeToFractionalDay(hour: h, minute: m, second: s))
	}

	/// Converts a year, month, and decimal day in `calendar` to a Julian date.
	///
	/// - note: No validation checks are performed on the date values.
	///
	/// - parameter Y: A year number between `-9999` and `99999`.
	/// - parameter M: A month number between `1` (January) and `12` (December).
	/// - parameter D: A decimal day between `1` and the maximum number of days in month `M` for year `Y`.
	/// - parameter calendar: The calendar used to interpret the year, month, and day.
	public init(year Y: Int, month M: Int, day D: Double, calendar: Calendar = .julianGregorian) {
		let (day, dayFraction) = modf(D)
		let J = JDN(year: Y, month: M, day: Int(day), calendar: calendar)
		self.init(Double(J.julianDayNumber) - 0.5 + dayFraction)
	}

	/// Converts the Julian date to a year, month, day, hour, minute, and second in `calendar`.
	///
	/// - parameter JD: A Julian date between `-1931076.5` and `38245308.5`.
	/// - parameter calendar: The calendar used to interpret the date.
	///
	/// - returns: A tuple containing the year, month, day, hour, minute, and second corresponding to the specified Julian date.
	public func toDate(_ calendar: Calendar = .julianGregorian) -> (year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Double) {
		switch calendar {
		case .julian:
			return julianDateToCalendarDate(julianDate, julianDayNumberToDate: julianDayNumberToJulianCalendarDate)
		case .gregorian:
			return julianDateToCalendarDate(julianDate, julianDayNumberToDate: julianDayNumberToGregorianCalendarDate)
		case .julianGregorian:
			if julianDate < gregorianCalendarChangeoverJD {
				return julianDateToCalendarDate(julianDate, julianDayNumberToDate: julianDayNumberToJulianCalendarDate)
			} else {
				return julianDateToCalendarDate(julianDate, julianDayNumberToDate: julianDayNumberToGregorianCalendarDate)
			}
		case .islamic:
			return julianDateToCalendarDate(julianDate, julianDayNumberToDate: julianDayNumberToIslamicCalendarDate)
		}
	}
}

extension JD: ExpressibleByIntegerLiteral {
	/// Initializes a Julian date with `value`.
	///
	/// - parameter value: A Julian date.
	public init(integerLiteral value: IntegerLiteralType) {
		self = .init(Double(value))
	}
}

extension JD: ExpressibleByFloatLiteral {
	/// Initializes a Julian date with `value`.
	///
	/// - parameter value: A Julian date.
	public init(floatLiteral value: FloatLiteralType) {
		self = .init(value)
	}
}

// MARK: Operator Overloads

extension JD {
	/// Returns `true` if the Julian date `J` is equal to `julianDate`.
	///
	/// - parameter J: A `JD` instance.
	/// - parameter julianDate: A Julian date.
	///
	/// - returns: `true` if `J.julianDate` is equal to `julianDate`.
	static public func ==(J: JD, julianDate: Double) -> Bool {
		J.julianDate == julianDate
	}

	/// Returns `true` if the Julian date `J` is not equal to `julianDate`.
	///
	/// - parameter J: A `JD` instance.
	/// - parameter julianDate: A Julian date.
	///
	/// - returns: `true` if  `J.julianDate` is not equal to `julianDate`.
	static public func !=(J: JD, julianDate: Double) -> Bool {
		J.julianDate != julianDate
	}

	/// Returns `true` if the Julian date `J` is less than `julianDate`.
	///
	/// - parameter J: A `JD` instance.
	/// - parameter julianDate: A Julian date.
	///
	/// - returns: `true` if  `J.julianDate` is less than `julianDate`.
	static public func <(J: JD, julianDate: Double) -> Bool {
		J.julianDate < julianDate
	}

	/// Returns `true` if the Julian date `J` is less than or equal to `julianDate`.
	///
	/// - parameter J: A `JD` instance.
	/// - parameter julianDate: A Julian date.
	///
	/// - returns: `true` if `J.julianDate` is less than or equal to `julianDate`.
	static public func <=(J: JD, julianDate: Double) -> Bool {
		J.julianDate <= julianDate
	}

	/// Returns `true` if the Julian date `J` is greater than `julianDate`.
	///
	/// - parameter J: A `JD` instance.
	/// - parameter julianDate: A Julian date.
	///
	/// - returns: `true` if  `J.julianDate` is greater than `julianDate`.
	static public func >(J: JD, julianDate: Double) -> Bool {
		J.julianDate > julianDate
	}

	/// Returns `true` if the Julian date `J` is greater than or equal to `julianDate`.
	///
	/// - parameter J: A `JD` instance.
	/// - parameter julianDate: A Julian date.
	///
	/// - returns: `true` if  `J.julianDate` is greater than or equal to `julianDate`.
	static public func >=(J: JD, julianDate: Double) -> Bool {
		J.julianDate >= julianDate
	}
}

extension JD {
	/// Returns `true` if the Julian date `J` is equal to `date`.
	///
	/// - parameter J: A `JD` instance.
	/// - parameter date: A year, month, day, hour, minute, and second.
	///
	/// - returns: `true` if `J.toDate()` is equal to `date`.
	static public func ==(J: JD, date: (year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Double)) -> Bool {
		J.toDate() == date
	}
}

// MARK: - Internal Functions

/// Converts an hour, minute, and second to a decimal fractional day and returns the result.
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
/// - parameter fractionalDay: A decimal fractional day in the half-open interval `[0,1)`.
///
/// - returns: The hour, minute, and second for the specified decimal fractional day.
func fractionalDayToTime(_ fractionalDay: Double) -> (hour: Int, minute: Int, second: Double) {
	let (hour, hourFraction) = modf(fractionalDay * 24)
	let (minute, minuteFraction) = modf(hourFraction * 60)
	let second = minuteFraction * 60
	return (Int(hour), Int(minute), second)
}

/// Converts a Julian date to a calendar date using `jdnToDateFunction` and returns the result.
///
/// - parameter JD: A Julian date.
/// - parameter jdnToDateConversionFunction: A function accepting a Julian day number and returning the equivalent year, month, and day.
///
/// - returns: The year, month, day, hour, minute, and second for the Julian date.
func julianDateToCalendarDate(_ JD: Double, julianDayNumberToDate: (_ J: Int) -> (year: Int, month: Int, day: Int)) -> (year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Double) {
	let jdPlus12Hours = JD + 0.5
	let J = Int(jdPlus12Hours.rounded(.down))
	let (Y, M, D) = julianDayNumberToDate(J)
	var (_, dayFraction) = modf(jdPlus12Hours)
	if dayFraction < 0 {
		dayFraction += 1
	}
	let (h, m, s) = fractionalDayToTime(dayFraction)
	return (Y, M, D, h, m, s)
}
