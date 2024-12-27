import PackageDescription

let package = Package(
    name: "ClipboardApp",
    platforms: [
        .macOS(.v12)
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "ClipboardApp",
            dependencies: [],
            path: "Sources/ClipboardApp",
            swiftSettings: [
                .unsafeFlags(["-parse-as-library"]) // Allow `@main` attribute in SwiftUI
            ]
        )
    ]
)
