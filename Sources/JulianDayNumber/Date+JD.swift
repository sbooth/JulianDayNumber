//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// The Julian date in UTC corresponding to the Unix epoch.
/// - note: The Unix epoch is 1970-01-01 00:00:00 UTC.
let unixEpochJD_UTC = 2440587.5
/// The Julian date in UTC for epoch J2000.
/// - note: The J2000 epoch is 2000-01-01 11:58:55.816 UTC.
let J2000JD_UTC = 2451544.9992571296
/// The Julian date in TT for epoch J2000.
/// - note: The J2000 epoch is 2000-01-01 12:00:00 TT.
let J2000JD_TT = 2451545.0

extension Date {
	/// Returns the Julian date in UTC corresponding to `self`.
	public var julianDate: Double {
		timeIntervalSince1970 / 86400 + unixEpochJD_UTC
	}

	/// Creates a date value initialized to the specified Julian date in UTC.
	/// - parameter JD: A Julian date in UTC.
	public init(julianDate JD: Double) {
		self.init(timeIntervalSince1970: (JD - unixEpochJD_UTC) * 86400)
	}

	/// Returns the number of days between `self` and the J2000 epoch.
	public var daysSinceJ2000: Double {
		julianDate - J2000JD_UTC
	}

	/// Creates a date value relative to the J2000 epoch by a given number of days.
	/// - parameter daysSinceJ2000: A decimal number of days.
	public init(daysSinceJ2000: Double) {
		self.init(julianDate: J2000JD_UTC + daysSinceJ2000)
	}

	/// The epoch J2000.
	///
	/// The J2000 epoch is defined as 2000-01-01 12:00:00 TT.
	///
	/// The following times are equivalent and correspond to the J2000 epoch:
	/// | Time Standard | Time and Date | Julian Date |
	/// | -- | --- | --- |
	/// | TT | 2000-01-01 12:00:00 | 2451545.0 |
	/// | UTC | 2000-01-01 11:58:55.816 | 2451544.9992571296 |
	public static var j2000: Date {
		Date(julianDate: J2000JD_UTC)
	}
}

extension Date {
	/// True if the Julian date in UTC for `self` is at or after the Julian to Gregorian calendar changeover.
	/// - note: The Julian to Gregorian calendar changeover occurred on 1582-10-15 and corresponds to Julian date 2299160.5 in UTC.
	public var atOrAfterGregorianCalendarChangeover: Bool {
		julianDate >= gregorianCalendarChangeoverJD
	}
}
