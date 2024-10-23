//
//  EmptyDataSetConfig.swift
//  EmptyDataSetConfig
//
//  Created by Insect on 2021/3/26.
//  Copyright © 2021 Insect. All rights reserved.
//

import UIKit

open class EmptyDataSetConfig {
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
    open var isLoading: Bool = false {
        didSet {
            if oldValue == isLoading {
                return
            }
            valueChanged?()
        }
    }

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

    public init(title: NSAttributedString? = nil,
                detail: NSAttributedString? = nil,
                image: UIImage? = nil,
                imageTintColor: UIColor? = nil,
                imageAnimation: CAAnimation? = nil,
                buttonTitle: [UIControlState: NSAttributedString?]? = nil,
                buttonImage: [UIControlState: UIImage?]? = nil,
                buttonBackgroundImage: [UIControlState: UIImage?]? = nil,
                backgroundColor: UIColor? = nil,
                customView: UIView? = nil,
                verticalOffset: CGFloat = 0,
                spaceHeight: CGFloat = 11,
                isFadeIn: Bool = true,
                isBeForcedToDisplay: Bool = false,
                isDisplay: Bool = true,
                isAllowTouch: Bool = true,
                isAllowScroll: Bool = false,
                isAnimateImageView: Bool = true,
                didTapView: (() -> Void)? = nil,
                didTapButton: (() -> Void)? = nil,
                willAppear: (() -> Void)? = nil,
                didAppear: (() -> Void)? = nil,
                willDisappear: (() -> Void)? = nil,
                didDisappear: (() -> Void)? = nil) {

        self.title = title
        self.detail = detail
        self.image = image
        self.imageTintColor = imageTintColor
        self.imageAnimation = imageAnimation
        self.buttonTitle = buttonTitle
        self.buttonImage = buttonImage
        self.buttonBackgroundImage = buttonBackgroundImage
        self.backgroundColor = backgroundColor
        self.customView = customView
        self.verticalOffset = verticalOffset
        self.spaceHeight = spaceHeight
        self.isFadeIn = isFadeIn
        self.isBeForcedToDisplay = isBeForcedToDisplay
        self.isDisplay = isDisplay
        self.isAllowTouch = isAllowTouch
        self.isAllowScroll = isAllowScroll
        self.isAnimateImageView = isAnimateImageView
        self.didTapView = didTapView
        self.didTapButton = didTapButton
        self.willAppear = willAppear
        self.didAppear = didAppear
        self.willDisappear = willDisappear
        self.didDisappear = didDisappear

        proxy = EmptyDataSetProtocolProxy(config: self)
    }

    var valueChanged: (() -> Void)?

    var proxy: EmptyDataSetProtocolProxy?
}
