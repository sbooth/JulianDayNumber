//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

/// The Maya calendar.
///
/// The Maya calendar is a system of calendars consisting of several cycles of different lengths.
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
/// The Maya long count calendar epoch in the Julian calendar is September 6, 3114 BCE.
///
/// - seealso: [Maya calendar](https://en.wikipedia.org/wiki/Maya_calendar)
/// - seealso: [Mesoamerican Long Count calendar](https://en.wikipedia.org/wiki/Mesoamerican_Long_Count_calendar)
/// - seealso: [Tzolkʼin](https://en.wikipedia.org/wiki/Tzolkʼin)
/// - seealso: [Haabʼ](https://en.wikipedia.org/wiki/Haabʼ)
public struct MayaCalendar: CalendarProtocol {
	/// The Julian day number of the Goodman-Martinez-Thompson correlation constant for the long count of the Maya calendar.
	///
	/// This JDN corresponds to September 6, 3114 BCE in the Julian calendar.
	public static let epoch = longCountEpoch

	/// The Julian day number of the Goodman-Martinez-Thompson correlation constant for the long count of the Maya calendar.
	///
	/// This JDN corresponds to September 6, 3114 BCE in the Julian calendar.
	public static let longCountEpoch: JulianDayNumber = 584283

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

	/// A long count in the Maya calendar.
	public typealias DateType = (baktun: Baktun, katun: Katun, tun: Tun, uinal: Uinal, kin: Kin)

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		julianDayNumberFromLongCount(baktun: date.baktun, katun: date.katun, tun: date.tun, uinal: date.uinal, kin: date.kin)
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		longCountFromJulianDayNumber(J)
	}

	public static func isValidDate(_ date: DateType) -> Bool {
		date.baktun >= 0 && date.baktun <= 19 &&
		date.katun >= 0 && date.katun <= 19 &&
		date.tun >= 0 && date.tun <= 17 &&
		date.uinal >= 0 && date.uinal <= 19 &&
		date.kin >= 0 && date.kin <= 19
	}
}

// Maya long count cycle lengths

/// One uinal is composed of 20 kin.
let kinPerUinal = 20
/// One tun is composed of 18 uinal.
let uinalPerTun = 18
/// One katun is composed of 20 tun.
let tunPerKatun = 20
/// One baktun is composed of 20 katun.
let katunPerBaktun = 20
/// One pictun is composed of 20 baktun.
let baktunPerPictun = 20
/// One calabtun is composed of 20 pictun.
let pictunPerCalabtun = 20
/// One kinchiltun is composed of 20 calabtun.
let calabtunPerKinchiltun = 20
/// One alautun is composed of 20 kinchiltun.
let kinchiltunPerAlautun = 20

extension MayaCalendar {
	/// Converts a Julian day number to a long count in the Maya calendar.
	///
	/// - parameter J: A Julian day number.
	///
	/// - returns: The long count corresponding to the specified Julian day number.
	public static func longCountFromJulianDayNumber(_ J: JulianDayNumber) -> (/*alautun: Alautun, kinchiltun: Kinchiltun, calabtun: Calabtun, pictun: Pictun, */baktun: Baktun, katun: Katun, tun: Tun, uinal: Uinal, kin: Kin) {
		let L = J - longCountEpoch

#if false
		var alautun, kinchiltun, calabtun, pictun: Int
#endif
		var baktun, katun, tun, uinal, kin: Int

		(uinal, kin) = L.quotientAndRemainder(dividingBy: kinPerUinal)
		(tun, uinal) = uinal.quotientAndRemainder(dividingBy: uinalPerTun)
		(katun, tun) = tun.quotientAndRemainder(dividingBy: tunPerKatun)
		(baktun, katun) = katun.quotientAndRemainder(dividingBy: katunPerBaktun)
#if false
		(pictun, baktun) = baktun.quotientAndRemainder(dividingBy: baktunPerPictun)
		(calabtun, pictun) = pictun.quotientAndRemainder(dividingBy: pictunPerCalabtun)
		(kinchiltun, calabtun) = calabtun.quotientAndRemainder(dividingBy: calabtunPerKinchiltun)
		(alautun, kinchiltun) = kinchiltun.quotientAndRemainder(dividingBy: kinchiltunPerAlautun)
#endif

		if L < 0 {
			if kin < 0 {
				kin += kinPerUinal
				uinal -= 1
			}
			if uinal < 0 {
				uinal += uinalPerTun
				tun -= 1
			}
			if tun < 0 {
				tun += tunPerKatun
				katun -= 1
			}
			if katun < 0 {
				katun += katunPerBaktun
				baktun -= 1
			}
#if false
			if baktun < 1 - baktunPerPictun {
				baktun += baktunPerPictun
				pictun -= 1
			}
			if pictun < 1 - pictunPerCalabtun {
				pictun += pictunPerCalabtun
				calabtun -= 1
			}
			if calabtun < 1 - calabtunPerKinchiltun {
				calabtun += calabtunPerKinchiltun
				kinchiltun -= 1
			}
			if kinchiltun < 1 - kinchiltunPerAlautun {
				kinchiltun += kinchiltunPerAlautun
				alautun -= 1
			}
#endif
		}

		return (/*alautun, kinchiltun, calabtun, pictun, */baktun, katun, tun, uinal, kin)
	}

	/// Converts a long count in the Maya calendar to a Julian day number.
	///
	/// - note: No validation checks are performed on the cycle values.
	///
	/// - parameter alautun: An alautun number.
	/// - parameter kinchiltun: A kinchiltun number.
	/// - parameter calabtun: A calabtun number.
	/// - parameter pictun: A pictun number.
	/// - parameter baktun: A baktun number.
	/// - parameter katun: A katun number.
	/// - parameter tun: A tun number.
	/// - parameter uinal: A uinal number.
	/// - parameter kin: A kin number.
	///
	/// - returns: The Julian day number corresponding to the specified long count.
	public static func julianDayNumberFromLongCount(alautun: Alautun = 0, kinchiltun: Kinchiltun = 0, calabtun: Calabtun = 0, pictun: Pictun = 0, baktun: Baktun, katun: Katun, tun: Tun, uinal: Uinal, kin: Kin) -> JulianDayNumber {
		longCountEpoch + (((((((alautun * kinchiltunPerAlautun + kinchiltun) * calabtunPerKinchiltun + calabtun) * pictunPerCalabtun + pictun) * baktunPerPictun + baktun) * katunPerBaktun + katun) * tunPerKatun + tun) * uinalPerTun + uinal) * kinPerUinal + kin
	}
}

extension MayaCalendar {
	/// The Julian day number of the start of the Tzolk’in cycle of the Maya calendar.
	///
	/// The Tzolk’in cycle began 159 days before the long count epoch.
	/// The Tzolk’in date at the long count epoch was 4 Ajaw.
	public static let tzolkinEpoch: JulianDayNumber = longCountEpoch - 159

	/// The Julian day number of the start of the Haabʼ cycle of the Maya calendar.
	///
	/// The Haabʼ cycle began 348 days before the long count epoch.
	/// The Haabʼ date at the long count epoch was 8 Kumkʼu.
	public static let haabEpoch: JulianDayNumber = longCountEpoch - 348

	/// A Tzolk’in number from `1` to `13`.
	public typealias TzolkinNumber = Int
	/// A Tzolk’in day name from `1` to `20`.
	public typealias TzolkinDayName = Int

	/// A Haabʼ day from `0` to `19`.
	public typealias HaabDay = Int
	/// A Haabʼ month from `1` to `19`.
	public typealias HaabMonth = Int

	/// A Calendar Round in the Maya calendar.
	public typealias CalendarRound = (number: TzolkinNumber, name: TzolkinDayName, day: HaabDay, month: HaabMonth)

	/// Converts a Julian day number to a Calendar Round in the Maya calendar.
	///
	/// - note: A Calendar Round corresponding to a Julian day number
	/// can also be represented by the same Julian day number with multiples
	/// of 18,980 days added or subtracted.
	///
	/// - parameter J: A Julian day number.
	///
	/// - returns: The Calendar Round corresponding to the specified Julian day number.
	public static func calendarRoundFromJulianDayNumber(_ J: JulianDayNumber) -> CalendarRound {
		let T = J - tzolkinEpoch
		let H = J - haabEpoch

		let (number, name) = (T % 13 + 1, T % 20)
		let (month, day) = (H % 365).quotientAndRemainder(dividingBy: 20)

		return (number, name + 1, day, month + 1)
	}

	/// Returns the most recent Julian day number for a Calendar Round in the Maya calendar occurring before a Julian day number.
	///
	/// - important: Not all combinations of Tzolkʼin and Haabʼ dates are valid.
	///
	/// - parameter number: A Tzolkʼin number.
	/// - parameter name: A Tzolkʼin day name.
	/// - parameter day: A Haabʼ day.
	/// - parameter month: A Haabʼ month.
	/// - parameter J0: A Julian day number to anchor the Calendar Round.
	///
	/// - returns: The most recent Julian day number corresponding to the specified Calendar Round occurring before the specified Julian day number or `nil` if none.
	public static func julianDayNumberFromCalendarRound(number: TzolkinNumber, name: TzolkinDayName, day: HaabDay, month: HaabMonth, before J0: JulianDayNumber) -> JulianDayNumber? {
		guard let J = julianDayNumberFromCalendarRound(number: number, name: name, day: day, month: month) else {
			return nil
		}
		return J0 + (J - J0) % 18980 - 18980
	}

	/// Returns the least recent Julian day number for a Calendar Round in the Maya calendar occurring on or after a Julian day number.
	///
	/// - important: Not all combinations of Tzolkʼin and Haabʼ dates are valid.
	///
	/// - parameter number: A Tzolkʼin number.
	/// - parameter name: A Tzolkʼin day name.
	/// - parameter day: A Haabʼ day.
	/// - parameter month: A Haabʼ month.
	/// - parameter J0: A Julian day number to anchor the Calendar Round.
	///
	/// - returns: The least recent Julian day number corresponding to the specified Calendar Round occurring on or after the specified Julian day number or `nil` if none.
	public static func julianDayNumberFromCalendarRound(number: TzolkinNumber, name: TzolkinDayName, day: HaabDay, month: HaabMonth, onOrAfter J0: JulianDayNumber = longCountEpoch) -> JulianDayNumber? {
		guard let J = julianDayNumberFromCalendarRound(number: number, name: name, day: day, month: month) else {
			return nil
		}
		return J0 - (J0 - J) % 18980 //+ 18980
	}

	/// Returns a possible Julian day number for a Calendar Round in the Maya calendar.
	///
	/// - parameter number: A Tzolkʼin number.
	/// - parameter name: A Tzolkʼin day name.
	/// - parameter day: A Haabʼ day.
	/// - parameter month: A Haabʼ month.
	///
	/// - returns: A possible Julian day number corresponding to the specified Calendar Round or `nil` if none.
	static func julianDayNumberFromCalendarRound(number: TzolkinNumber, name: TzolkinDayName, day: HaabDay, month: HaabMonth) -> JulianDayNumber? {
		// The number of days into the Tzolkʼin cycle
		let T = (40 * number + 221 * name - 1) % 260

		// The number of days into the Haabʼ cycle
		let H = 20 * (month - 1) + day

		// Not all combinations of H and T are valid
		guard (H - T) % 5 == 4 else {
			return nil
		}

		return (365 * T - 364 * H + 7600) % 18980
	}
}

extension MayaCalendar {
	/// Returns the Lord of the Night for a given uinal and kin.
	///
	/// The Lord of the Night is a nine-day cycle conventionally labeled G1 through G9.
	///
	/// The Lord of the Night at the long count epoch was G9.
	///
	/// - parameter uinal: A uinal number.
	/// - parameter kin: A kin number.
	///
	/// - returns: The Lord of the Night corresponding to the specified uinal and kin.
	public static func lordOfTheNightFrom(uinal: Uinal, kin: Kin) -> Int {
		(20 * uinal + kin + 8) % 9 + 1
	}
}
