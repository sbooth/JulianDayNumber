//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// A Julian day number.
///
/// The Julian day number (JDN) is the integer assigned to a whole solar day in the Julian day count starting from noon Universal Time,
/// with JDN 0 assigned to the day starting at noon on Monday, January 1, 4713 BC (-4712-01-01 12:00:00) in the proleptic Julian calendar.
public struct JDN: Hashable {
	/// The Julian day number.
	public let julianDayNumber: Int

	/// Initializes a Julian day number to `julianDayNumber`.
	///
	/// - parameter julianDayNumber: A Julian day number.
	public init(_ julianDayNumber: Int) {
		self.julianDayNumber = julianDayNumber
	}
}

extension JDN {
	/// A system defining the beginning, length, and divisions of a year.
	public enum Calendar {
		/// The Julian calendar.
		///
		/// The earliest supported date for the Julian calendar is `-9999-01-01` and the latest supported date is `99999-12-31`.
		/// The earliest supported Julian day number for the Julian calendar is `-1931076` and the latest supported Julian day number is `38246057`.
		case julian
		/// The Gregorian calendar.
		///
		/// The earliest supported date for the Gregorian calendar is `-9999-01-01` and the latest supported date is `99999-12-31`.
		/// The earliest supported Julian day number for the Gregorian calendar is `-1930999` and the latest supported Julian day number is `38245309`.
		case gregorian
		/// The Julian calendar for dates before 1582-10-15 and the Gregorian calendar for later dates.
		///
		/// The earliest supported date for the Julian calendar is `-9999-01-01` and the latest supported date for the Gregorian calendar is `99999-12-31`.
		/// The earliest supported Julian day number for the Julian calendar is `-1931076` and the latest supported Julian day number for the Gregorian calendar is `38245309`.
		case julianGregorian
		/// The civil Islamic calendar.
		///
		/// The earliest supported date for the Islamic calendar is `-9999-01-01` and the latest supported date is `99999-12-29`.
		/// The earliest supported Julian day number for the Islamic calendar is `-1595227` and the latest supported Julian day number is `37384751`.
		case islamic
	}

	/// Converts a year, month, and day in `calendar` to a Julian day number.
	///
	/// - note: No validation checks are performed on the date values.
	///
	/// - parameter Y: A year number between `-9999` and `99999`.
	/// - parameter M: A month number between `1` and the maximum number of months in year `Y`.
	/// - parameter D: A day number between `1` and the maximum number of days in month `M` for year `Y`.
	/// - parameter calendar: The calendar used to interpret the year, month, and date.
	public init(year Y: Int, month M: Int, day D: Int, calendar: Calendar = .julianGregorian) {
		switch calendar {
		case .julian:
			self.init(julianCalendarDateToJulianDayNumber(year: Y, month: M, day: D))
		case .gregorian:
			self.init(gregorianCalendarDateToJulianDayNumber(year: Y, month: M, day: D))
		case .julianGregorian:
			if (Y, M, D) < gregorianCalendarChangeoverDate {
				self.init(julianCalendarDateToJulianDayNumber(year: Y, month: M, day: D))
			} else {
				self.init(gregorianCalendarDateToJulianDayNumber(year: Y, month: M, day: D))
			}
		case .islamic:
			self.init(islamicCalendarDateToJulianDayNumber(year: Y, month: M, day: D))
		}
	}

	/// Converts the Julian day number to a year, month, and day in `calendar`.
	///
	/// - parameter calendar: The calendar used to interpret the date.
	///
	/// - returns: The year, month, and day corresponding to the specified Julian day number.
	public func toDate(_ calendar: Calendar = .julianGregorian) -> (year: Int, month: Int, day: Int) {
		switch calendar {
		case .julian:
			return julianDayNumberToJulianCalendarDate(julianDayNumber)
		case .gregorian:
			return julianDayNumberToGregorianCalendarDate(julianDayNumber)
		case .julianGregorian:
			if julianDayNumber < gregorianCalendarChangeoverJDN {
				return julianDayNumberToJulianCalendarDate(julianDayNumber)
			} else {
				return julianDayNumberToGregorianCalendarDate(julianDayNumber)
			}
		case .islamic:
			return julianDayNumberToIslamicCalendarDate(julianDayNumber)
		}
	}
}

extension JDN: ExpressibleByIntegerLiteral {
	/// Initializes a Julian day number with `value`.
	///
	/// - parameter value: A Julian day number.
	public init(integerLiteral value: IntegerLiteralType) {
		self = .init(value)
	}
}

// MARK: Operator Overloads

extension JDN {
	/// Returns `true` if the Julian day number `J` is equal to `julianDayNumber`.
	///
	/// - parameter J: A `JDN` instance.
	/// - parameter julianDayNumber: A Julian day number.
	///
	/// - returns: `true` if `J.julianDayNumber` is equal to `julianDayNumber`.
	static public func ==(J: JDN, julianDayNumber: Int) -> Bool {
		J.julianDayNumber == julianDayNumber
	}

	/// Returns `true` if the Julian day number `J` is not equal to `julianDayNumber`.
	///
	/// - parameter J: A `JDN` instance.
	/// - parameter julianDayNumber: A Julian day number.
	///
	/// - returns: `true` if  `J.julianDayNumber` is not equal to `julianDayNumber`.
	static public func !=(J: JDN, julianDayNumber: Int) -> Bool {
		J.julianDayNumber != julianDayNumber
	}

	/// Returns `true` if the Julian day number `J` is less than `julianDayNumber`.
	///
	/// - parameter J: A `JDN` instance.
	/// - parameter julianDayNumber: A Julian day number.
	///
	/// - returns: `true` if  `J.julianDayNumber` is less than `julianDayNumber`.
	static public func <(J: JDN, julianDayNumber: Int) -> Bool {
		J.julianDayNumber < julianDayNumber
	}

	/// Returns `true` if the Julian day number `J` is less than or equal to `julianDayNumber`.
	///
	/// - parameter J: A `JDN` instance.
	/// - parameter julianDayNumber: A Julian day number.
	///
	/// - returns: `true` if `J.julianDayNumber` is less than or equal to `julianDayNumber`.
	static public func <=(J: JDN, julianDayNumber: Int) -> Bool {
		J.julianDayNumber <= julianDayNumber
	}

	/// Returns `true` if the Julian day number `J` is greater than `julianDayNumber`.
	///
	/// - parameter J: A `JDN` instance.
	/// - parameter julianDayNumber: A Julian day number.
	///
	/// - returns: `true` if  `J.julianDayNumber` is greater than `julianDayNumber`.
	static public func >(J: JDN, julianDayNumber: Int) -> Bool {
		J.julianDayNumber > julianDayNumber
	}

	/// Returns `true` if the Julian day number `J` is greater than or equal to `julianDayNumber`.
	///
	/// - parameter J: A `JDN` instance.
	/// - parameter julianDayNumber: A Julian day number.
	///
	/// - returns: `true` if  `J.julianDayNumber` is greater than or equal to `julianDayNumber`.
	static public func >=(J: JDN, julianDayNumber: Int) -> Bool {
		J.julianDayNumber >= julianDayNumber
	}
}

extension JDN {
	/// Returns `true` if the Julian day number `J` is equal to `date`.
	///
	/// - parameter J: A `JDN` instance.
	/// - parameter date: A year, month, and day.
	///
	/// - returns: `true` if `J.toDate()` is equal to `date`.
	static public func ==(J: JDN, date: (year: Int, month: Int, day: Int)) -> Bool {
		J.toDate() == date
	}
}
