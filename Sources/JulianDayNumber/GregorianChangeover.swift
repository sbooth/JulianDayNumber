//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// The date tuple of the changeover from Julian to Gregorian calendars.
///
/// The Julian to Gregorian calendar changeover occurred on 1582-10-15.
/// Julian Thursday 1582-10-04 was followed by Gregorian Friday 1582-10-15.
///
/// Date tuples earlier than this value are typically interpreted in the Julian calendar while greater or equal tuples are typically interpreted in the Gregorian calendar.
///
/// - note: The actual adoption date of the Gregorian calendar varies by country.
public let gregorianCalendarChangeoverDate = (year: 1582, month: 10, day: 15)

/// The Julian day number of the changeover from Julian to Gregorian calendars.
///
/// The Julian to Gregorian calendar changeover occurred on 1582-10-15.
/// Julian Thursday 1582-10-04 was followed by Gregorian Friday 1582-10-15.
///
/// Julian day number values less than this value are typically interpreted in the Julian calendar while greater or equal values are typically interpreted in the Gregorian calendar.
///
/// This JDN corresponds to 1582-10-15 12:00 in the Gregorian calendar.
///
/// - note: The actual adoption date of the Gregorian calendar varies by country.
public let gregorianCalendarChangeoverJDN = 2299161

/// The Julian date of the changeover from Julian to Gregorian calendars.
///
/// The Julian to Gregorian calendar changeover occurred on 1582-10-15.
/// Julian Thursday 1582-10-04 was followed by Gregorian Friday 1582-10-15.
///
/// Julian date values less than this value are typically interpreted in the Julian calendar while greater or equal values are typically interpreted in the Gregorian calendar.
///
/// This JD corresponds to 1582-10-15 00:00 in the Gregorian calendar.
///
/// - note: The actual adoption date of the Gregorian calendar varies by country.
public let gregorianCalendarChangeoverJD = 2299160.5
