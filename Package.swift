// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Utilities",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "Utilities",
            targets: ["Utilities"]),
    ],
    dependencies: [

    ],
    targets: [
        .target(
            name: "Utilities",
            dependencies: []),
        .testTarget(
            name: "UtilitiesTests",
            dependencies: ["Utilities"]),
    ]
)
