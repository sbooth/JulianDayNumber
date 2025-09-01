//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Testing
@testable import JulianDayNumber

@Suite struct AstronomicalCalendarTests {
	@Test func epoch() throws {
		#expect(try AstronomicalCalendar.julianDayNumberFrom(year: 1, month: 1, day: 1) == AstronomicalCalendar.epoch)
		#expect(try AstronomicalCalendar.dateFromJulianDayNumber(AstronomicalCalendar.epoch) == (1, 1, 1))
	}

	@Test func dateValidation() {
		#expect(AstronomicalCalendar.isValid(year: 1969, month: 7, day: 20))
		#expect(!AstronomicalCalendar.isValid(year: 1969, month: 7, day: 40))
		#expect(AstronomicalCalendar.isValid(year: 1600, month: 2, day: 29))
		#expect(!AstronomicalCalendar.isValidDate((1582, 10, 10)))
	}

	@Test func leapYear() throws {
		#expect(AstronomicalCalendar.isLeapYear(900))
		#expect(!AstronomicalCalendar.isLeapYear(1700))

		for y in -1000...2000 {
			let isLeap = AstronomicalCalendar.isLeapYear(y)
			let j = try AstronomicalCalendar.julianDayNumberFrom(year: y, month: 2, day: isLeap ? 29 : 28)
			let d = try AstronomicalCalendar.dateFromJulianDayNumber(j)
			#expect(d.month == 2)
			#expect(d.day == (isLeap ? 29 : 28))
		}
	}

	@Test func monthCount() {
		#expect(AstronomicalCalendar.numberOfMonthsInYear == 12)
	}

	@Test func monthLength() {
		#expect(AstronomicalCalendar.numberOfDaysIn(month: 1, year: 1900) == 31)
		#expect(AstronomicalCalendar.numberOfDaysIn(month: 2, year: 1900) == 28)
		#expect(AstronomicalCalendar.numberOfDaysIn(month: 3, year: 1900) == 31)
		#expect(AstronomicalCalendar.numberOfDaysIn(month: 4, year: 1900) == 30)
		#expect(AstronomicalCalendar.numberOfDaysIn(month: 5, year: 1900) == 31)
		#expect(AstronomicalCalendar.numberOfDaysIn(month: 6, year: 1900) == 30)
		#expect(AstronomicalCalendar.numberOfDaysIn(month: 7, year: 1900) == 31)
		#expect(AstronomicalCalendar.numberOfDaysIn(month: 8, year: 1900) == 31)
		#expect(AstronomicalCalendar.numberOfDaysIn(month: 9, year: 1900) == 30)
		#expect(AstronomicalCalendar.numberOfDaysIn(month: 10, year: 1900) == 31)
		#expect(AstronomicalCalendar.numberOfDaysIn(month: 11, year: 1900) == 30)
		#expect(AstronomicalCalendar.numberOfDaysIn(month: 12, year: 1900) == 31)
		#expect(AstronomicalCalendar.numberOfDaysIn(month: 2, year: 1600) == 29)
	}

	@Test func changeover() throws {
		#expect(AstronomicalCalendar.numberOfDaysIn(month: 10, year: 1582) == 21)
		let oct1 = try AstronomicalCalendar.julianDayNumberFrom(year: 1582, month: 10, day: 1)
		let oct31 = try AstronomicalCalendar.julianDayNumberFrom(year: 1582, month: 10, day: 31)
		#expect(AstronomicalCalendar.numberOfDaysIn(month: 10, year: 1582) == (oct31 - oct1 + 1))

		#expect(AstronomicalCalendar.numberOfDaysIn(month: 9, year: 1582) == JulianCalendar.numberOfDaysIn(month: 9, year: 1582))
		#expect(AstronomicalCalendar.numberOfDaysIn(month: 11, year: 1582) == GregorianCalendar.numberOfDaysIn(month: 11, year: 1582))

		#expect(AstronomicalCalendar.isValid(year: 1582, month: 10, day: 3) == true)
		#expect(AstronomicalCalendar.isValid(year: 1582, month: 10, day: 4) == true)
		for day in 5...14 {
			#expect(AstronomicalCalendar.isValid(year: 1582, month: 10, day: day) == false)
		}
		#expect(AstronomicalCalendar.isValid(year: 1582, month: 10, day: 15) == true)
		#expect(AstronomicalCalendar.isValid(year: 1582, month: 10, day: 16) == true)

		#expect(try AstronomicalCalendar.dateFromJulianDayNumber(GregorianCalendar.effectiveJulianDayNumber) == (1582, 10, 15))
		#expect(try AstronomicalCalendar.julianDayNumberFrom(year: 1582, month: 10, day: 15) == GregorianCalendar.effectiveJulianDayNumber)

		#expect(try AstronomicalCalendar.dateFromJulianDayNumber(GregorianCalendar.effectiveJulianDayNumber - 1) == (1582, 10, 4))
		#expect(try AstronomicalCalendar.julianDayNumberFrom(year: 1582, month: 10, day: 4) == GregorianCalendar.effectiveJulianDayNumber - 1)

		#expect(AstronomicalCalendar.numberOfDays(inYear: 1582) == 355)
		let jan1 = try AstronomicalCalendar.julianDayNumberFrom(year: 1582, month: 1, day: 1)
		let dec31 = try AstronomicalCalendar.julianDayNumberFrom(year: 1582, month: 12, day: 31)
		#expect(AstronomicalCalendar.numberOfDays(inYear: 1582) == (dec31 - jan1 + 1))

		var sum = 0
		for m in 1...12 {
			sum += AstronomicalCalendar.numberOfDaysIn(month: m, year: 1582)
		}

		#expect(AstronomicalCalendar.numberOfDays(inYear: 1582) == sum)
		#expect(sum == (dec31 - jan1 + 1))
	}

	@Test func easter() {
		// Dates from Meeus (1998)
		#expect(AstronomicalCalendar.easter(year: 1991) == (3, 31))
		#expect(AstronomicalCalendar.easter(year: 1992) == (4, 19))
		#expect(AstronomicalCalendar.easter(year: 1993) == (4, 11))
		#expect(AstronomicalCalendar.easter(year: 1954) == (4, 18))
		#expect(AstronomicalCalendar.easter(year: 2000) == (4, 23))
		#expect(AstronomicalCalendar.easter(year: 1818) == (3, 22))
		#expect(AstronomicalCalendar.easter(year: 179) == (4, 12))
		#expect(AstronomicalCalendar.easter(year: 711) == (4, 12))
		#expect(AstronomicalCalendar.easter(year: 1243) == (4, 12))
	}

	@Test func julianDayNumber() throws {
		#expect(try AstronomicalCalendar.julianDayNumberFrom(year: -999999, month: 1, day: 1) == -363528576)
		#expect(try AstronomicalCalendar.julianDayNumberFrom(year: -99999, month: 1, day: 1) == -34803576)
		#expect(try AstronomicalCalendar.julianDayNumberFrom(year: -9999, month: 1, day: 1) == -1931076)
		#expect(try AstronomicalCalendar.julianDayNumberFrom(year: 9999, month: 12, day: 31) == 5373484)
		#expect(try AstronomicalCalendar.julianDayNumberFrom(year: 99999, month: 12, day: 31) == 38245309)
		#expect(try AstronomicalCalendar.julianDayNumberFrom(year: 999999, month: 12, day: 31) == 366963559)
		#expect(try AstronomicalCalendar.julianDayNumberFrom(year: -4712, month: 1, day: 1) == 0)
		#expect(try AstronomicalCalendar.julianDayNumberFrom(year: 1582, month: 10, day: 4) == 2299160)
		#expect(try AstronomicalCalendar.julianDayNumberFrom(year: 1582, month: 10, day: 15) == 2299161)
		// NASA (https://ssd.jpl.nasa.gov/tools/jdc/) uses the Gregorian calendar for dates after 1582-10-04.
		// This means that 1582-10-05 through 1582-10-14 are 10 JDN earlier than if the Julian calendar is used.
		// AstronomicalCalendar uses a different rule and uses the Julian calendar for dates before 1582-10-15.
		// I'm not sure why but who wants to argue with NASA?
//		#expect(try AstronomicalCalendar.julianDayNumberFrom(year: 1582, month: 10, day: 7) == 2299153)
		#expect(try AstronomicalCalendar.julianDayNumberFrom(year: 2000, month: 1, day: 1) == 2451545)
		#expect(try AstronomicalCalendar.julianDayNumberFrom(year: -5000, month: 1, day: 1) == -105192)

		#expect(try AstronomicalCalendar.dateFromJulianDayNumber(-363528576) == (-999999, 1, 1))
		#expect(try AstronomicalCalendar.dateFromJulianDayNumber(-34803576) == (-99999, 1, 1))
		#expect(try AstronomicalCalendar.dateFromJulianDayNumber(-1931076) == (-9999, 1, 1))
		#expect(try AstronomicalCalendar.dateFromJulianDayNumber(5373484) == (9999, 12, 31))
		#expect(try AstronomicalCalendar.dateFromJulianDayNumber(38245309) == (99999, 12, 31))
		#expect(try AstronomicalCalendar.dateFromJulianDayNumber(366963559) == (999999, 12, 31))
		#expect(try AstronomicalCalendar.dateFromJulianDayNumber(0) == (-4712, 1, 1))
		#expect(try AstronomicalCalendar.dateFromJulianDayNumber(2299160) == (1582, 10, 4))
		#expect(try AstronomicalCalendar.dateFromJulianDayNumber(2299161) == (1582, 10, 15))
		#expect(try AstronomicalCalendar.dateFromJulianDayNumber(2451545) == (2000, 1, 1))
		#expect(try AstronomicalCalendar.dateFromJulianDayNumber(-105192) == (-5000, 1, 1))

		#expect(try AstronomicalCalendar.julianDayNumberFrom(year: -9999, month: 1, day: 1) == JulianCalendar.julianDayNumberFrom(year: -9999, month: 1, day: 1))
		#expect(try AstronomicalCalendar.julianDayNumberFrom(year: 99999, month: 12, day: 31) != JulianCalendar.julianDayNumberFrom(year: 99999, month: 12, day: 31))
		#expect(try AstronomicalCalendar.julianDayNumberFrom(year: -4712, month: 1, day: 1) == JulianCalendar.julianDayNumberFrom(year: -4712, month: 1, day: 1))
		#expect(try AstronomicalCalendar.julianDayNumberFrom(year: 2000, month: 1, day: 1) != JulianCalendar.julianDayNumberFrom(year: 2000, month: 1, day: 1))
	}

	@Test func julianDate() throws {
		// Values from Meeus (1998)
		#expect(try AstronomicalCalendar.julianDateFrom(year: 2000, month: 1, day: 1.5) == 2451545)
		#expect(try AstronomicalCalendar.julianDateFrom(year: 1999, month: 1, day: 1) == 2451179.5)
		#expect(try AstronomicalCalendar.julianDateFrom(year: 1987, month: 1, day: 27, hour: 0) == 2446822.5)
		#expect(try AstronomicalCalendar.julianDateFrom(year: 1987, month: 6, day: 19.5) == 2446966)
		#expect(try AstronomicalCalendar.julianDateFrom(year: 1988, month: 1, day: 27) == 2447187.5)
		#expect(try AstronomicalCalendar.julianDateFrom(year: 1988, month: 6, day: 19, hour: 12) == 2447332.0)
		#expect(try AstronomicalCalendar.julianDateFrom(year: 1900, month: 1, day: 1) == 2415020.5)
		#expect(try AstronomicalCalendar.julianDateFrom(year: 1600, month: 1, day: 1) == 2305447.5)
		#expect(try AstronomicalCalendar.julianDateFrom(year: 1600, month: 12, day: 31) == 2305812.5)
		#expect(try AstronomicalCalendar.julianDateFrom(year: 837, month: 4, day: 10.3) == 2026871.8)
		#expect(try AstronomicalCalendar.julianDateFrom(year: -123, month: 12, day: 31.0) == 1676496.5)
		#expect(try AstronomicalCalendar.julianDateFrom(year: -122, month: 1, day: 1.0) == 1676497.5)
		#expect(try AstronomicalCalendar.julianDateFrom(year: -1000, month: 7, day: 12, hour: 12) == 1356001)
		#expect(try AstronomicalCalendar.julianDateFrom(year: -1000, month: 2, day: 29) == 1355866.5)
		#expect(try AstronomicalCalendar.julianDateFrom(year: -1001, month: 8, day: 17.9) == 1355671.4)
		#expect(try AstronomicalCalendar.julianDateFrom(year: -4712, month: 1, day: 1.5) == 0)

		#expect(try AstronomicalCalendar.dateAndTimeFromJulianDate(2451545) == (2000, 1, 1, 12, 0, 0))
		#expect(try AstronomicalCalendar.dateAndTimeFromJulianDate(2451179.5) == (1999, 1, 1, 0, 0, 0))
		#expect(try AstronomicalCalendar.dateAndTimeFromJulianDate(2446822.5) == (1987, 1, 27, 0, 0, 0))
		#expect(try AstronomicalCalendar.dateAndTimeFromJulianDate(2446966) == (1987, 6, 19, 12, 0, 0))
		#expect(try AstronomicalCalendar.dateAndTimeFromJulianDate(2447187.5) == (1988, 1, 27, 0, 0, 0))
		#expect(try AstronomicalCalendar.dateAndTimeFromJulianDate(2447332.0) == (1988, 6, 19, 12, 0, 0))
		#expect(try AstronomicalCalendar.dateAndTimeFromJulianDate(2415020.5) == (1900, 1, 1, 0, 0, 0))
		#expect(try AstronomicalCalendar.dateAndTimeFromJulianDate(2305447.5) == (1600, 1, 1, 0, 0, 0))
		#expect(try AstronomicalCalendar.dateAndTimeFromJulianDate(2305812.5) == (1600, 12, 31, 0, 0, 0))
//		#expect(try AstronomicalCalendar.dateAndTimeFromJulianDate(2026871.8) == (837, 4, 10, 7, 12, 0))
		// Account for floating-point error since 2026871.8 is not perfectly representable by a double (real value is 2026871.80000000005)
		var calendarDate = try AstronomicalCalendar.dateAndTimeFromJulianDate(2026871.8)
		#expect((calendarDate.year, calendarDate.month, calendarDate.day) == (837, 4, 10))
		var fractionalDay = fractionalDayFrom(hour: calendarDate.hour, minute: calendarDate.minute, second: calendarDate.second)
		#expect(abs(fractionalDay - 0.3) < 0.000005) // ≈1/2 second accuracy check
		#expect(try AstronomicalCalendar.dateAndTimeFromJulianDate(1676496.5) == (-123, 12, 31, 0, 0, 0))
		#expect(try AstronomicalCalendar.dateAndTimeFromJulianDate(1676497.5) == (-122, 1, 1, 0, 0, 0))
		#expect(try AstronomicalCalendar.dateAndTimeFromJulianDate(1356001) == (-1000, 7, 12, 12, 0, 0))
		#expect(try AstronomicalCalendar.dateAndTimeFromJulianDate(1355866.5) == (-1000, 2, 29, 0, 0, 0))
//		#expect(try AstronomicalCalendar.dateAndTimeFromJulianDate(1355671.4) == (-1001, 8, 17, 21, 36, 0))
		// Account for floating-point error since 1355671.4 is not perfectly representable by a double (real value is 1355671.39999999991)
		calendarDate = try AstronomicalCalendar.dateAndTimeFromJulianDate(1355671.4)
		#expect((calendarDate.year, calendarDate.month, calendarDate.day) == (-1001, 8, 17))
		fractionalDay = fractionalDayFrom(hour: calendarDate.hour, minute: calendarDate.minute, second: calendarDate.second)
		#expect(abs(fractionalDay - 0.9) < 0.000005)  // ≈1/2 second accuracy check
		#expect(try AstronomicalCalendar.dateAndTimeFromJulianDate(0) == (-4712, 1, 1, 12, 0, 0))

		#expect(try AstronomicalCalendar.julianDateFrom(year: -4713, month: 12, day: 31, hour: 12) == -1)
		#expect(try AstronomicalCalendar.julianDateFrom(year: -4712, month: 1, day: 1) == -0.5)
		#expect(try AstronomicalCalendar.julianDateFrom(year: -4712, month: 1, day: 1, hour: 12) == 0)
		#expect(try AstronomicalCalendar.julianDateFrom(year: -4712, month: 1, day: 2) == 0.5)
		#expect(try AstronomicalCalendar.julianDateFrom(year: -4712, month: 1, day: 2, hour: 12) == 1)

		#expect(try AstronomicalCalendar.dateAndTimeFromJulianDate(-1) == (-4713, 12, 31, 12, 0, 0))
		#expect(try AstronomicalCalendar.dateAndTimeFromJulianDate(-0.5) == (-4712, 1, 1, 0, 0, 0))
		#expect(try AstronomicalCalendar.dateAndTimeFromJulianDate(0) == (-4712, 1, 1, 12, 0, 0))
		#expect(try AstronomicalCalendar.dateAndTimeFromJulianDate(0.5) == (-4712, 1, 2, 0, 0, 0))
		#expect(try AstronomicalCalendar.dateAndTimeFromJulianDate(1) == (-4712, 1, 2, 12, 0, 0))

		#expect(try AstronomicalCalendar.dateAndTimeFromJulianDate(-1.75) == (-4713, 12, 30, 18, 0, 0))
		#expect(try AstronomicalCalendar.dateAndTimeFromJulianDate(1.75) == (-4712, 1, 3, 6, 0, 0))
	}

	@Test func limits() throws {
		#expect(try AstronomicalCalendar.julianDateFrom(year: -999999, month: 1, day: 1) == -363528576.5)
		#expect(try AstronomicalCalendar.julianDateFrom(year: -99999, month: 1, day: 1) == -34803576.5)
		#expect(try AstronomicalCalendar.julianDateFrom(year: -9999, month: 1, day: 1) == -1931076.5)
		#expect(try AstronomicalCalendar.julianDateFrom(year: 9999, month: 12, day: 31) == 5373483.5)
		#expect(try AstronomicalCalendar.julianDateFrom(year: 99999, month: 12, day: 31) == 38245308.5)
		#expect(try AstronomicalCalendar.julianDateFrom(year: 999999, month: 12, day: 31) == 366963558.5)

		#expect(try AstronomicalCalendar.dateAndTimeFromJulianDate(-363528576.5) == (-999999, 1, 1, 0, 0, 0))
		#expect(try AstronomicalCalendar.dateAndTimeFromJulianDate(-34803576.5) == (-99999, 1, 1, 0, 0, 0))
		#expect(try AstronomicalCalendar.dateAndTimeFromJulianDate(-1931076.5) == (-9999, 1, 1, 0, 0, 0))
		#expect(try AstronomicalCalendar.dateAndTimeFromJulianDate(5373483.5) == (9999, 12, 31, 0, 0, 0))
		#expect(try AstronomicalCalendar.dateAndTimeFromJulianDate(38245308.5) == (99999, 12, 31, 0, 0, 0))
		#expect(try AstronomicalCalendar.dateAndTimeFromJulianDate(366963558.5) == (999999, 12, 31, 0, 0, 0))
	}

	@Test func arithmeticLimits() throws {
		let minDate = try AstronomicalCalendar.dateFromJulianDayNumber(.min)
		let minJ = try AstronomicalCalendar.julianDayNumberFromDate(minDate)
		#expect(minJ == .min)

		let maxDate = try AstronomicalCalendar.dateFromJulianDayNumber(.max)
		let maxJ = try AstronomicalCalendar.julianDayNumberFromDate(maxDate)
		#expect(maxJ == .max)

		_ = AstronomicalCalendar.isLeapYear(.min)
		_ = AstronomicalCalendar.isLeapYear(.max)

		_ = AstronomicalCalendar.dayOfWeek(.min)
		_ = AstronomicalCalendar.dayOfWeek(.max)
	}
}
