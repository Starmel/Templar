// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "templar",
    products: [
        .executable(name: "templar", targets: ["templar"]),
        .library(name: "TemplarPluginAPIv1", targets: ["TemplarPluginAPIv1"]),
        .library(name: "TemplarCore", targets: ["TemplarCore"])
    ],
    dependencies: [
        .package(url: "https://github.com/tuist/xcodeproj.git", .upToNextMajor(from: "6.5.0")),
        .package(url: "https://github.com/jpsim/Yams.git", .upToNextMajor(from: "1.0.1")),
        .package(url: "https://github.com/jakeheis/SwiftCLI", from: "5.0.0"),
        .package(url: "https://github.com/JohnSundell/Files", .upToNextMajor(from: "2.2.1"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "templar",
            dependencies: ["xcodeproj", "TemplarCore", "SwiftCLI"]),
        .target(name: "TemplarCore",
                dependencies: ["Yams", "Files"]),
        .target(name: "TemplarPluginAPIv1",
                dependencies: ["TemplarCore"]),
        .testTarget(
            name: "templarTests",
            dependencies: ["templar"]),
    ]
)
