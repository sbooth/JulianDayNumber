# JulianDayNumber

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fsbooth%2FJulianDayNumber%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/sbooth/JulianDayNumber)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fsbooth%2FJulianDayNumber%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/sbooth/JulianDayNumber)

Julian day number (JDN) and Julian date (JD) calculations supporting the following calendars:
- [Armenian](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/armeniancalendar)
- [Astronomical](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/astronomicalcalendar)
- [Baháʼí](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/bahaicalendar)
- [Coptic](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/copticcalendar)
- [Egyptian](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/egyptiancalendar)
- [Ethiopian](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/ethiopiancalendar)
- [French Republican](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/frenchrepublicancalendar)
- [Gregorian](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/gregoriancalendar)
- [Hebrew](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/hebrewcalendar)
- [Islamic](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/islamiccalendar)
- [Julian](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/juliancalendar)
- [Khwarizmian](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/khwarizmiancalendar)
- [Maya](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/mayacalendar)
- [Śaka](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/sakacalendar)

Most of the JDN conversion algorithms are adapted from Richards, E.G. 2012, "[Calendars](https://aa.usno.navy.mil/downloads/c15_usb_online.pdf)," from the *Explanatory Supplement to the Astronomical Almanac, 3rd edition*, S.E Urban and P.K. Seidelmann eds., (Mill Valley, CA: University Science Books), Chapter 15, pp. 585-624.

The JDN algorithms use integer math to avoid rounding errors and the implementations have been round-trip tested for all valid Julian day numbers in the years -999,999 to +999,999.

## Installation

### Swift Package Manager

Add a package dependency to https://github.com/sbooth/JulianDayNumber in Xcode.

### Manual or Custom Build

1. Clone the [JulianDayNumber](https://github.com/sbooth/JulianDayNumber) repository.
2. `swift build`.

## Examples

1. Calculate the Julian date for the total solar eclipse on 1919-05-29.

```swift
let jd = AstronomicalCalendar.julianDateFrom(year: 1919, month: 5, day: 29)
// 2422107.5
```

> [!NOTE]
> The astronomical calendar is a hybrid calendar using the Julian calendar for dates before October 15, 1582 and the Gregorian calendar for later dates.

2. Convert the Julian date 2422107.5 to a `Date` instance.

```swift
let d = Date(julianDate: 2422107.5)
// Foundation.Date	1919-05-29 00:00:00 UTC
```

3. Convert the Gregorian calendar date 2013-10-31 to a date in the Julian calendar.

```swift
let j = GregorianCalendar.julianDayNumberFrom(year: 2013, month: 10, day: 31)
let julianYMD = JulianCalendar.dateFromJulianDayNumber(j)
// (year: 2013, month: 10, day: 18)
```

## Documentation

The [latest documentation](https://swiftpackageindex.com/sbooth/JulianDayNumber/main/documentation/juliandaynumber) is hosted by [Swift Package Index](https://swiftpackageindex.com).

## Limits

The following table summarizes the arithmetic limits for Julian day number calculations.

| Calendar | Minimum JDN | Maximum JDN |
| --- | --- | --- |
| Armenian | `Int.min` + 341 | `Int.max` - 317 |
| Baháʼí | `Int.min` + 56457 | 2305795661307959248 |
| Coptic | `Int.min` + 384 | 2305843009213693827 |
| Egyptian | `Int.min` + 611 | `Int.max` - 47 |
| Ethiopian | `Int.min` + 384 | 2305843009213693827 |
| French Republican | `Int.min` + 56759 | 2305795661307960548 |
| Gregorian | `Int.min` + 56457 | 2305795661307959247 |
| Hebrew | `Int.min` + 106960181 | 355839970905570 |
| Islamic | `Int.min` + 325 | 307445734561818195 |
| Julian | `Int.min` + 144 | 2305843009213692550 |
| Khwarizmian | `Int.min` + 341 | `Int.max` - 317 |
| Maya Long Count | `Int.min` + 584291 | `Int.max` |
| Śaka | `Int.min` + 56457 | 2305795661307959298 |

## License

JulianDayNumber is released under the [MIT License](https://github.com/sbooth/JulianDayNumber/blob/main/LICENSE.txt).
