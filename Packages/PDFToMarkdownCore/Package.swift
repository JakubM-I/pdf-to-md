// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "PDFToMarkdownCore",
    platforms: [.macOS(.v26)],
    products: [
        .library(name: "PDFToMarkdownCore", targets: ["PDFToMarkdownCore"]),
    ],
    targets: [
        .target(name: "PDFToMarkdownCore"),
        .testTarget(
            name: "PDFToMarkdownCoreTests",
            dependencies: ["PDFToMarkdownCore"]
        ),
    ]
)
