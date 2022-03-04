// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CasperSDKInSwift",
    platforms: [
        .iOS(.v13),.tvOS(.v14),.watchOS(.v7),.macOS(.v11)
        ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "CasperSDKInSwift",
            targets: ["CasperSDKInSwift"]),
    ],
    dependencies: [
        .package(name:"Blake2",url: "https://github.com/tesseract-one/Blake2.swift.git", from: "0.1.0"),
        .package(name:"SwiftECC",url: "https://github.com/leif-ibsen/SwiftECC", from: "2.2.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "CasperSDKInSwift",
            dependencies: ["Blake2","SwiftECC"]),
        .testTarget(
            name: "CasperSDKInSwiftTests",
            dependencies: ["CasperSDKInSwift","Blake2","SwiftECC"]),
    ]
)
