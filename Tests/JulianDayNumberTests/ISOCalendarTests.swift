//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Testing
@testable import JulianDayNumber

@Suite struct ISOCalendarTests {
	@Test func weeksInYear() {
		#expect(ISOCalendar.isoWeeksInYear(2023) == 52)
		#expect(ISOCalendar.isoWeeksInYear(2020) == 53)
		#expect(ISOCalendar.isoWeeksInYear(2026) == 53)
	}

	@Test func dayOfWeek() {
		#expect(ISOCalendar.isoWeekdayFrom(year: 2023, month: 11, day: 13) == 1)
		#expect(ISOCalendar.isoWeekdayFrom(year: 2023, month: 11, day: 14) == 2)
		#expect(ISOCalendar.isoWeekdayFrom(year: 2023, month: 11, day: 15) == 3)
		#expect(ISOCalendar.isoWeekdayFrom(year: 2023, month: 11, day: 16) == 4)
		#expect(ISOCalendar.isoWeekdayFrom(year: 2023, month: 11, day: 17) == 5)
		#expect(ISOCalendar.isoWeekdayFrom(year: 2023, month: 11, day: 18) == 6)
		#expect(ISOCalendar.isoWeekdayFrom(year: 2023, month: 11, day: 19) == 7)
	}

	@Test func dateFrom() throws {
		#expect(try ISOCalendar.isoDateFrom(year: 2023, month: 11, day: 16) == (2023, 46, 4))
		#expect(try ISOCalendar.dateFromISO(year: 2023, week: 46, weekday: 4) == (2023, 11, 16))

		#expect(try ISOCalendar.isoDateFrom(year: 2020, month: 12, day: 27) == (2020, 52, 7))
		#expect(try ISOCalendar.isoDateFrom(year: 2020, month: 12, day: 28) == (2020, 53, 1))
		#expect(try ISOCalendar.isoDateFrom(year: 2020, month: 12, day: 29) == (2020, 53, 2))
		#expect(try ISOCalendar.isoDateFrom(year: 2020, month: 12, day: 30) == (2020, 53, 3))
		#expect(try ISOCalendar.isoDateFrom(year: 2020, month: 12, day: 31) == (2020, 53, 4))
		#expect(try ISOCalendar.isoDateFrom(year: 2021, month: 1, day: 1) == (2020, 53, 5))
		#expect(try ISOCalendar.isoDateFrom(year: 2021, month: 1, day: 2) == (2020, 53, 6))
		#expect(try ISOCalendar.isoDateFrom(year: 2021, month: 1, day: 3) == (2020, 53, 7))
		#expect(try ISOCalendar.isoDateFrom(year: 2021, month: 1, day: 4) == (2021, 1, 1))

		#expect(try ISOCalendar.dateFromISO(year: 2020, week: 52, weekday: 7) == (2020, 12, 27))
		#expect(try ISOCalendar.dateFromISO(year: 2020, week: 53, weekday: 1) == (2020, 12, 28))
		#expect(try ISOCalendar.dateFromISO(year: 2020, week: 53, weekday: 2) == (2020, 12, 29))
		#expect(try ISOCalendar.dateFromISO(year: 2020, week: 53, weekday: 3) == (2020, 12, 30))
		#expect(try ISOCalendar.dateFromISO(year: 2020, week: 53, weekday: 4) == (2020, 12, 31))
		#expect(try ISOCalendar.dateFromISO(year: 2020, week: 53, weekday: 5) == (2021, 1, 1))
		#expect(try ISOCalendar.dateFromISO(year: 2020, week: 53, weekday: 6) == (2021, 1, 2))
		#expect(try ISOCalendar.dateFromISO(year: 2020, week: 53, weekday: 7) == (2021, 1, 3))
		#expect(try ISOCalendar.dateFromISO(year: 2021, week: 1, weekday: 1) == (2021, 1, 4))
	}

	@Test func julianDayNumber() throws {
		#expect(try ISOCalendar.julianDayNumberFromDate((2023, 46, 4)) == 2460265)
		#expect(try ISOCalendar.dateFromJulianDayNumber(2460265) == (2023, 46, 4))
	}
}
