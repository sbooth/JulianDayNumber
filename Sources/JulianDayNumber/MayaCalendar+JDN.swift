//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

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

extension MayaCalendar: JulianDayNumberConverting {
	/// A long count in the Maya calendar.
	public typealias DateType = (baktun: Baktun, katun: Katun, tun: Tun, uinal: Uinal, kin: Kin)

	public static func julianDayNumberFromDate(_ date: DateType) -> JulianDayNumber {
		julianDayNumberFromLongCount(baktun: date.baktun, katun: date.katun, tun: date.tun, uinal: date.uinal, kin: date.kin)
	}

	public static func dateFromJulianDayNumber(_ J: JulianDayNumber) -> DateType {
		longCountFromJulianDayNumber(J)
	}
}

extension MayaCalendar {
	/// Converts a Julian day number to a long count in the Maya calendar.
	///
	/// - parameter J: A Julian day number.
	///
	/// - returns: The long count corresponding to the specified Julian day number.
	public static func longCountFromJulianDayNumber(_ J: JulianDayNumber) -> (/*alautun: Alautun, kinchiltun: Kinchiltun, calabtun: Calabtun, pictun: Pictun, */baktun: Baktun, katun: Katun, tun: Tun, uinal: Uinal, kin: Kin) {
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
		longCountEpochJulianDayNumber + (((((((alautun * kinchiltunPerAlautun + kinchiltun) * calabtunPerKinchiltun + calabtun) * pictunPerCalabtun + pictun) * baktunPerPictun + baktun) * katunPerBaktun + katun) * tunPerKatun + tun) * uinalPerTun + uinal) * kinPerUinal + kin
	}
}

extension MayaCalendar {
	/// Converts a Julian day number to a Calendar Round in the Maya calendar.
	///
	/// - note: A Calendar Round corresponding to a Julian day number
	/// can also be represented by the same Julian day number with multiples
	/// of 18,980 days added or subtracted.
	///
	/// - parameter J: A Julian day number.
	///
	/// - returns: The Calendar Round corresponding to the specified Julian day number.
	public static func calendarRoundFromJulianDayNumber(_ J: JulianDayNumber) -> (number: TzolkinNumber, name: TzolkinDayName, day: HaabDay, month: HaabMonth) {
		let T = J - tzolkinEpochJulianDayNumber
		let H = J - haabEpochJulianDayNumber

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
	public static func julianDayNumberFromCalendarRound(number: TzolkinNumber, name: TzolkinDayName, day: HaabDay, month: HaabMonth, onOrAfter J0: JulianDayNumber = longCountEpochJulianDayNumber) -> JulianDayNumber? {
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
