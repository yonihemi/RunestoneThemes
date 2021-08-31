// swift-tools-version:5.4

import PackageDescription

let package = Package(
    name: "runestone-themes",
	products: [
		.executable(name: "runestone-themes", targets: ["runestone-themes"]),
	],
    dependencies: [
		.package(name: "TM2Runestone", url: "https://github.com/yonihemi/TM2Runestone", .upToNextMinor(from: "0.1.0")),
		.package(name: "Path.swift", url: "https://github.com/mxcl/Path.swift", from: "1.4.0"),
    ],
    targets: [
        .executableTarget(
            name: "runestone-themes",
            dependencies: [
				"TM2Runestone",
				.product(name: "Path", package: "Path.swift"),
			]),
    ]
)
