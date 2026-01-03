//
// SPDX-FileCopyrightText: 2021 Stephen F. Booth <contact@sbooth.dev>
// SPDX-License-Identifier: MIT
//
// Part of https://github.com/sbooth/JulianDayNumber
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
