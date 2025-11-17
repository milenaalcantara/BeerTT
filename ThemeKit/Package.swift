// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ThemeKit",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "ThemeKit",
            targets: ["ThemeKit"]),
    ],
    targets: [
        .target(
            name: "ThemeKit",
            dependencies: [],
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "ThemeKitTests",
            dependencies: ["ThemeKit"]),
    ]
)
