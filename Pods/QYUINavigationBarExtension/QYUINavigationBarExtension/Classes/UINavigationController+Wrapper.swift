//
//  UINavigationControllerExtension.swift
//  QYUINavigationBarExtension_Example
//
//  Created by insect on 2021/12/8.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

public extension UINavigationWrapper where Base: UINavigationController {
    
    /// Set the UINavigationBar background to transparent.
    func setIsTransparent(_ isTransparent: Bool) {

        base.setNavigationBarHidden(true, animated: false)
        base.navigationBar.qy.setIsTransparent(isTransparent)
        base.setNavigationBarHidden(false, animated: false)
    }
}
