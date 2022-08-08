// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LabelPicker",
    platforms: [.iOS(.v10)],
    products: [
        .library(
            name: "LabelPicker",
            targets: ["LabelPicker"]
        ),
    ],
    targets: [
        .target(
            name: "LabelPicker",
            dependencies: []
        ),
        .testTarget(
            name: "LabelPickerTests",
            dependencies: ["LabelPicker"]
        ),
    ]
)
