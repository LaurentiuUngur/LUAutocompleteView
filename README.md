<p align="center" >
    <img src="Icon.png" title="Title image" float=center width=300>
</p>

# LUAutocompleteView
Easy to use and highly configurable autocomplete view that is attachable to any `UITextField`

[![Build Status](http://img.shields.io/travis/LaurentiuUngur/LUAutocompleteView/master.svg?style=flat)](https://travis-ci.org/LaurentiuUngur/LUAutocompleteView)
[![Pod Version](http://img.shields.io/cocoapods/v/LUAutocompleteView.svg?style=flat)](https://cocoapods.org/pods/LUAutocompleteView/)
![language](https://img.shields.io/badge/Language-Swift3-8E44AD.svg)
![Pod Platform](http://img.shields.io/cocoapods/p/LUAutocompleteView.svg?style=flat)
[![Pod License](http://img.shields.io/cocoapods/l/LUAutocompleteView.svg?style=flat)](https://opensource.org/licenses/MIT)

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ sudo gem install cocoapods
```

> CocoaPods 1.2.0+ is required.

To integrate LUAutocompleteView into your Xcode project using CocoaPods, specify it in your `Podfile`:

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

### Swift Package Manager

To integrate using Apple's [Swift Package Manager](https://swift.org/package-manager), add the following as a dependency to your `Package.swift`:

```Swift
.Package(url: "https://github.com/LaurentiuUngur/LUAutocompleteView", majorVersion: 1)
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

If you prefer not to use either of the before mentioned dependency managers, you can integrate LUAutocompleteView into your project manually.

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

- Xcode 8.3+
- Swift 3.1+
- iOS 9.0+

## Author
- [Laurentiu Ungur](https://github.com/LaurentiuUngur)

## License
- LUAutocompleteView is available under the [MIT license](LICENSE).
