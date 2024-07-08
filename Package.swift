// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

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
