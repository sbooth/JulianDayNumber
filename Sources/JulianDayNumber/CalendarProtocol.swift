//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

/// A calendar that supports Julian day number to date conversion.
public protocol CalendarProtocol: JulianDayNumberConverting {
	/// The calendar's epoch.
	static var epoch: JulianDayNumber { get }

	/// Returns `true` if the specified date is valid.
	///
	/// - parameter date: A date to check.
	///
	/// - returns: `true` if the specified date is valid.
	static func isValidDate(_ date: DateType) -> Bool
}
