// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "SwiftMail",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "SwiftMail",
            targets: ["SwiftMail"]),
    ],
    targets: [
        .target(
            name: "SwiftMail",
            dependencies: [])
    ]
)
