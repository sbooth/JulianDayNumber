//
// Copyright © 2021-2025 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// Divides a dividend by a divisor and returns the floored quotient and remainder.
///
/// This differs from standard Swift division when the dividend or divisor is negative. Swift duplicates the C-like behavior
/// of rounding the quotient toward zero (truncation), while this function rounds toward negative infinity (down).
///
/// This is the behavior of `divmod` in Python and Ruby.
///
/// - parameter dividend: A dividend.
/// - parameter divisor: A divisor.
///
/// - returns: The floored quotient and remainder of the division.
///
/// - precondition: `divisor` cannot be zero.
@inlinable @inline(__always)
func flooredQuotientAndRemainder<I>(_ dividend: I, dividedBy divisor: I) -> (quotient: I, remainder: I) where I: SignedInteger {
	precondition(divisor != 0, "Cannot divide by zero")
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

/// Divides a dividend by a divisor and returns the floored quotient.
///
/// This differs from standard Swift division when the dividend or divisor is negative. Swift duplicates the C-like behavior
/// of rounding the quotient toward zero (truncation), while this function rounds toward negative infinity (down).
///
/// This is the behavior of `//` in Python and `/` in Ruby.
///
/// - parameter dividend: A dividend.
/// - parameter divisor: A divisor.
///
/// - returns: The floored quotient of the division.
///
/// - precondition: `divisor` cannot be zero.
@inlinable @inline(__always)
func flooredQuotient<I>(_ dividend: I, dividedBy divisor: I) -> I where I: SignedInteger {
	flooredQuotientAndRemainder(dividend, dividedBy: divisor).quotient
}
