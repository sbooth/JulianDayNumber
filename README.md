# JulianDayNumber

Julian day number (JDN) and Julian date (JD) calculations supporting Julian, Gregorian, astronomical, and Islamic calendars.

The JDN conversion algorithms are adapted from Richards, E.G. 2012, "[Calendars](https://aa.usno.navy.mil/downloads/c15_usb_online.pdf)," from the *Explanatory Supplement to the Astronomical Almanac, 3rd edition*, S.E Urban and P.K. Seidelmann eds., (Mill Valley, CA: University Science Books), Chapter 15, pp. 585-624.

The algorithms use integer math to avoid rounding errors and the implementations have been tested from years -999,999 to +999,999.

## Installation

### Swift Package Manager

Add a package dependency to https://github.com/sbooth/JulianDayNumber in Xcode.

### Manual or Custom Build

1. Clone the [JulianDayNumber](https://github.com/sbooth/JulianDayNumber) repository.
2. `swift build`.

## Examples

1. Calculate the Julian date for the total solar eclipse on 1919-05-29.

```swift
let jd = AstronomicalCalendar.dateToJulianDate(year: 1919, month: 5, day: 29)
// JulianDayNumber.JulianDate	2422107.5
```

> [!NOTE]
> `AstronomicalCalendar` uses the Julian calendar for dates before the Gregorian to Julian calendar changeover on 1582-10-15, and the Gregorian calendar for later dates.

2. Convert the Julian date 2422107.5 to a `Date` instance.

```swift
let d = Date(julianDate: 2422107.5)
//Foundation.Date	1919-05-29 00:00:00 UTC
```

## License

JulianDayNumber is released under the [MIT License](https://github.com/sbooth/JulianDayNumber/blob/main/LICENSE.txt).
