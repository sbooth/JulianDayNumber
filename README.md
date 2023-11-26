# JulianDayNumber

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fsbooth%2FJulianDayNumber%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/sbooth/JulianDayNumber)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fsbooth%2FJulianDayNumber%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/sbooth/JulianDayNumber)

Julian day number and Julian date calculations supporting the following calendars:

| Calendar | Epoch ¹ | Era |
| --- | --- | --- |
| [Armenian](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/armeniancalendar) | 0552-07-11 CE | Armenian |
| [Astronomical](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/astronomicalcalendar) | 0001-01-01 CE | CE |
| [Baháʼí](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/bahaicalendar) | 1844-03-21 CE | Baháʼí |
| [Coptic](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/copticcalendar) | 0284-08-29 CE | Diocletian |
| [Egyptian](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/egyptiancalendar) | 0747-02-26 BCE | Nabonassar |
| [Ethiopian](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/ethiopiancalendar) | 0008-08-29 CE | Incarnation |
| [French Republican](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/frenchrepublicancalendar) | 1792-09-22 CE | Republican |
| [Gregorian](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/gregoriancalendar) | 0001-01-01 CE | CE |
| [Hebrew](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/hebrewcalendar) | 3761-10-07 BCE | AM |
| [Islamic](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/islamiccalendar) | 0622-07-16 CE | AH |
| [ISO](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/isocalendar) | |
| [Julian](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/juliancalendar) | 0001-01-01 CE | CE |
| [Khwarizmian](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/khwarizmiancalendar) | 0632-06-21 CE | Yazdegerd |
| [Macedonian](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/macedoniancalendar) | 0312-09-01 BCE | Alexander |
| [Maya](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/mayacalendar) | 3114-09-06 BCE | |
| [Persian](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/persiancalendar) | 0632-06-16 CE | Yazdegerd |
| [Śaka](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/sakacalendar) | 0079-03-24 CE | Śaka |
| [Syrian](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/syriancalendar) | 0312-10-01 BCE | Alexander |

¹ Epoch in Julian calendar

The Julian day number interconverting algorithms use integer math to avoid rounding errors and the implementations have been round-trip tested for all valid Julian day numbers in the years -999,999 to +999,999.

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
| Coptic | `Int.min` + 384 | (`Int.max` - 3) / 4 - 124 |
| Egyptian | `Int.min` + 611 | `Int.max` - 47 |
| Ethiopian | `Int.min` + 384 | (`Int.max` - 3) / 4 - 124 |
| French Republican | `Int.min` + 56759 | 2305795661307960548 |
| Gregorian | `Int.min` + 56457 | 2305795661307959247 |
| Hebrew | `Int.min` + 106960181 | 355839970905570 |
| Islamic | `Int.min` + 325 | (`Int.max` - 15) / 30 - 7664 |
| Julian | `Int.min` + 144 | (`Int.max` - 3) / 4 - 1401 |
| Khwarizmian | `Int.min` + 341 | `Int.max` - 317 |
| Macedonian | `Int.min` + 144 | (`Int.max` - 3) / 4 - 1401 |
| Maya Long Count | `Int.min` + 584291 | `Int.max` |
| Persian | `Int.min` + 336 | `Int.max` - 77 |
| Śaka | `Int.min` + 56457 | 2305795661307959298 |
| Syrian | `Int.min` + 144 | (`Int.max` - 3) / 4 - 1401 |

## License

JulianDayNumber is released under the [MIT License](https://github.com/sbooth/JulianDayNumber/blob/main/LICENSE.txt).
