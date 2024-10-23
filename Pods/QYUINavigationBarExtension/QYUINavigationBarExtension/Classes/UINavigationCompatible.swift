//
//  UINavigationBarCompatible.swift
//  Scanking
//
//  Created by Scanking on 2021/09/15.
//  Copyright © 2021 Scanking. All rights reserved.
//

import UIKit

public protocol UINavigationCompatible {

    associatedtype T

    var qy: UINavigationWrapper<T> { get }
}

public extension UINavigationCompatible {

    var qy: UINavigationWrapper<Self> {
        return UINavigationWrapper(self)
    }

    static var qy: UINavigationWrapper<Self>.Type {
        return UINavigationWrapper<Self>.self
    }
}

extension UINavigationBar: UINavigationCompatible {}
extension UINavigationController: UINavigationCompatible {}
