# LabelPicker

[![Build Status](https://travis-ci.org/komaji/LabelPicker.svg?branch=master)](https://travis-ci.org/komaji/LabelPicker)
[![Language](https://img.shields.io/badge/language-Swift%204.0-orange.svg)](https://swift.org)
![Platform](https://img.shields.io/badge/platform-iOS-lightgrey.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/komaji/LabelPicker/blob/master/LICENSE)

LabelPicker is available to add labels for components to UIPickerView.  
Frame of components and labels is calicurated automaticaly from your specified values of items and labels width.

<a href="https://gyazo.com/41ae851edca077bd87f2cea8422781ba"><img src="https://i.gyazo.com/41ae851edca077bd87f2cea8422781ba.png" alt="https://gyazo.com/41ae851edca077bd87f2cea8422781ba" width="375"/></a>

## Usage

```swift
let hours = (0...23).map { "\($0)" }
let min = (0...59).map { "\($0)" }
let sec = (0...59).map { "\($0)" }
let attributes: [NSAttributedStringKey: Any] = [.font: UIFont.systemFont(ofSize: 16.0)]
let components = [
    LabelPickerComponent(items: hours, itemAttributes: attributes, maxItemWidth: 20.0, labelName: "hours", labelAttributes: attributes, labelNameWidth: 50.0),
    LabelPickerComponent(items: min, itemAttributes: attributes, maxItemWidth: 20.0, labelName: "min", labelAttributes: attributes, labelNameWidth: 30.0),
    LabelPickerComponent(items: sec, itemAttributes: attributes, maxItemWidth: 20.0, labelName: "sec", labelAttributes: attributes, labelNameWidth: 30.0),
]

let pickerView = LabelPickerView()
pickerView.rowHeight = 30.0
pickerView.components = components

view.addSubview(pickerView)
```

See [Demo](https://github.com/komaji/LabelPicker/tree/master/Demo) for more info.

## Requirements

- iOS 10.0
- Xcode 9.0
- Swift 4.0

## Installation

### [Carthage](https://github.com/Carthage/Carthage)

Add this to your Cartfile:

```
github "komaji/LabelPicker"
```

Then, run the following command:

```sh
$ carthage update
```

## Lisence

[MIT](https://github.com/komaji/LabelPicker/blob/master/LICENSE)
