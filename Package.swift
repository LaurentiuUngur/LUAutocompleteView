// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "LUAutocompleteView",
    platforms: [.iOS(.v13)],
    products: [.library(name: "LUAutocompleteView", targets: ["LUAutocompleteView"])],
    targets: [.target(name: "LUAutocompleteView", path: "Sources")]
)
