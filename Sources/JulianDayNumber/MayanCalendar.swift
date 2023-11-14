//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// The Mayan calendar.
///
/// The Mayan calendar is a system of calendars consisting of several cycles of different lengths.
///
/// The Long Count is the principal calendar for historical purposes.
///
/// A long count consists of a hierarchy of cycles.
///
/// | Cycle | Composition | Total Days | Approx. Years |
/// | --- | --- | --- | --- |
/// | Kin | | 1 | |
/// | Uinal | 20 Kin | 20 | |
/// | Tun | 18 Uinal | 360 | 0.986 |
/// | Katun | 20 Tun | 7,200 | 19.7 |
/// | Baktun | 20 Katun | 144,000 | 394.3 |
/// | Pictun | 20 Baktun | 2,880,000 | 7,885 |
/// | Calabtun | 20 Pictun | 57,600,000 | 157,704 |
/// | Kinchiltun | 20 Calabtun | 1,152,000,000 | 3,154,071 |
/// | Alautun | 20 Kinchiltun | 23,040,000,000 | 63,081,429 |
///
/// Long counts are typically written as *baktun* . *katun* . *tun* . *uinal* . *kin* with each value starting at zero.
///
/// The Tzolkʼin is a 260-day calendar used for religious purposes.
///
/// A Tzolkʼin date is composed of a number from one to thirteen and a day name.
///
/// | Sequence | Tzolkʼin Day Name |
/// | ---: | --- |
/// | 1 | Imix |
/// | 2 | Ikʼ |
/// | 3 | Akʼbʼal |
/// | 4 | Kʼan |
/// | 5 | Chikchan |
/// | 6 | Kimi |
/// | 7 | Manikʼ |
/// | 8 | Lamat |
/// | 9 | Muluk |
/// | 10 | Ok |
/// | 11 | Chuwen |
/// | 12 | Ebʼ |
/// | 13 | Bʼen |
/// | 14 | Ix |
/// | 15 | Men |
/// | 16 | Kibʼ |
/// | 17 | Kabʼan |
/// | 18 | Etzʼnabʼ |
/// | 19 | Kawak |
/// | 20 | Ajaw |
///
/// The Haabʼ is a 365-day calendar used for civil purposes.
///
/// A Haabʼ date is composed of a day from zero to nineteen and a month.
///
/// | Sequence | Haabʼ Month |
/// | ---: | --- |
/// | 1 | Pop |
/// | 2 | Woʼ |
/// | 3 | Sip |
/// | 4 | Sotzʼ |
/// | 5 | Sek |
/// | 6 | Xul |
/// | 7 | Yaxkʼin |
/// | 8 | Mol |
/// | 9 | Chʼen |
/// | 10 | Yax |
/// | 11 | Sakʼ |
/// | 12 | Keh |
/// | 13 | Mak |
/// | 14 | Kʼankʼin |
/// | 15 | Muwan |
/// | 16 | Pax |
/// | 17 | Kʼayabʼ |
/// | 18 | Kumkʼu |
/// | 19 | Five unlucky days called Wayebʼ |
///
/// A Calendar Round is a repeating cycle of 18,980 days and consists of the combination of a Tzolkʼin date and a Haabʼ date.
///
/// The Mayan long count calendar epoch in the Julian calendar is September 6, 3114 BC.
///
/// - seealso: [Maya calendar](https://en.wikipedia.org/wiki/Maya_calendar)
/// - seealso: [Mesoamerican Long Count calendar](https://en.wikipedia.org/wiki/Mesoamerican_Long_Count_calendar)
/// - seealso: [Tzolkʼin](https://en.wikipedia.org/wiki/Tzolkʼin)
/// - seealso: [Haabʼ](https://en.wikipedia.org/wiki/Haabʼ)
public struct MayanCalendar {
	/// The Julian day number of the Goodman-Martinez-Thompson correlation constant for the long count of the Mayan calendar.
	///
	/// This JDN corresponds to noon on September 6, 3114 BC in the Julian calendar.
	public static let longCountEpochJulianDayNumber: JulianDayNumber = 584283

	/// The Julian day number of the start of the Tzolk’in cycle of the Mayan calendar.
	///
	/// The Tzolk’in cycle began 159 days before the long count epoch.
	/// The Tzolk’in date at the long count epoch was 4 Ajaw.
	public static let tzolkinEpochJulianDayNumber: JulianDayNumber = longCountEpochJulianDayNumber - 159

	/// The Julian day number of the start of the Haabʼ cycle of the Mayan calendar.
	///
	/// The Haabʼ cycle began 348 days before the long count epoch.
	/// The Haabʼ date at the long count epoch was 8 Kumkʼu.
	public static let haabEpochJulianDayNumber: JulianDayNumber = longCountEpochJulianDayNumber - 348

	/// A kin is one day and is numbered from `0` to `19`.
	public typealias Kin = Int
	/// A uinal is 20 kin and is numbered from `0` to `19`.
	public typealias Uinal = Int
	/// A tun is 18 uinal and is numbered from `0` to `17`.
	public typealias Tun = Int
	/// A katun is 20 tun and is numbered from `0` to `19`.
	public typealias Katun = Int
	/// A baktun is 20 katun and is numbered from `0` to `19`.
	public typealias Baktun = Int
	/// A pictun is 20 baktun and is numbered from `0` to `19`.
	public typealias Pictun = Int
	/// A calabtun is 20 pictun and is numbered from `0` to `19`.
	public typealias Calabtun = Int
	/// A kinchiltun is 20 calabtun and is numbered from `0` to `19`.
	public typealias Kinchiltun = Int
	/// An alautun is 20 kinchiltun and is numbered from `0` to `19`.
	public typealias Alautun = Int

	/// A Tzolk’in number from `1` to `13`.
	public typealias TzolkinNumber = Int
	/// A Tzolk’in day name from `1` to `20`.
	public typealias TzolkinDayName = Int

	/// A Haabʼ day from `0` to `19`.
	public typealias HaabDay = Int
	/// A Haabʼ month from `1` to `19`.
	public typealias HaabMonth = Int
}
