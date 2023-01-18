// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TweetieFeed",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "TweetieFeed",
            targets: ["TweetieFeed"]),
    ],
    dependencies: [
        .package(
            name: "AttributedText",
            url: "https://github.com/gonzalezreal/AttributedText",
            from: "1.0.1"
        ),
    ],
    targets: [
        .target(
            name: "TweetieFeed",
            dependencies: ["AttributedText"]),
        .testTarget(
            name: "TweetieFeedTests",
            dependencies: ["TweetieFeed"]),
    ]
)
