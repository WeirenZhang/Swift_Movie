# EmptyDataSetExtension

[![Version](https://img.shields.io/cocoapods/v/EmptyDataSetExtension.svg?style=flat)](https://cocoapods.org/pods/EmptyDataSetExtension)
[![License](https://img.shields.io/cocoapods/l/EmptyDataSetExtension.svg?style=flat)](https://cocoapods.org/pods/EmptyDataSetExtension)
[![Platform](https://img.shields.io/cocoapods/p/EmptyDataSetExtension.svg?style=flat)](https://cocoapods.org/pods/EmptyDataSetExtension)

EmptyDataSetExtension is a [DZNEmptyDataSet](https://github.com/dzenbot/DZNEmptyDataSet) enhancement. It provides object property to replace the emptyDataSetSource and emptyDataSetDelegate. 

It also support RxSwift.

## Requirements

Swift 5.0+

iOS 8+

## How to use

### Init

1. Initialize the EmptyDataSetConfig object

```swift
let config = EmptyDataSetConfig()
```

2. Invoke `setConfig` of UIScrollView or its subclass and activite emptyDataSet.

```swift
scrollView.emptyDataSet.setConfig(config)
scrollView.emptyDataSet.run()
```

or: 

```swift
scrollView.emptyDataSet.setConfigAndRun(config)
```

then it will work.

### Force layout update

```swift
scrollView.emptyDataSet.reload()
```

You can also call `scrollView.emptyDataSet.reload()` to invalidate the current empty state layout and trigger a layout update, bypassing `reloadData`. This might be useful if you have a lot of logic on your data source that you want to avoid calling, when not needed. 

### Stop

```swift
scrollView.emptyDataSet.stop()
```

## EmptyDataSetConfig

```swift
/// The title of the dataset.
/// The dataset uses a fixed font style by default, if no attributes are set. If you want a different font style, return a attributed string.
open var title: NSAttributedString?

/// The description of the dataSet.
/// The dataset uses a fixed font style by default, if no attributes are set. If you want a different font style, return a attributed string.
open var detail: NSAttributedString?

/// An image of the dataset.
open var image: UIImage?

/// A tint color of the image dataset.
/// Default is nil.
open var imageTintColor: UIColor?

/// The image animation of the dataset.
open var imageAnimation: CAAnimation?

/// The title to be used for the specified button state.
/// The dataset uses a fixed font style by default, if no attributes are set. If you want a different font style, return a attributed string.
open var buttonTitle: [UIControlState: NSAttributedString?]?

/// The image to be used for the specified button state.
/// This closure will override buttonTitleForEmptyDataSet:forState: and present the image only without any text.
open var buttonImage: [UIControlState: UIImage?]?

/// A background image to be used for the specified button state.
/// There is no default style for this call.
open var buttonBackgroundImage: [UIControlState: UIImage?]?

/// The background color of the dataset.
/// Default is clear color.
open var backgroundColor: UIColor?

/// A custom view to be displayed instead of the default views such as labels, imageview and button.
/// Default is nil.
open var customView: UIView?

/// Vertical alignment of the content.
/// Default is 0.
open var verticalOffset: CGFloat = 0

/// A vertical space between elements.
/// Default is 11 pts.
open var spaceHeight: CGFloat = 11

/// The empty dataset should fade in when displayed.
/// Default is true.
open var isFadeIn: Bool = true

/// if the empty dataset should still be displayed when the amount of items is more than 0.
/// Default is false.
open var isBeForcedToDisplay: Bool = false

/// The rendered and displayed permission of the empty dataset.
/// Default is true.
open var isDisplay: Bool = true

/// The rendered and displayed permission of the empty dataset.
/// Use it when you are doing some time-consuming operation.
/// Like this:
/// isLoading = true
/// do something...
/// isLoading = false
/// Default is false.
open var isLoading: Bool = false

/// The touch permission of the empty dataset .
/// Default is true.
open var isAllowTouch: Bool = true

/// The scroll permission of the empty dataset.
/// Default is false.
open var isAllowScroll: Bool = false

/// The animation permission of the dataset image view.
/// Default is false.
open var isAnimateImageView: Bool = true

/// The empty dataset view was tapped.
/// Use this closure either to resignFirstResponder of a textField or searchBar.
open var didTapView: (() -> Void)?

/// The action button was tapped.
open var didTapButton: (() -> Void)?

/// The empty data set will appear.
open var willAppear: (() -> Void)?

/// The empty data set did appear.
open var didAppear: (() -> Void)?

/// The empty data set will disappear.
open var willDisappear: (() -> Void)?

/// The empty data set did disappear.
open var didDisappear: (() -> Void)?
```

## RxSwift support

```swift
/// The title of the dataset.
/// The dataset uses a fixed font style by default, if no attributes are set. If you want a different font style, return a attributed string.
var title: Binder<NSAttributedString?>

/// The description of the dataSet.
/// The dataset uses a fixed font style by default, if no attributes are set. If you want a different font style, return a attributed string.
var detail: Binder<NSAttributedString?>
/// An image of the dataset.
var image: Binder<UIImage?>

/// A tint color of the image dataset.
/// Default is nil.
var imageTintColor: Binder<UIColor?> 

/// The image animation of the dataset.
var imageAnimation: Binder<CAAnimation?>

/// The title to be used for the specified button state.
/// The dataset uses a fixed font style by default, if no attributes are set. If you want a different font style, return a attributed string.
var buttonTitle: Binder<[UIControlState: NSAttributedString?]?>
/// The image to be used for the specified button state.
/// This closure will override buttonTitleForEmptyDataSet:forState: and present the image only without any text.
var buttonImage: Binder<[UIControlState: UIImage?]?>

/// A background image to be used for the specified button state.
/// There is no default style for this call.
var buttonBackgroundImage: Binder<[UIControlState: UIImage?]?>

/// The background color of the dataset.
/// Default is clear color.
var backgroundColor: Binder<UIColor?>

/// A custom view to be displayed instead of the default views such as labels, imageview and button.
/// Default is nil.
var customView: Binder<UIView?>

/// Vertical alignment of the content.
/// Default is 0.
var verticalOffset: Binder<CGFloat>

/// A vertical space between elements.
/// Default is 11 pts.
var spaceHeight: Binder<CGFloat>

/// The empty dataset should fade in when displayed.
/// Default is true.
var isFadeIn: Binder<Bool>

/// if the empty dataset should still be displayed when the amount of items is more than 0.
/// Default is false.
var isBeForcedToDisplay: Binder<Bool> 

/// The rendered and displayed permission of the empty dataset.
/// Default is true.
var isDisplay: Binder<Bool> 

/// The rendered and displayed permission of the empty dataset.
/// Use it when you are doing some time-consuming operation.
/// Like this:
/// isLoading = true
/// do something...
/// isLoading = false
/// Default is false.
var isLoading: Binder<Bool>

/// The touch permission of the empty dataset .
/// Default is true.
var isAllowTouch: Binder<Bool> 

/// The scroll permission of the empty dataset.
/// Default is false.
var isAllowScroll: Binder<Bool> 

/// The animation permission of the dataset image view.
/// Default is false.
var isAnimateImageView: Binder<Bool>

/// The empty dataset view was tapped.
/// Use this closure either to resignFirstResponder of a textField or searchBar.
var didTapView: ControlEvent<Void>

/// The action button was tapped.
var didTapButton: ControlEvent<Void> 

/// The empty data set will appear.
var willAppear: ControlEvent<Void> 

/// The empty data set did appear.
var didAppear: ControlEvent<Void> 

/// The empty data set will disappear.
var willDisappear: ControlEvent<Void> 

/// The empty data set did disappear.
var didDisappear: ControlEvent<Void>
```

## Installation

**CocoaPods**

```ruby
pod 'EmptyDataSetExtension'
```

RxSwift support

```ruby
pod 'EmptyDataSetExtension/RxSwift'
```

## License

EmptyDataSetExtension is available under the MIT license. See the LICENSE file for more info.
