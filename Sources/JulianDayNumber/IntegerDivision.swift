//
// Copyright © 2021-2023 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/JulianDayNumber
// MIT license
//

import Foundation

/// Divides a dividend by a divisor and returns the quotient and remainder such that the remainder is nonnegative and smaller in magnitude than the dividend.
///
/// The *quotient* and *remainder* are defined by the relations **dividend = quotient × divisor + remainder** and  **0 ≤ remainder < |divisor|**.
///
/// This emulates the behavior of division in Python and Ruby.
///
/// - parameter dividend: An integer dividend.
/// - parameter divisor: An integer divisor.
///
/// - returns: The quotient and remainder of the division such that the remainder is nonnegative and smaller in magnitude than `dividend`.
///
/// - Precondition: `divisor` cannot be zero.
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
