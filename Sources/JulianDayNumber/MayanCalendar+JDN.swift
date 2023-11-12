//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

// Mayan long count cycle lengths

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

extension MayanCalendar {
	/// Converts a Julian day number to a long count in the Mayan calendar.
	///
	/// - parameter J: A Julian day number.
	///
	/// - returns: The long count corresponding to the specified Julian day number.
	public static func longCountFromJulianDayNumber(_ J: JulianDayNumber) -> (/*alautun: Int, kinchiltun: Int, calabtun: Int, pictun: Int, */baktun: Int, katun: Int, tun: Int, uinal: Int, kin: Int) {
		let L = J - longCountEpochJulianDayNumber

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

	/// Converts a long count in the Mayan calendar to a Julian day number.
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
	public static func julianDayNumberFromLongCount(alautun: Int = 0, kinchiltun: Int = 0, calabtun: Int = 0, pictun: Int = 0, baktun: Int, katun: Int, tun: Int, uinal: Int, kin: Int) -> JulianDayNumber {
		longCountEpochJulianDayNumber + (((((((alautun * kinchiltunPerAlautun + kinchiltun) * calabtunPerKinchiltun + calabtun) * pictunPerCalabtun + pictun) * baktunPerPictun + baktun) * katunPerBaktun + katun) * tunPerKatun + tun) * uinalPerTun + uinal) * kinPerUinal + kin
	}
}

extension MayanCalendar {
	/// The Julian day number of the start of the Tzolk’in cycle of the Mayan calendar.
	///
	/// The Tzolk’in cycle began 159 days before the long count epoch.
	/// The Tzolk’in date at the long count epoch was 4 Ajaw.
	static let tzolkinEpochJulianDayNumber: JulianDayNumber = longCountEpochJulianDayNumber - 159

	/// The Julian day number of the start of the Haabʼ cycle of the Mayan calendar.
	///
	/// The Haabʼ cycle began 348 days before the long count epoch.
	/// The Haabʼ date at the long count epoch was 8 Kumkʼu.
	static let haabEpochJulianDayNumber: JulianDayNumber = longCountEpochJulianDayNumber - 348

	/// A Tzolk'in day name.
	///
	/// - seealso: [Tzolkʼin](https://en.wikipedia.org/wiki/Tzolkʼin)
	public enum TzolkinDayName: Int {
		/// Imix
		case imix = 1
		/// Ikʼ
		case ik
		/// Akʼbʼal
		case akbal
		/// Kʼan
		case kan
		/// Chikchan
		case chicchan
		/// Kimi
		case cimi
		/// Manikʼ
		case manik
		/// Lamat
		case lamat
		/// Muluk
		case muluc
		/// Ok
		case oc
		/// Chuwen
		case chuen
		/// Ebʼ
		case eb
		/// Bʼen
		case ben
		/// Ix
		case ix
		/// Men
		case men
		/// Kibʼ
		case cib
		/// Kabʼan
		case caban
		/// Etzʼnabʼ
		case etznab
		/// Kawak
		case cauac
		/// Ajaw
		case ahau
	}

	/// A Haabʼ month.
	///
	/// - seealso: [Haabʼ](https://en.wikipedia.org/wiki/Haabʼ)
	public enum HaabMonth: Int {
		/// Pop
		case pop = 1
		/// Woʼ
		case uo
		/// Sip
		case zip
		/// Sotzʼ
		case zotz
		/// Sek
		case tzec
		/// Xul
		case xul
		/// Yaxkʼin
		case yaxkin
		/// Mol
		case mol
		/// Chʼen
		case chen
		/// Yax
		case yax
		/// Sakʼ
		case zac
		/// Keh
		case ceh
		/// Mak
		case mac
		/// Kʼankʼin
		case kankin
		/// Muwan
		case muan
		/// Pax
		case pax
		/// Kʼayabʼ
		case kayab
		/// Kumkʼu
		case cumku
		/// Five unlucky days called Wayebʼ
		case uayeb
	}

	/// Converts a Julian day number to a Calendar Round in the Mayan calendar.
	///
	/// A Calendar Round is a repeating cycle of 18,980 days and consists of two distinct dates:
	/// - A Tzolkʼin date comprised of a number in the interval `[1, 13]` and a name.
	/// - A Haabʼ date comprised of a day in the interval `[0, 19]` and a month.
	///
	/// - note: A Calendar Round corresponding to a Julian day number
	/// can also be represented by the same Julian day number with multiples
	/// of 18,980 days added or subtracted.
	///
	/// - parameter J: A Julian day number.
	///
	/// - returns: The Calendar Round corresponding to the specified Julian day number.
	public static func calendarRoundFromJulianDayNumber(_ J: JulianDayNumber) -> (number: Int, name: TzolkinDayName, day: Int, month: HaabMonth) {
		let T = J - tzolkinEpochJulianDayNumber
		let H = J - haabEpochJulianDayNumber

		let (number, name) = (T % 13 + 1, T % 20)
		let (month, day) = (H % 365).quotientAndRemainder(dividingBy: 20)

		return (number, TzolkinDayName(rawValue: name + 1)!, day, HaabMonth(rawValue: month + 1)!)
	}

	/// Returns the most recent Julian day number for a Calendar Round in the Mayan calendar occurring before a Julian day number.
	///
	/// A Calendar Round is a repeating cycle of 18,980 days and consists of two distinct dates:
	/// - A Tzolkʼin date comprised of a number in the interval `[1, 13]` and a name.
	/// - A Haabʼ date comprised of a day in the interval `[0, 19]` and a month.
	///
	/// - note: Not all combinations of Tzolkʼin and Haabʼ dates are valid.
	///
	/// - parameter number: A Tzolkʼin number in the interval `[1, 13]`.
	/// - parameter name: A Tzolkʼin name.
	/// - parameter day: A Haabʼ day in the interval `[0, 19]`.
	/// - parameter month: A Haabʼ month.
	/// - parameter J0: A Julian day number to anchor the Calendar Round.
	///
	/// - returns: The most recent Julian day number corresponding to the specified Calendar Round occurring before the specified Julian day number or `nil` if none.
	public static func julianDayNumberFromCalendarRound(number: Int, name: TzolkinDayName, day: Int, month: HaabMonth, before J0: JulianDayNumber) -> JulianDayNumber? {
		guard let J = julianDayNumberFromCalendarRound(number: number, name: name, day: day, month: month) else {
			return nil
		}
		return J0 + (J - J0) % 18980 - 18980
	}

	/// Returns the least recent Julian day number for a Calendar Round in the Mayan calendar occurring on or after a Julian day number.
	///
	/// A Calendar Round is a repeating cycle of 18,980 days and consists of two distinct dates:
	/// - A Tzolkʼin date comprised of a number in the interval `[1, 13]` and a name.
	/// - A Haabʼ date comprised of a day in the interval `[0, 19]` and a month.
	///
	/// - note: Not all combinations of Tzolkʼin and Haabʼ dates are valid.
	///
	/// - parameter number: A Tzolkʼin number in the interval `[1, 13]`.
	/// - parameter name: A Tzolkʼin name.
	/// - parameter day: A Haabʼ day in the interval `[0, 19]`.
	/// - parameter month: A Haabʼ month.
	/// - parameter J0: A Julian day number to anchor the Calendar Round.
	///
	/// - returns: The least recent Julian day number corresponding to the specified Calendar Round occurring on or after the specified Julian day number or `nil` if none.
	public static func julianDayNumberFromCalendarRound(number: Int, name: TzolkinDayName, day: Int, month: HaabMonth, onOrAfter J0: JulianDayNumber = longCountEpochJulianDayNumber) -> JulianDayNumber? {
		guard let J = julianDayNumberFromCalendarRound(number: number, name: name, day: day, month: month) else {
			return nil
		}
		return J0 - (J0 - J) % 18980 //+ 18980
	}

	/// Returns a possible Julian day number for a Calendar Round in the Mayan calendar.
	///
	/// - parameter number: A Tzolkʼin number in the interval `[1, 13]`.
	/// - parameter name: A Tzolkʼin name.
	/// - parameter day: A Haabʼ day in the interval `[0, 19]`.
	/// - parameter month: A Haabʼ month.
	///
	/// - returns: A possible Julian day number corresponding to the specified Calendar Round or `nil` if none.
	static func julianDayNumberFromCalendarRound(number: Int, name: TzolkinDayName, day: Int, month: HaabMonth) -> JulianDayNumber? {
		// The number of days into the Tzolkʼin cycle
		let T = (40 * number + 221 * name.rawValue - 1) % 260

		// The number of days into the Haabʼ cycle
		let H = 20 * (month.rawValue - 1) + day

		// Not all combinations of H and T are valid
		guard (H - T) % 5 == 4 else {
			return nil
		}

		return (365 * T - 364 * H + 7600) % 18980
	}
}

extension MayanCalendar {
	/// Returns the Lord of the Night for the given uinal and kin.
	///
	/// - parameter uinal: A uinal number.
	/// - parameter kin: A kin number.
	///
	/// - returns: The Lord of the Night corresponding to the specified uinal and kin.
	public static func lordOfTheNightFrom(uinal: Int, kin: Int) -> Int {
		(20 * uinal + kin + 8) % 9 + 1
	}
}
