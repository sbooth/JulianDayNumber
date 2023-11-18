//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// Divides a dividend by a divisor and returns the quotient and remainder.
///
/// The quotient and remainder are defined by the following two relations:
/// 1. **dividend = quotient × divisor + remainder**
/// 2. **0 ≤ remainder < |divisor|**.
///
/// This differs from standard Swift division when the dividend or divisor is negative. Swift duplicates the C-like behavior 
/// of rounding the quotient toward zero (truncation), while this function rounds toward negative infinity (down).
///
/// This is the behavior of `//` in Python and `/` in Ruby.
///
/// - parameter dividend: A dividend.
/// - parameter divisor: A divisor.
///
/// - returns: The quotient and remainder of the division.
///
/// - precondition: `divisor` cannot be zero.
@inlinable @inline(__always)
func quotientAndRemainder<I: SignedInteger>(_ dividend: I, dividedBy divisor: I) -> (quotient: I, remainder: I) {
	var quotient = dividend / divisor
	var remainder = dividend - quotient * divisor
	if remainder == 0 {
		return (quotient, remainder)
	}
	if divisor.signum() != remainder.signum() {
		quotient -= 1
		remainder += divisor
	}
	return (quotient, remainder)
}

/// Divides a dividend by a divisor and returns the quotient.
///
/// The quotient and remainder are defined by the following two relations:
/// 1. **dividend = quotient × divisor + remainder**
/// 2. **0 ≤ remainder < |divisor|**.
///
/// This differs from standard Swift division when the dividend or divisor is negative. Swift duplicates the C-like behavior
/// of rounding the quotient toward zero (truncation), while this function rounds toward negative infinity (down).
///
/// This is the behavior of `//` in Python and `/` in Ruby.
///
/// - parameter dividend: A dividend.
/// - parameter divisor: A divisor.
///
/// - returns: The quotient of the division.
///
/// - precondition: `divisor` cannot be zero.
@inlinable @inline(__always)
func quotient<I: SignedInteger>(_ dividend: I, dividedBy divisor: I) -> I {
	quotientAndRemainder(dividend, dividedBy: divisor).quotient
}

/// Divides a dividend by a divisor and returns the remainder.
///
/// The quotient and remainder are defined by the following two relations:
/// 1. **dividend = quotient × divisor + remainder**
/// 2. **0 ≤ remainder < |divisor|**.
///
/// This differs from standard Swift division when the dividend or divisor is negative. Swift duplicates the C-like behavior
/// of rounding the quotient toward zero (truncation), while this function rounds toward negative infinity (down).
///
/// This is the behavior of `//` in Python and `/` in Ruby.
///
/// - parameter dividend: A dividend.
/// - parameter divisor: A divisor.
///
/// - returns: The remainder of the division.
///
/// - precondition: `divisor` cannot be zero.
@inlinable @inline(__always)
func remainder<I: SignedInteger>(_ dividend: I, dividedBy divisor: I) -> I {
	quotientAndRemainder(dividend, dividedBy: divisor).remainder
}
