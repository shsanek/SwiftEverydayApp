// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftEverydayApp",
    products: [
        .library(
            name: "SwiftEverydayApp",
            targets: ["SwiftEverydayApp"]),
    ],
    targets: [
        .target(
            name: "SwiftEverydayApp"),
        .testTarget(
            name: "SwiftEverydayAppTests",
            dependencies: ["SwiftEverydayApp"]),
    ]
)
