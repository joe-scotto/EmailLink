// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "EmailLink",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "EmailLink",
            targets: ["EmailLink"]),
    ],
    targets: [
        .target(
            name: "EmailLink",
            dependencies: [])
    ]
)
