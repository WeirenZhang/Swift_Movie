//
//  UINavigationBarExtension.swift
//  Scanking
//
//  Created by Scanking on 2021/09/15.
//  Copyright © 2021 Scanking. All rights reserved.
//

/// 不包含滚动内容的界面
/// - UINavigationBar UITabBar 的样式由 scrollEdgeAppearance 属性控制
/// - 当 scrollEdgeAppearance 为 nil 时，bar 将变透明

/// 包含滚动内容的界面
/// - 滚动的内容和 bar 没有重叠的时候，采用 scrollEdgeAppearance 属性控制
/// - 滚动的内容和 bar 有重叠的时候，采用 standardAppearance 属性控制

/// iOS 13 ，iOS 14
/// 默认 standardAppearance 为毛玻璃，
/// 默认 scrollEdgeAppearance 为毛玻璃，
/// 因此无论内容是否可以滚动，bar 都是毛玻璃。

/// iOS 15
/// 默认 standardAppearance 为毛玻璃，
/// 默认 scrollEdgeAppearance 为 nil。
/// 因此滚动的内容和 bar 没有重叠时 bar 将变透明，有重叠时变毛玻璃，
/// 没有滚动的内容将变透明。

/// Features:
/// ✅ 使所有系统的 UINavigationBar appearance 属性保持一致

import UIKit

public extension UINavigationWrapper where Base: UINavigationBar {

    /* You may specify the font, text color, and shadow properties for the title in the text attributes dictionary, using the keys found in NSAttributedString.h.
     */
    var titleTextAttributes: [NSAttributedString.Key : Any] {

        set {

            if #available(iOS 13.0, *) {

                standardAppearance.titleTextAttributes = newValue
                setUpAppearance()
            } else {
                base.titleTextAttributes = titleTextAttributes
            }
        }

        get {

            if #available(iOS 13.0, *) {
                return standardAppearance.titleTextAttributes
            } else {
                return base.titleTextAttributes ?? [:]
            }
        }
    }

    /// A color to use for the bar background.
    var backgroundColor: UIColor? {

        set {

            if #available(iOS 13.0, *) {

                standardAppearance.backgroundColor = newValue
                setUpAppearance()
            } else {
                base.barTintColor = backgroundColor
            }
        }

        get {

            if #available(iOS 13.0, *) {
                return standardAppearance.backgroundColor
            } else {
                return base.barTintColor
            }
        }
    }

    /// An image to use for the bar background.
    var backgroundImage: UIImage? {

        set {

            if #available(iOS 13.0, *) {

                standardAppearance.backgroundImage = newValue
                setUpAppearance()
            } else {
                base.setBackgroundImage(backgroundImage, for: .default)
            }
        }

        get {
            if #available(iOS 13.0, *) {
                return standardAppearance.backgroundImage
            } else {
                return base.backgroundImage(for: .default)
            }
        }
    }

    /// Set the UINavigationBar background to transparent.
    func setIsTransparent(_ isTransparent: Bool) {

        if #available(iOS 13.0, *) {

            if isTransparent {
                base.isHidden = true
                standardAppearance.configureWithTransparentBackground()
                base.isHidden = false
            } else {
                standardAppearance.configureWithDefaultBackground()
            }
            setUpAppearance()
        } else {

            let image: UIImage? = isTransparent ? UIImage() : nil
            base.setBackgroundImage(image,
                                    for: .default)
            base.shadowImage = image
        }
    }

     private func setUpAppearance() {
         if #available(iOS 13.0, *) {
             base.standardAppearance = standardAppearance
             base.scrollEdgeAppearance = standardAppearance
         }
    }

    @available(iOS 13.0, *)
    private var standardAppearance: UINavigationBarAppearance {

        let isInit = base.standardAppearance.isKind(of: UINavigationBarAppearance.self)
        if isInit {
            return base.standardAppearance
        } else {
            return UINavigationBarAppearance()
        }
    }
}
