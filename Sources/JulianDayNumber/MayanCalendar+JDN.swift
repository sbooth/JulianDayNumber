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

		var alautun, kinchiltun, calabtun, pictun, baktun, katun, tun, uinal, kin: Int

		(uinal, kin) = L.quotientAndRemainder(dividingBy: kinPerUinal)
		(tun, uinal) = uinal.quotientAndRemainder(dividingBy: uinalPerTun)
		(katun, tun) = tun.quotientAndRemainder(dividingBy: tunPerKatun)
		(baktun, katun) = katun.quotientAndRemainder(dividingBy: katunPerBaktun)
		(pictun, baktun) = baktun.quotientAndRemainder(dividingBy: baktunPerPictun)
		(calabtun, pictun) = pictun.quotientAndRemainder(dividingBy: pictunPerCalabtun)
		(kinchiltun, calabtun) = calabtun.quotientAndRemainder(dividingBy: calabtunPerKinchiltun)
		(alautun, kinchiltun) = kinchiltun.quotientAndRemainder(dividingBy: kinchiltunPerAlautun)

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
	static let tzolkinEpochJulianDayNumber: JulianDayNumber = longCountEpochJulianDayNumber - 159

	/// The Julian day number of the start of the Haab cycle of the Mayan calendar.
	///
	/// The Haab cycle began 348 days before the long count epoch.
	static let haabEpochJulianDayNumber: JulianDayNumber = longCountEpochJulianDayNumber - 348

	/// A Tzolk'in day name.
	///
	/// - seealso: [Tzolkʼin](https://en.wikipedia.org/wiki/Tzolkʼin)
	public enum TzolkinDayName: Int {
		/// Imix
		case imix = 1
		/// Ik'
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

	/// A Haab' month.
	///
	/// - seealso: [Haab'](https://en.wikipedia.org/wiki/Haabʼ)
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

	/// Converts a Julian day number to a round date in the Mayan calendar.
	///
	/// A Mayan round date consists of a two distinct dates:
	/// - A Tzolkʼin date comprised of a number in the interval `[1, 13]` and a name
	/// - A Haab' comprised of a day in the interval `[0, 19]` and a month.
	///
	/// - parameter J: A Julian day number.
	///
	/// - returns: A round date corresponding to the specified Julian day number.
	public static func roundDateFromJulianDayNumber(_ J: JulianDayNumber) -> (number: Int, name: TzolkinDayName, day: Int, month: HaabMonth) {
		let T = J - tzolkinEpochJulianDayNumber
		let H = J - haabEpochJulianDayNumber

		let (number, name) = (T % 13 + 1, T % 20)
		let (month, day) = (H % 365).quotientAndRemainder(dividingBy: 20)

		return (number, TzolkinDayName(rawValue: name + 1)!, day, HaabMonth(rawValue: month + 1)!)
	}
}
