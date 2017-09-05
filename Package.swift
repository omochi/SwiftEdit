// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftEdit",
    products: [
        .executable(name: "swift-edit", targets: ["swift-edit"]),
        .library(name: "SwiftEditFramework", targets: ["SwiftEditFramework"])
    ],
    dependencies: [
        .package(url: "https://github.com/jpsim/SourceKitten.git", from: "0.18.1")
    ],
    targets: [
        .target(
            name: "swift-edit",
            dependencies: ["SwiftEditFramework"]
        ),
        .target(
            name: "SwiftEditFramework",
            dependencies: [
                "SourceKittenFramework"
            ]
        )
    ]
)
