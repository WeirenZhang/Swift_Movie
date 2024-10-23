# QYUINavigationBarExtension

A handy collection of UINavigationBar categories.
[![Version](https://img.shields.io/cocoapods/v/QYUINavigationBarExtension.svg?style=flat)](https://cocoapods.org/pods/QYUINavigationBarExtension)
[![License](https://img.shields.io/cocoapods/l/QYUINavigationBarExtension.svg?style=flat)](https://cocoapods.org/pods/QYUINavigationBarExtension)
[![Platform](https://img.shields.io/cocoapods/p/QYUINavigationBarExtension.svg?style=flat)](https://cocoapods.org/pods/QYUINavigationBarExtension)

## Features

One line of code sets the common properties of the UINavigationBar, regardless of version adaptation.

## Objective-C Version

[QYUINavigationBarCategory](https://github.com/InsectQY/QYUINavigationBarCategory)

## Requirements

- iOS 9.0 or later

## How to use

1. Import 

```swift
import QYUINavigationBarExtension
```

2. Set the properties you need

```swift
navigationController?.navigationBar.qy.titleTextAttributes = [.foregroundColor: UIColor.white];
navigationController?.navigationBar.qy.backgroundColor = .white;
navigationController?.navigationBar.qy.backgroundImage = UIImage(named: "")
navigationController?.qy.setIsTransparent(true)
```

## Comment

```swift
/* You may specify the font, text color, and shadow properties for the title in the text attributes dictionary, using the keys found in NSAttributedString.h.
     */
var titleTextAttributes: [NSAttributedString.Key : Any]

/// A color to use for the bar background.
var backgroundColor: UIColor?

/// An image to use for the bar background.
var backgroundImage: UIImage?

/// Set the UINavigationBar background to transparent.
func setIsTransparent(_ isTransparent: Bool)
```

## Installation

```ruby
pod 'QYUINavigationBarExtension'
```

## License

QYUINavigationBarExtension is available under the MIT license. See the LICENSE file for more info.
