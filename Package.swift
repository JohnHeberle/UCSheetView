// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "UCSheetView",
    platforms: [
      .iOS(.v14)
    ],
    products: [.library(name: "UCSheetView", targets: ["UCSheetView"])],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-issue-reporting.git", .upToNextMajor(from: "1.4.2")),
    ],
    targets: [
        .target(
            name: "UCSheetView",
            dependencies: [.product(name: "IssueReporting", package: "swift-issue-reporting")]
        ),
        .testTarget(
            name: "UCSheetViewTests",
            dependencies: ["UCSheetView", .product(name: "IssueReportingTestSupport", package: "swift-issue-reporting")]
        ),
    ]
)
