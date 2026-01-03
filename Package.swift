// swift-tools-version: 5.5
//
// SPDX-FileCopyrightText: 2023 Stephen F. Booth <contact@sbooth.dev>
// SPDX-License-Identifier: MIT
//
// Part of https://github.com/sbooth/JulianDayNumber
//

import PackageDescription

let package = Package(
	name: "JulianDayNumber",
	products: [
		.library(
			name: "JulianDayNumber",
			targets: [
				"JulianDayNumber",
			]),
	],
	targets: [
		.target(
			name: "JulianDayNumber"),
		.testTarget(
			name: "JulianDayNumberTests",
			dependencies: [
				"JulianDayNumber",
			]),
	]
)
