// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LabelPicker",
    platforms: [.iOS(.v10)],
    products: [
        .library(
            name: "LabelPicker",
            targets: ["Core"]
        ),
    ],
    targets: [
        .target(
            name: "Core",
            dependencies: []
        ),
        .testTarget(
            name: "CoreTests",
            dependencies: ["Core"]
        ),
    ]
)
