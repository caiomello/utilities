// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "Utilities",
    platforms: [
        .iOS(.v15)
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
