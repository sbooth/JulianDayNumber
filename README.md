# JulianDayNumber

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fsbooth%2FJulianDayNumber%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/sbooth/JulianDayNumber)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fsbooth%2FJulianDayNumber%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/sbooth/JulianDayNumber)

Julian day number (JDN) and Julian date (JD) calculations supporting the following calendars:
- [Astronomical](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/astronomicalcalendar)
- [Baháʼí](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/bahaicalendar)
- [Coptic](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/copticcalendar)
- [Egyptian](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/egyptiancalendar)
- [Ethiopian](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/ethiopiancalendar)
- [French Republican](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/frenchrepublicancalendar)
- [Gregorian](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/gregoriancalendar)
- [Islamic](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/islamiccalendar)
- [Jewish](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/jewishcalendar)
- [Julian](https://swiftpackageindex.com/sbooth/juliandaynumber/main/documentation/juliandaynumber/juliancalendar)
- Mayan
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
let jd = AstronomicalCalendar.dateToJulianDate(year: 1919, month: 5, day: 29)
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
let j = GregorianCalendar.dateToJulianDayNumber(year: 2013, month: 10, day: 31)
let julianYMD = JulianCalendar.julianDayNumberToDate(j)
// (year: 2013, month: 10, day: 18)
```

## Documentation

The [latest documentation](https://swiftpackageindex.com/sbooth/JulianDayNumber/main/documentation/juliandaynumber) is hosted by [Swift Package Index](https://swiftpackageindex.com).

## Limits

### Julian Day Numbers

The following table summarizes the limits for Julian day numbers. Julian day numbers outside these values will cause an arithmetic overflow.

| Calendar | Minimum JDN | Maximum JDN |
| --- | --- | --- |
| Baháʼí | -9223372036854719351 | 2305795661307959248 |
| Coptic | -9223372036854775664 | 2305843009213693827 |
| Egyptian | -9223372036854775514 | 9223372036854775760 |
| Ethiopian | -9223372036854775664 | 2305843009213693827 |
| French Republican | -9223372036854719351 | 2305795661307960548 |
| Gregorian | -9223372036854719351 | 2305795661307959247 |
| Islamic | -9223372036854775352 | 307445734561818195 |
| Jewish | -9223372036747815981 ¹ | 355839970905570 |
| Julian | -9223372036854775664 | 2305843009213692550 |
| Mayan Long Count | -9223372036854191525 ² | Int.max |
| Śaka | -9223372036854719351 | 2305795661307959298 |

¹ The smallest round-trippable JDN for the Jewish calendar is -9223372036747815627.
² The smallest round-trippable JDN for the Mayan Long Count is -9223372036854191517.

### Julian Dates

The following table summarizes the limits for Julian dates. Julian dates outside these values will cause an arithmetic overflow.

| Calendar | Minimum JD | Maximum JD |
| --- | --- | --- |
| Baháʼí | -0x1.fffffffffffc8p+62 | 0x1.fffd4eff4e5d7p+60 |
| Coptic | -0x1.fffffffffffffp+62 | 0x1.fffffffffffffp+60 |
| Egyptian | -0x1.fffffffffffffp+62 | 0x1.fffffffffffffp+62 |
| Ethiopian | -0x1.fffffffffffffp+62 | 0x1.fffffffffffffp+60 |
| French Republican | -0x1.fffffffffffc8p+62 | 0x1.fffd4eff4e5dcp+60 |
| Gregorian | -0x1.fffffffffffc8p+62 | 0x1.fffd4eff4e5d7p+60 |
| Islamic | -0x1.fffffffffffffp+62 | 0x1.1111111111099p+58 |
| Jewish | -0x1.ffffffffe67fbp+62 ¹ | 0x1.43a273100de27p+48 |
| Julian | -0x1.fffffffffffffp+62 | 0x1.ffffffffffffap+60 |
| Śaka | -0x1.fffffffffffc8p+62 | 0x1.fffd4eff4e5d8p+60 |

¹ The smallest round-trippable JD for the Jewish calendar is -0x1.ffffffffe67fap+62.

## License

JulianDayNumber is released under the [MIT License](https://github.com/sbooth/JulianDayNumber/blob/main/LICENSE.txt).
