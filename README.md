# JulianDayNumber

Julian day number (JDN) and Julian date (JD) calculations supporting Julian, Gregorian, astronomical, and Islamic calendars.

The JDN conversion algorithms are adapted from Richards, E.G. 2012, "[Calendars](https://aa.usno.navy.mil/downloads/c15_usb_online.pdf)," from the *Explanatory Supplement to the Astronomical Almanac, 3rd edition*, S.E Urban and P.K. Seidelmann eds., (Mill Valley, CA: University Science Books), Chapter 15, pp. 585-624.

The JDN algorithms use integer math to avoid rounding errors and the implementations have been round-trip tested for all valid Julian day numbers in the years -999,999 to +999,999.

## Installation

### Swift Package Manager

Add a package dependency to https://github.com/sbooth/JulianDayNumber in Xcode.

### Manual or Custom Build

1. Clone the [JulianDayNumber](https://github.com/sbooth/JulianDayNumber) repository.
2. `swift build`.

## Limits

### Julian Day Numbers

The following table summarizes the **absolute limit** for 64-bit integer Julian day numbers. Julian day numbers outside these values will cause an arithmetic overflow in `julianDayNumberToDate`.

| Calendar | Minimum JDN | Maximum JDN |
| --- | --- | --- |
| Julian | -9223372036854775664 | 2305843009213692550 |
| Gregorian | -9223372036854719351 | 2305795661307959247 |
| Islamic | -9223372036854775352 | 307445734561818195 |

For reference, these limits correspond to the following dates which should also be considered limiting:

| Calendar | Minimum Date | Maximum Date |
| --- | --- | --- |
| Julian | -25252216391119772-01-02 | 6313054097774049-04-05 |
| Gregorian | -25252734927771113-11-25 | 6313054097774049-04-05 |
| Islamic | -26027764190170417-01-01 | 867592139666645-01-11 |

### Julian Dates

The following table summarizes the **absolute limit** for 64-bit floating-point Julian dates. Julian dates outside these values will cause an arithmetic overflow in `julianDateToDate`.

| Calendar | Minimum JD | Maximum JD |
| --- | --- | --- |
| Julian | -0x1.fffffffffffffp+62 | 0x1.ffffffffffffap+60 |
| Gregorian | -0x1.fffffffffffc8p+62 | 0x1.fffd4eff4e5d7p+60 |
| Islamic | -0x1.fffffffffffffp+62 | 0x1.1111111111099p+58 |

For reference, these limits correspond to the following dates and times which should also be considered limiting:

| Calendar | Minimum Date and Time | Maximum Date and Time |
| --- | --- | --- |
| Julian | -25252216391119770-05-31 00:00:00 | 6313054097774048-11-22 00:00:00 |
| Gregorian | -25252734927771110-04-30 00:00:00 | 6313054097774048-09-10 00:00:00 |
| Islamic | -26027764190170416-08-08 00:00:00 | 867592139666644-12-21 00:00:00 |

## Examples

1. Calculate the Julian date for the total solar eclipse on 1919-05-29.

```swift
let jd = AstronomicalCalendar.dateToJulianDate(year: 1919, month: 5, day: 29)
// JulianDayNumber.JulianDate	2422107.5
```

> [!NOTE]
> `AstronomicalCalendar` uses the Julian calendar for dates before 1582-10-15 and the Gregorian calendar for later dates.

2. Convert the Julian date 2422107.5 to a `Date` instance.

```swift
let d = Date(julianDate: 2422107.5)
// Foundation.Date	1919-05-29 00:00:00 UTC
```

## License

JulianDayNumber is released under the [MIT License](https://github.com/sbooth/JulianDayNumber/blob/main/LICENSE.txt).
