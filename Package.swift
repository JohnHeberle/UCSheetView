// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "UCSheetView",
    platforms: [.iOS(.v14)],
    products: [.library(name: "UCSheetView", targets: ["UCSheetView"])],
    targets: [
        .target(name: "UCSheetView"),
        .testTarget(name: "UCSheetViewTests", dependencies: ["UCSheetView"]),
    ]
)
