// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "crypto-swift",
    products: [
        .library(
            name: "CryptoExtras",
            targets: ["CryptoExtras"]
        )
    ],
    targets: [
        .target(
            name: "CryptoExtras",
            swiftSettings: [
                .enableExperimentalFeature("Lifetimes"),
                .enableExperimentalFeature("LifetimeDependence"),
                .strictMemorySafety(),
            ]
        ),
        .testTarget(
            name: "CryptoExtrasTests",
            dependencies: ["CryptoExtras"],
        ),
    ]
)
