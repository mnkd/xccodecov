// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "xccodecov",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .executable(name: "xccodecov", targets: ["xccodecov"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.3.2"),
        .package(url: "https://github.com/davidahouse/XCResultKit", from: "0.7.1"),
        .package(url: "https://github.com/jpsim/Yams.git", from: "4.0.4")
    ],
    targets: [
        .target(
            name: "xccodecov",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "XCResultKit",
                "Yams"
            ])
    ]
)
