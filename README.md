<p align="center" >
    <img src="ReadmeIcon.png" title="Title image" float=center width=300>
</p>

# LUAutocompleteView
Easy to use and highly configurable autocomplete view that is attachable to any `UITextField`

[![Build Status](http://img.shields.io/travis/LaurentiuUngur/LUAutocompleteView/master.svg?style=flat)](https://travis-ci.org/LaurentiuUngur/LUAutocompleteView)
![Swift 4](https://img.shields.io/badge/Swift-4-yellow.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![Pod Version](http://img.shields.io/cocoapods/v/LUAutocompleteView.svg?style=flat)](https://cocoapods.org/pods/LUAutocompleteView/)
![Pod Platform](http://img.shields.io/cocoapods/p/LUAutocompleteView.svg?style=flat)
[![Pod License](http://img.shields.io/cocoapods/l/LUAutocompleteView.svg?style=flat)](https://opensource.org/licenses/MIT)

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ sudo gem install cocoapods
```

> CocoaPods 1.4.0+ is required.

To integrate `LUAutocompleteView` into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'LUAutocompleteView'
end
```

Then, run the following command:

```bash
$ pod install
```

### Carthage

You can use [Carthage](https://github.com/Carthage/Carthage) to install `LUAutocompleteView` by adding it to your `Cartfile`:

```
github "LaurentiuUngur/LUAutocompleteView" ~> 2.0
```

Then run `carthage update`.

If this is your first time using Carthage in the project, you'll need to go through some additional steps as explained [over at Carthage](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application).

### Swift Package Manager

To integrate using Apple's [Swift Package Manager](https://swift.org/package-manager), add the following as a dependency to your `Package.swift`:

```Swift
.Package(url: "https://github.com/LaurentiuUngur/LUAutocompleteView", majorVersion: 2)
```

Here's an example of `PackageDescription`:

```Swift
import PackageDescription

let package = Package(name: "MyApp",
    dependencies: [
        .Package(url: "https://github.com/LaurentiuUngur/LUAutocompleteView", majorVersion: 1)
    ])
```

### Manually

If you prefer not to use either of the before mentioned dependency managers, you can integrate `LUAutocompleteView` into your project manually.

## Usage

* Import `LUAutocompleteView` into your project.

```Swift
import LUAutocompleteView
```
* Assign to `textField` property the text field to which the autocomplete view you want be attached.

```Swift
autocompleteView.textField = textField
```

* Set as data source and delegate.

```Swift
autocompleteView.dataSource = self
autocompleteView.delegate = self
```

* Implement `LUAutocompleteViewDataSource` and `LUAutocompleteViewDelegate` protocols.

````Swift
// MARK: - LUAutocompleteViewDataSource

extension ViewController: LUAutocompleteViewDataSource {
    func autocompleteView(_ autocompleteView: LUAutocompleteView, elementsFor text: String, completion: @escaping ([String]) -> Void) {
        let elementsThatMatchInput = elements.filter { $0.lowercased().contains(text.lowercased()) }
        completion(elementsThatMatchInput)
    }
}

// MARK: - LUAutocompleteViewDelegate

extension ViewController: LUAutocompleteViewDelegate {
    func autocompleteView(_ autocompleteView: LUAutocompleteView, didSelect text: String) {
        print(text + " was selected from autocomplete view")
    }
}
````

## Customisation

* Create your custom autocomplete cell by subclassing `LUAutocompleteTableViewCell`.
* Override `func set(text: String)` from `LUAutocompleteTableViewCell` that is called every time when given text should be displayed by the cell.

````Swift
import UIKit
import LUAutocompleteView

final class CustomAutocompleteTableViewCell: LUAutocompleteTableViewCell {
    // MARK: - Base Class Overrides

    override func set(text: String) {
        textLabel?.text = text
        textLabel?.textColor = .red
    }
}
````

* Assign to `autocompleteCell` property your custom autocomplete cell.

```Swift
autocompleteView.autocompleteCell = CustomAutocompleteTableViewCell.self
```

### For more usage details please see example app

## Requirements

- Xcode 9.0+
- Swift 4.0+
- iOS 9.0+

## Author
- [Laurentiu Ungur](https://github.com/LaurentiuUngur)

## License
- LUAutocompleteView is available under the [MIT license](LICENSE).
