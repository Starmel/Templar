// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "templar",
    products: [
        .executable(name: "templar", targets: ["templar"]),
    ],
    dependencies: [
        .package(url: "https://github.com/tuist/xcodeproj.git", .upToNextMajor(from: "6.5.0")),
        .package(url: "https://github.com/jpsim/Yams.git", .upToNextMajor(from: "1.0.1")),
        .package(url: "https://github.com/jakeheis/SwiftCLI", from: "5.0.0"),
        .package(url: "https://github.com/JohnSundell/Files", .upToNextMajor(from: "2.2.1")),
        .package(url: "https://github.com/onevcat/Rainbow", from: "3.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "templar",
            dependencies: ["xcodeproj", "Yams", "SwiftCLI", "Files", "Rainbow"]),
        .testTarget(
            name: "templarTests",
            dependencies: ["templar"]),
    ]
)
